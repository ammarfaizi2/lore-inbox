Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUJ3S5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUJ3S5g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUJ3S5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:57:36 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:47003 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261244AbUJ3S5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:57:33 -0400
Date: Sat, 30 Oct 2004 19:57:27 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Adrian Bunk <bunk@stusta.de>
cc: linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] some NTFS cleanups
In-Reply-To: <20041030180304.GR4374@stusta.de>
Message-ID: <Pine.LNX.4.60.0410301933300.3786@hermes-1.csi.cam.ac.uk>
References: <20041030180304.GR4374@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

>From a quick read of your patch:

On Sat, 30 Oct 2004, Adrian Bunk wrote:
> The patch below does the following cleanups for the NTFS code:
> - remove three currently unused global functions

Assuming these are the functions in unistr.c then they need to stay.  We 
are not using them yet but we will when we start creating/deleting files 
and things like that.

> - make several functions and variables static (yes, I've read the

Most of those look good, again except the entirety of unistr.c where we 
will be using those functions later on.  Admittedly we can make them 
static for now and undo each as it gets a user outside of unistr.c.

>   comment before ntfs_readpage before making it static - but I couldn't
>   see it being actually true)

Yes, it was used until a few patches ago - I rewrote mft record writing 
code so I no longer needed to define a separate address space ops for 
$MFT/$DATA access.  I had forgotten about this so the comment was out of 
date and the function definitely can be made static now.

> Is this patch OK or does it conflict with your future plans for the NTFS 
> code?

Mostly it is fine; great in fact.  I will apply it to the ntfs-2.6-devel 
tree on Monday but I will leave the three functions you have taken out in.  
If you want send me a new patch with the three functions left in before 
Monday and I can apply it as is.  (-:

Thanks for your work!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
