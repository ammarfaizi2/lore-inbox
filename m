Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264930AbSJVSYh>; Tue, 22 Oct 2002 14:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbSJVSYh>; Tue, 22 Oct 2002 14:24:37 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:58304 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S264930AbSJVSYf>; Tue, 22 Oct 2002 14:24:35 -0400
Subject: Re: Linux 2.5.44-ac1
From: Steven Cole <elenstev@mesatop.com>
To: Alan Cox <alan@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Hans Reiser <reiser@namesys.com>
In-Reply-To: <200210221727.g9MHR6128999@devserv.devel.redhat.com>
References: <200210221727.g9MHR6128999@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 22 Oct 2002 12:29:50 -0600
Message-Id: <1035311390.13140.201.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 11:27, Alan Cox wrote:
[snip]
>    This one builds, its not yet had any measurable testing
> 
> Linux 2.5.44-ac1
> -	Resync with Linus 2.5.43/44
[snip]
> o	Move BUG() into asm/bug.h			(Russell King)

I got this error building with CONFIG_REISERFS_FS=y:

fs/built-in.o: In function `keyed_hash':
fs/built-in.o(.text+0x84d56): undefined reference to `BUG'
fs/built-in.o(.text+0x84e08): undefined reference to `BUG'
fs/built-in.o(.text+0x84ea4): undefined reference to `BUG'
fs/built-in.o(.text+0x84f0e): undefined reference to `BUG'
make: *** [.tmp_vmlinux1] Error 1

The following patch allows 2.5.44-ac1 to build with reiserfs.

Steven

--- linux-2.5.44-ac1/fs/reiserfs/hashes.c.orig	Tue Oct 22 12:16:52 2002
+++ linux-2.5.44-ac1/fs/reiserfs/hashes.c	Tue Oct 22 12:17:15 2002
@@ -20,6 +20,7 @@
 
 #include <asm/types.h>
 #include <asm/page.h>
+#include <asm/bug.h>
 





