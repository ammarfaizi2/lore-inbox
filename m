Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUFYKdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUFYKdb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 06:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUFYKdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 06:33:31 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:10245 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S263585AbUFYKd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 06:33:29 -0400
Date: Fri, 25 Jun 2004 12:33:26 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: 2.6.7-mm2, mmaps rework, buggy apps, setarch
Message-ID: <20040625103326.GA21814@gamma.logic.tuwien.ac.at>
References: <20040625082243.GA11515@gamma.logic.tuwien.ac.at> <20040625013508.70e6d689.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040625013508.70e6d689.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fre, 25 Jun 2004, Andrew Morton wrote:
> > But what to do with a commerical app where I
> > cannot check a stack trace or whatever?
> 
> Use strace -f, look at the last screenful of output.  That usually works.

open("/media4/scan/cam-2002.03/001-100/raw/scan0100.tif", O_RDONLY) = 6
lseek(6, 0, SEEK_END)                   = 43426634
lseek(6, 0, SEEK_CUR)                   = 43426634
lseek(6, 0, SEEK_SET)                   = 0
mmap2(NULL, 43426634, PROT_READ|PROT_WRITE, MAP_PRIVATE, 6, 0) = -1 ENOMEM (Cann
ot allocate memory)
lseek(6, 0, SEEK_END)                   = 43426634
lseek(6, 0, SEEK_CUR)                   = 43426634
fstat64(6, {st_mode=S_IFREG|0644, st_size=43426634, ...}) = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++

I guess that you are right.

> Ingo's setarch patch wasn't a lot of use because it seems to be against a
> setarch which doesn't exist.  I hacked one up.  Try
> 
> 	setarch i386 your-program

This worked.

So what is the intended path:
- inform the author of the program
- remove the patch (you from mm, I from my build?)
- run setarch for all buggy programs

Best wishes and thanks a lot!

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
ELY (n.)
The first, tiniest inkling you get that something, somewhere, has gone
terribly wrong.
			--- Douglas Adams, The Meaning of Liff
