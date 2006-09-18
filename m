Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965649AbWIRKiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965649AbWIRKiu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 06:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965648AbWIRKiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 06:38:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:51839 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965649AbWIRKis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 06:38:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ImvbeAuF9HJeak91D/tXmZW/r034FKhtHtvHQF9wcj4E6D19eNpYofp/rzTp3JINsmgifTjyeEPL9nsovtodhLM5zgvAt1W3epF9TetJ0g1CwNcl0XzdMnHeFouycthRLrhK8zIwgd1RKEtvUaERT6jdxkCvMfFpqY9BUqDtN4w=
Message-ID: <450E771E.1070207@gmail.com>
Date: Mon, 18 Sep 2006 19:38:22 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: SATA powersave patches
References: <20060908110346.GC920@elf.ucw.cz> <45015767.1090002@gmail.com> <20060908123537.GB17640@elf.ucw.cz> <4501655F.5000103@gmail.com> <20060910224815.GC1691@elf.ucw.cz> <4505394F.6060806@gmail.com> <20060918100548.GJ3746@elf.ucw.cz>
In-Reply-To: <20060918100548.GJ3746@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Pavel Machek wrote:
>> Can you check if there is any difference between [D/H]IPS and static? 
>> ICH6M on my notebook can't do DIPS/HIPS, so I couldn't compare them 
>> against static.
> 
> What is D/HIPS? I could not find anything relevant..

D/HIPS stand for device/host initiated power saving.  These modes use 
two SATA link powersaving state (partial and slumber).  Static mode 
simply turns off PHY on unoccupied port using SControl register.  So, if 
you have an access to a notebook which has a SATA dock which support 
link powersaving, you can test it by...

* set link powersaving mode to HIPS/static. (mode 4)

* w/ device inserted, leave it idle for 15 seconds and record power 
consumption level (link should be in slumber state).

* pull out the device, wait for libata to detach the device and record 
power consumption level (libata should have turned off PHY after 
detaching the device).

I wanna know whether there is any difference in the amount of power 
saved between slumber and off states.

>>> It would be great to be able to power SATA
>>> controller down, then power it back up when it is needed... I tried
>>> following hack, but could not get it to work. Any ideas?
>> 1. One way to do it would be by dynamic power management.  It would be 
>> nice to have wake-up mechanism at the block layer.  Idle timer can run 
>> in the block layer or it can be implemented in the userland.
>>
>> ATM, this implies that the attached devices are powered down too 
>> (spindown).  As spinning up takes quite some time, we can implement 
> 
> For now, powering down controller when disks are spinned down would be
> very nice first step.

Yeap.

> When I forced disk to be spinned down (with power/state file)
> controller actually survived power down/power up... unfortunately with
> so long delay (~30 sec) that it is not usable in practice.

Can you describe what you've done in more detail?  Do you have dmesg of 
the 30sec wait?

>> So, I think option #1 is the way to go - implementing leveled dynamic 
>> power management infrastructure and adding support in the block layer. 
>> What do you think?
> 
> Would be nice :-).

So, do you think we're ready for another PM infrastructure update?  :-P

-- 
tejun
