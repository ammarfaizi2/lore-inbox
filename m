Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVC3BjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVC3BjA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 20:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVC3BjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 20:39:00 -0500
Received: from harlech.math.ucla.edu ([128.97.4.250]:8070 "EHLO
	harlech.math.ucla.edu") by vger.kernel.org with ESMTP
	id S261704AbVC3Bi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 20:38:58 -0500
Date: Tue, 29 Mar 2005 17:38:58 -0800 (PST)
From: Jim Carter <jimc@math.ucla.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, hare@suse.de, seife@suse.de
Subject: Re: Disc driver is module, software suspend fails
In-Reply-To: <20050328221922.GD1389@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0503291724030.7677@xena.cft.ca.us>
References: <Pine.LNX.4.61.0503242248530.7785@xena.cft.ca.us>
 <20050325081438.GA17245@elf.ucw.cz> <Pine.LNX.4.61.0503271623150.5513@xena.cft.ca.us>
 <20050328221922.GD1389@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005, Pavel Machek wrote:

> You insmod driver for your swap device, then you echo device numbers
> to /sys... then initiate resume.

So you're saying, let the machine come all the way up, log in as root, 
"echo 8:5 > /sys/power/resume" (I think that was the name), then "echo 
resume > /sys/power/state"?  Hmm, you would have to bypass "swapon -a",
e.g. boot with the -b kernel parameter.  

Or I'll bet one could do something equivalent in the initrd -- much more 
user friendly.  But the friendliest of all would be if the swsusp resume 
call were not a late_initcall but rather were called just before the root 
was mounted, after the initrd (if any) had loaded whatever modules.  I 
think you're confirming that that approach would not blow up the kernel -- 
if it will work with the root mounted and user space in full roar (well, 
skimpy roar with the -b switch), then it's got to be OK at the earlier 
time.

I'll see what I can do.


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
