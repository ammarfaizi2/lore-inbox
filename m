Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVBHKlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVBHKlJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 05:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVBHKlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 05:41:08 -0500
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:25799 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261510AbVBHKlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 05:41:05 -0500
Subject: Re: [BUG report] UML linux-2.6 latest BK doesn't compile
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, lkml <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <200502081122.22613.blaisorblade@yahoo.it>
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
	 <200502081122.22613.blaisorblade@yahoo.it>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Tue, 08 Feb 2005 10:40:54 +0000
Message-Id: <1107859254.582.4.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-08 at 11:22 +0100, Blaisorblade wrote:
> On Tuesday 08 February 2005 11:09, Anton Altaparmakov wrote:
> > Hi,
> >
> > With the current linux-2.6 BK tree I get this when trying to compile
> > UML:
> >
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > arch/um/kernel/built-in.o(__ksymtab+0x2b0): In function `um_execve':
> > arch/um/kernel/exec_kern.c:59: undefined reference to `__bb_init_func'
> > collect2: ld returned 1 exit status
> >   KSYM    .tmp_kallsyms1.S
> > nm: '.tmp_vmlinux1': No such file
> > /bin/bash: line 1: 26161 Exit 1                  nm -n .tmp_vmlinux1
> >      26162 Segmentation fault      | scripts/kallsyms >.tmp_kallsyms1.S
> > make: *** [.tmp_kallsyms1.S] Error 139
> >
> > This is with SKAS mode enabled and TT disabled.  My .config is attached.
> 
> Hmm - I do not understand at all where `__bb_init_func' comes from (not from 
> UML by sure, only from kernel headers possibly). And from preprocessing the 
> source (of the -bk4 snapshot), nothing similar comes out.

It is from UML.  'bk -r grep __bb_init_func' gives:

arch/um/kernel/gmon_syms.c      1.1     extern void __bb_init_func(void
*);
arch/um/kernel/gmon_syms.c      1.1     EXPORT_SYMBOL(__bb_init_func);

The kernel compiles fine with the same .config but TT mode also enabled.

So I suspect that in the non-TT case the gmon_syms binary doesn't get
linked into the kernel so the symbol is missing or something like
that...

Also note I am using the latest BK as pulled about an hour ago.  I don't
know how old the snapshot you are using is in comparison.  Lots of UML
changes were pulled in by my pull...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

