Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWCPWfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWCPWfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWCPWfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:35:42 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:26274 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964881AbWCPWfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:35:41 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 16 Mar 2006 22:35:31 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Christoph Hellwig <hch@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
In-Reply-To: <Pine.LNX.4.61.0603162056350.11776@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0603162230460.31173@hermes-2.csi.cam.ac.uk>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
 <20060316160129.GB6407@infradead.org> <20060316082951.58592fdc.rdunlap@xenotime.net>
 <20060316163001.GA7222@infradead.org> <20060316083654.d802f3f3.rdunlap@xenotime.net>
 <20060316163621.GA7519@infradead.org> <Pine.LNX.4.64.0603161640230.31173@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.61.0603162056350.11776@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Jan Engelhardt wrote:
> >> of course.  but that it's not used in core code implies this opinion is
> >> widely shared.
> >
> >[...]  To me it is a simple consequence of there not 
> >being a boolean type in the kernel so you cannot use it in the core code.  
> 
> 	typedef bool int;

You mean typedef int bool...

That (or its derivative) is what at least 69 places in the kernel do 
already.  That is the whole point of discussion!  The point is to unify it 
all into a kernel common place.  I just suggested that using the compiler 
provided _Bool was better than using int.

> And then happily use if(EXPR) and if(!EXPR) instead of if(EXPR == TRUE) or 
> if(EXPR == FALSE).  :-)

Obviously.  No-one here is suggesting to use if (EXPR == TRUE) that is 
crazy.  You would use if (EXPR) no matter what type you use.  Technically 
only a boolean type should be used like that.  The fact it works for an 
int is concidence because false = 0 and true = 1.

The point is 1) when assigning, you assign x = FALSE; rather than x = 0; 
which means nothing (it could be a counter you are initializing, no way to 
tell) and 2) for return values from functions and parameters to functions 
so it is easier to understand the semantics of the function.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
