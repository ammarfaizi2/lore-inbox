Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbTIVAxA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 20:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbTIVAxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 20:53:00 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:1164 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262681AbTIVAw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 20:52:58 -0400
Message-ID: <3F6E493B.7070901@pacbell.net>
Date: Sun, 21 Sep 2003 17:58:35 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg KH <greg@kroah.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: USB APM suspend
References: <Pine.LNX.4.44L0.0309191755590.763-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0309191755590.763-100000@ida.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> Here's a piece from my system log, when I did "apm --suspend".  The 
> usb_device_suspend/resume messages are things I added for debugging.

That's progress ... last time I tried APM on 2.6 it failed horribly.
(This was after working fine until recently.)


> Why was this routine called twice?  (Don't be fooled by the timestamps; I 
> think the "suspend D4 --> D3" message was created during the suspend but 
> not read by syslogd until after the resume.)

That's happened for as long as I remember (2.4 also).
Still seems buglike to me, maybe 2.6 will finally squish it...

> Why doesn't usb_hcd_pci_resume() log a similar message when it is called?
> A simple oversight?

You mean, why didn't it announce its first resume?  Basically, yes.

> Why was the host controller suspended _before_ its child USB devices?  

Seems buglike to me, with the first call being wrong (before the
children were suspended) and the second being right (after).

> And why was it woken up twice?

The converse of the "suspended-twice" problem:  first call right,
second call (after children) wrong.

- Dave



