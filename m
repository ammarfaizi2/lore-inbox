Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbTJUNnh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 09:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbTJUNnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 09:43:37 -0400
Received: from mx2.seznam.cz ([212.80.76.42]:53157 "HELO email.seznam.cz")
	by vger.kernel.org with SMTP id S263096AbTJUNnf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 09:43:35 -0400
From: =?us-ascii?Q?Pavel=20Krauz?= <Pavel.Krauz@seznam.cz>
To: linux-kernel@vger.kernel.org, viro@math.psu.edu, marcelo@conectiva.com.br,
       rusty@rustcorp.com.au
In-Reply-To: <79944.195572-26028-2050931566-1066651886@seznam.cz>
Subject: =?us-ascii?Q?=5BPATCH=5D=20Re=3A=20READ=2DONLY=20mmap=20not=20present=20in=20core?=
Date: Tue, 21 Oct 2003 15:43:33 +0200 (CEST)
Message-Id: <74332.263359-7291-910729114-1066743813@seznam.cz>
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0
Reply-To: =?us-ascii?Q?Pavel=20Krauz?= <Pavel.Krauz@seznam.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have verified that the READ_ONLY mmap mapping of file did not propagate 
> to core file.

Here goes a patch that solves the problem. The READ_ONLY - only mappings are now included to the core file. The executable regions are still excluded. The size of core
did not change a lot and you have all important info in core and don't get 
unreferencable pointers inside a debugger.

Please apply to 2.4.X and 2.6.X also
Pavel


with patch (emacs, netscape, xemacs):
4706304 core.all.emacs
9129984 core.all.netscape
5726208 core.all.xemacs

without patch:
4452352 core.emacs
8851456 core.netscape
5459968 core.xemacs


--- linux/fs/binfmt_elf.c.bak   Tue Oct 21 15:21:13 2003
+++ linux/fs/binfmt_elf.c       Tue Oct 21 15:21:18 2003
@@ -952,7 +952,7 @@
 #if 1
        if (vma->vm_flags & (VM_WRITE|VM_GROWSUP|VM_GROWSDOWN))
                return 1;
-       if (vma->vm_flags & (VM_READ|VM_EXEC|VM_EXECUTABLE|VM_SHARED))
+       if (vma->vm_flags & (VM_EXEC|VM_EXECUTABLE))
                return 0;
 #endif
        return 1;




____________________________________________________________
Mall [mo:l] - promenáda, ¹iroká alej, nákupní støedisko (velké) 
Internet Mall - profesionální nákupní galerie na Internetu (http://www.mall.cz)
