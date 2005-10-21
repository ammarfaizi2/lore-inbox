Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbVJUPUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVJUPUQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVJUPUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:20:15 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:34955 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964976AbVJUPUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:20:14 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: Understanding Linux addr space, malloc, and heap
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: "Vincent W. Freeh" <vin@csc.ncsu.edu>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4359051C.2070401@csc.ncsu.edu>
References: <4358F0E3.6050405@csc.ncsu.edu>
	 <1129903396.2786.19.camel@laptopd505.fenrus.org>
	 <4359051C.2070401@csc.ncsu.edu>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 21 Oct 2005 16:20:05 +0100
Message-Id: <1129908005.1866.42.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-21 at 11:11 -0400, Vincent W. Freeh wrote:
> Arjan van de Ven wrote:
> > On Fri, 2005-10-21 at 09:45 -0400, Vincent W. Freeh wrote:
> > 
> >>Thanks for your quick response.  It basically confirmed that I observed 
> >>what I thought I did.  However, I am no closer to solving my problem.  I 
> >>cannot mprotect data that I malloc beyond the first 65 pages.
> > 
> > 
> > you can't mprotect malloc() memory period ..
> 
> Actually, I can and do.  Simple program at end.
> 
> > 
> >>  Why is 
> >>that?  Can that be fixed?  Second, why does mprotect silently fail?  I 
> >>could live with it failing--but I cannot deal with a call the "works" 
> >>but doesn't work.
> > 
> > 
> > need more info :)
> > 
> 
> I call mprotect and it return 0--meaning it succeeded.  But the 
> permissions on the page remain rw.  So it fails to change the 
> permissions, but doesn't give any indication of this.
> 
> Thanks,
> vince.
> 
> ------------------
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/mman.h>
> #include <unistd.h>
> 
> int main(int argc, char *argv[])
> {
>    void *p;
>    int pgsize = getpagesize();
> 
>    p = malloc(1024);
>    mprotect((void*)((unsigned)p & ~(pgsize-1)), 1024, PROT_NONE);
>    printf("\t*p = %d\n", *(int *)p);
>    return 0;
> }

This program is completely screwed.  Read the mprotect man page in
particular the examples section has an example of how to do your program
correctly.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

