Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267089AbTGGPv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 11:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267083AbTGGPvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 11:51:47 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:16521 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S267075AbTGGPu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 11:50:56 -0400
Message-ID: <3F099B3B.9050804@pacbell.net>
Date: Mon, 07 Jul 2003 09:09:31 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: "Ilia A. Petrov" <masmas@mcst.ru>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] PROBLEM: when booting from USB-HDD device kernel
 2.4.21 is trying to mount root file system too early before usb device is
 found on the usb-bus
References: <3F056D0D.3050101@mcst.ru> <3F05A4C8.9060604@pacbell.net> <3F093B60.1010001@mcst.ru>
In-Reply-To: <3F093B60.1010001@mcst.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ilia A. Petrov wrote:
> David Brownell wrote:
>> Ilia A. Petrov wrote:
>>
>>> When kernel is mounting root file system it is doing it too fast so 
>>> usb-support have not ime to scan bus for mass-storage devices and 
>>> connect them.
>>> ...
>>> or, imho better way, - when completing init of usb bus, first scans 
>>> it and connect all devices and only after all devices were connected 
>>> returns to main kernel code.
>>
>>
>>
>> That might not entirely solve the problem, since the relevant device
>> could drop off the bus temporarily, but it seems like it'd be a step
>> forward.  How would you make root hub ("bus") initialization do that?
> 
> 
> i'm not familiar with linux usb implementation so may be it's wrong:
> after sending global reset over the bus you can manually check (not 
> trough the hub driver) root port connection status and call enumeration 
> if needed.

I had in mind an explanation that works with "patch -p1" ... :)

There's already a call to register a root hub.  It'd be dangerous
to have some other thread try to share responsibilities with khubd,
so that call would likely need to be modified.  (Although there's
been a bit of discussion about actually getting rid of that specific
single-point-of-failure, since not all hub operations need to be
serialized.)

- Dave




