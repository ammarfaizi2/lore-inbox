Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTLOSQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTLOSQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:16:51 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:56338 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S263806AbTLOSQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:16:48 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI Express support for 2.4 kernel 
In-reply-to: Your message of "Mon, 15 Dec 2003 18:38:16 BST."
             <20031215173816.GC10857@louise.pinerecords.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Dec 2003 05:16:37 +1100
Message-ID: <6230.1071512197@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003 18:38:16 +0100, 
Tomas Szepe <szepe@pinerecords.com> wrote:
>And w/ gcc-3.3.2, you get what you'd actually expect :)
>
>gcc version 3.3.2
>$ cat x.c
>static int a1 = 0;
>static int a2 = 1;
>static int a3;
>$ gcc -S x.c
>$ cat x.s
>        .file   "x.c"
>        .local  a1
>        .comm   a1,4,4
>        .data
>        .align 4
>        .type   a2, @object
>        .size   a2, 4
>a2:
>        .long   1
>        .local  a3
>        .comm   a3,4,4
>        .ident  "GCC: (GNU) 3.3.2"

Does gcc 3.3.2 handle sections correctly when it optimizes zero
assignments to use bss?  With just this line in x.c

static int __attribute__ ((__section__ (".init.data"))) a1 = 0;

what does objdump -h report?  If bss is 4 bytes then gcc 3.3.2 is
breaking the kernel's use of init data.  If bss is 0 and .init.data is
4 then we are OK.

