Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUITAFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUITAFQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 20:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUITAFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 20:05:16 -0400
Received: from lakermmtao06.cox.net ([68.230.240.33]:4836 "EHLO
	lakermmtao06.cox.net") by vger.kernel.org with ESMTP
	id S265051AbUITAFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 20:05:05 -0400
In-Reply-To: <414DE099.8040202@softhome.net>
References: <414C9003.9070707@softhome.net> <1095568704.6545.17.camel@gaston> <414D42F6.5010609@softhome.net> <20040919140034.2257b342.Ballarin.Marc@gmx.de> <414D96EF.6030302@softhome.net> <20040919171456.0c749cf8.Ballarin.Marc@gmx.de> <414DE099.8040202@softhome.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B92BD88B-0A98-11D9-A50B-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: benh@kernel.crashing.org, Marc Ballarin <Ballarin.Marc@gmx.de>,
       greg@kroah.com, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: udev is too slow creating devices
Date: Sun, 19 Sep 2004 20:05:04 -0400
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 19, 2004, at 15:40, Ihar 'Philips' Filipau wrote:
>   You are wrong. Hardware driver must fail, when hardware is not 
> present/not detected. Simple as that.
>   If ide-cd doesn't do that - it needs to be fixed.

I have a USB CD burner, and during startup I make sure that the USB
and SCSI modules are already loaded to speed up the CD recognition.
With your procedure I _can't_ do that.  First I try to modprobe the USB
stuff, which works. Then I try to modprobe the SCSI stuff, which 
doesn't,
because the burner isn't plugged in yet and it sees no SCSI devices.

How does that make sense?  Hardware is not serialized nicely the
way you seem to want it to be.  I expect to be able to plug in my 2 USB
disks, my USB burner, and my USB scanner into the USB hub that I
just plugged in, either before turning on the computer, halfway through
startup, or after I've been working for 2 hours and not have the whole
damn mess fail because one of the devices is _only_ initialized in the
init scripts.  The best way to handle this is /etc/dev.d.  If some 
system
is critical for startup, then just add a "touch 
/var/run/criticalsystem" to
the specialized dev.d script and then have the init script poll for said
file to become more recent than system startup.  It's not like polling
will hurt you in that case, if the device really is system-critical 
then you
can't do anything _but_ poll and hope that the hardware isn't fubared.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


