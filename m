Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbVKQOhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbVKQOhr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 09:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbVKQOhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 09:37:47 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:13237 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750919AbVKQOhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 09:37:46 -0500
Date: Thu, 17 Nov 2005 09:37:45 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: hware clock left bad after a system failure
In-reply-to: <437C8D67.2030806@eyal.emu.id.au>
To: linux-kernel@vger.kernel.org
Message-id: <200511170937.45384.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <437B3C62.2090803@eyal.emu.id.au>
 <Pine.LNX.4.61.0511170822590.7964@chaos.analogic.com>
 <437C8D67.2030806@eyal.emu.id.au>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 November 2005 09:02, Eyal Lebedinsky wrote:
>linux-os (Dick Johnson) wrote:
>> On Wed, 16 Nov 2005, Eyal Lebedinsky wrote:
>
>[report of hwclock breakage trimmed]
>
>> If your machine was being heavily swapped when the disk problems
>> occurred, this __might__ explain the corruption. However, I would
>> first check RAM, do not overclock, etc. It might be that bad
>> RAM, in fact, is the reason for all your problems and you don't
>> really have disk or driver problems at all.
>
>I will now keep watching for q while quietly. Earlier today I had
>another such hard lockup, identical errors claiming a disk failure.
>
>This time I went into the BIOS on bootup and the clock was set
>correctly. Good. Booted and it did the usual fscks but then dropped
>into a shell when errors were found on /. I did the necessary fscks.
>
>On a hunch I did 'date' and the clock was 11h ahead (we actually
>are +11 now). So the problem is during the boot, not during the
>crash. I consider that the boot thinks that I am running a UTC
>hwclock and adjusts for this, when in fact I run a local time
>hwclock. There must be something in the scripts that goes funny
>if / does an fsck and then drops into the recovery shell.
>
>I will start looking in this direction.
>
>This is Debian Sarge in x86.
>
>Thanks

Thanks for looking into this.  It has been exactly the PITA the
original poster described for me, for years on all distro's.

It seems the scenario is that if everything is on local time, its not a
problem, but if the system is set to run its hardware clock on grenwich
time, a crash leaves the hw clock afu because its on local time at the
reboot init.

I did something to my init script to quasi-fix this years ago, fix now
lost in the sands of time as this FC2 install is truely long in the
tooth now.  But it works, so I don't fix it. :)

I *think* the problem is that the assumption of grenwich time is only
at boot, and shutdown times.  At boot, I believe the hw clock is reset
to local time after getting the time reference from it, and at shutdown
its reset to grenwich. So a crash recovery finds it on local time but
assumes its grenwich & the result is a predictable mess.

If thats the case, then IMNSHO, the hw clock should ALWAYS be on
grenwich time.  This needless twiddling is rather counter-productive.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.


