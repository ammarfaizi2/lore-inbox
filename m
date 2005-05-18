Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVERPP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVERPP4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVERPOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:14:00 -0400
Received: from alog0356.analogic.com ([208.224.222.132]:36521 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262226AbVERPLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:11:40 -0400
Date: Wed, 18 May 2005 11:11:00 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Max Kellermann <max@duempel.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Detecting link up
In-Reply-To: <20050518143712.GA21883@roonstrasse.net>
Message-ID: <Pine.LNX.4.61.0505181102420.17255@chaos.analogic.com>
References: <428B1A60.6030505@inescporto.pt> <20050518134031.53a3243a@phoebee>
 <20050518143712.GA21883@roonstrasse.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005, Max Kellermann wrote:

> On 2005/05/18 13:40, Martin Zwickel <martin.zwickel@technotrend.de> wrote:
>> On Wed, 18 May 2005 11:35:12 +0100
>> Filipe Abrantes <fla@inescporto.pt> bubbled:
>>> I need to detect when an interface (wired ethernet) has link up/down.
>>> Is  there a system signal which is sent when this happens? What is the
>>> best  way to this programatically?
>>
>> mii-tool?
>
> A thought on a related topic:
>
> When a NIC driver knows that there is no link, why does it even try to
> transmit a packet? It could return immediately with an error code,
> without applications having to wait for a timeout.
>
> (I had a quick peek at two drivers, and they don't check the link
> status)
>
> Max

The driver(s) don't transmit directly. They put data into a buffer,
usually a ring. The hardware will (depends upon the type) try to
transmit up to 16 times, anything at the current buffer location.
This allows hardware, not software, to try to get a packet on the
wire. The wire can become active or inactive at any time. Usually
the driver correctly assumes that the packet will eventually get
out. If it doesn't, upper levels will send it again. Note that
this is Ethernet, a noisy channel, sh* happens. If the protocol
is connection oriented, the data will be retried forever in an
attempt to get it through. Otherwise, the data is just dropped
on the floor. That's how networking works. You don't waste
valuable CPU resources checking to see if data got onto a wire
when it might get trashed later anyway.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
