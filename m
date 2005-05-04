Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVEDBLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVEDBLR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 21:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVEDBLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 21:11:16 -0400
Received: from harlech.math.ucla.edu ([128.97.4.250]:42383 "EHLO
	harlech.math.ucla.edu") by vger.kernel.org with ESMTP
	id S261993AbVEDBLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 21:11:12 -0400
Date: Tue, 3 May 2005 18:11:10 -0700 (PDT)
From: Jim Carter <jimc@math.ucla.edu>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disc driver is module, software suspend fails
In-Reply-To: <20050414204207.GG2801@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0505031759460.5750@xena.cft.ca.us>
References: <Pine.LNX.4.61.0504101612240.10130@xena.cft.ca.us>
 <20050413100756.GK1361@elf.ucw.cz> <Pine.LNX.4.61.0504141023240.6214@simba.math.ucla.edu>
 <20050414204207.GG2801@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2005, Pavel Machek wrote:
> > 1.  If the initrd mounted any filesystem read-write, or any journalled 
> > filesystem, and left it mounted, that would be bad.
> 
> Yes. (Note that mounting in the first place is the problem. Even if
> you umount it, you already did some changes on disk, BAD).

(additional points snipped)

I've been quiet for the last few weeks because I've been installing and 
working on SuSE 9.3.  Kernel 2.6.11.4 has a fatal problem blamed on the 
SATA driver (see below), but with 2.6.12-rc3, software suspend has been 
reliable for me, with the initrd ending in "echo resume > 
/sys/power/state".

I've come to agree with your position, that if the initrd runs then there 
must be a positive action (like echo resume...) in the initrd.  The kernel 
should not try to clean up and resume by itself, because the initrd could 
have done anything.  Think of the SuSE rescue initrd.  

There are only two rough edges: /sys/power/disk seems to change randomly to 
"reboot", whereupon the BIOS reboots from the original boot disc, not going 
through Grub or whatever is in the MBR.  If you echo shutdown > 
/sys/power/disk just before every suspend, it's a lot more reliable.  The 
other item involves the SATA driver and I'll copy you on that message.

Thank you very much for working on software suspend.  I use the feature a 
lot on my laptop and it greatly adds to the convenience of the O.S.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
