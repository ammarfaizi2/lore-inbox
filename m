Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTLORjg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTLORjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:39:36 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:18088 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263786AbTLORjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:39:35 -0500
Date: Mon, 15 Dec 2003 18:38:16 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215173816.GC10857@louise.pinerecords.com>
References: <3FDDD8C6.3080804@intel.com> <4921.1071508195@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4921.1071508195@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-16 2003, Tue, 04:09 +1100
Keith Owens <kaos@ocs.com.au> wrote:

> a1:
>         .long   0
>         .local  a2  
>         .comm   a2,4,4
>         .ident  "GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"

...

> Try it with an older version of gcc, which most people are
> still using to build the kernel.  With 3.2.2, you get

And w/ gcc-3.3.2, you get what you'd actually expect :)

$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-slackware-linux/3.3.2/specs
Configured with: ../configure --enable-languages=c,c++ --prefix=/usr --enable-shared --enable-threads=posix --enable-__cxa_atexit --disable-checking --with-gnu-ld --verbose --disable-nls --target=i386-slackware-linux --host=i386-slackware-linux --build=i386-slackware-linux
Thread model: posix
gcc version 3.3.2
$ cat x.c
static int a1 = 0;
static int a2 = 1;
static int a3;
$ gcc -S x.c
$ cat x.s
        .file   "x.c"
        .local  a1
        .comm   a1,4,4
        .data
        .align 4
        .type   a2, @object
        .size   a2, 4
a2:
        .long   1
        .local  a3
        .comm   a3,4,4
        .ident  "GCC: (GNU) 3.3.2"

-- 
Tomas Szepe <szepe@pinerecords.com>
