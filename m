Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423329AbWJaOGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423329AbWJaOGL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 09:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423336AbWJaOGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 09:06:11 -0500
Received: from rtr.ca ([64.26.128.89]:49168 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1423329AbWJaOGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 09:06:10 -0500
Message-ID: <4547584F.6000702@rtr.ca>
Date: Tue, 31 Oct 2006 09:06:07 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 is problematic in VMware
References: <Pine.LNX.4.61.0610290953010.4585@yvahk01.tjqt.qr> <45463B7D.8050002@vmware.com> <Pine.LNX.4.61.0610310857280.23540@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0610310857280.23540@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>> I have observed a strange slowdown with the 2.6.18 kernel in VMware. This
>>> happened both with the SUSE flavor and with the FC6 installer CD (which I
>>> am trying right now). In both cases, the kernel "takes its time" after the
>>> following text strings:
>>>
>>> * Checking if this processor honours the WP bit even in supervisor mode...
>>> Ok.
>>> * Checking 'hlt' instruction... OK.
>>>
>>> What's with that?
>> Thanks.  It is perhaps the jiffies calibration taking a while because of the
>> precise timing loop.  Are you reasonably confident that it is a regression in
>> performance over 2.6.17?
> 
> Yes. I am not exactly sure if it's something in jiffies calibration 
> (because of the 'WP bit/supervisor' thing too), so maybe I thought it 
> was the newly-introduced SMP alternatives. I gotta check that.
> 
>> The boot sequence is pretty complicated, and a lot of
>> it is difficult / slow to virtualize, so it could just be alternate timing
>> makes the boot output appear to stall, when in fact the raw time is still about
>> the same.  I will run some experiments.
> 
> Booting with 'time' shows that the virtual time increases as usual, i.e.
> 
> [ 9.00] checking if wp bit...
> [15.00] next message here

My experience with VMware on several recent processors (mostly P-M family)
is that it crawls unless I force this first:
      echo 1 > /sys/module/processor/parameters/max_cstate

So I use a wrapper script around VMware (workstation) to save max_cstate,
set it to 1, and restore it again on exit.

Cheers
