Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316228AbSEQOHm>; Fri, 17 May 2002 10:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316229AbSEQOHl>; Fri, 17 May 2002 10:07:41 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:14343 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S316228AbSEQOHk>; Fri, 17 May 2002 10:07:40 -0400
Date: Fri, 17 May 2002 16:07:37 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: <linux-kernel@vger.kernel.org>
cc: <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [ANN] NTFS 2.0.7c for Linux 2.4.18
In-Reply-To: <Pine.LNX.4.33.0205170249300.377-100000@bzzzt.slackware.pl>
Message-ID: <Pine.LNX.4.33.0205171603450.493-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, Pawel Kot wrote:

Hi,

> As Arek Miskiewicz reported to me, the previous NTFS TNG versions didn't
> compile with CONFIG_HIGHMEM. The compilation failed due to lack of the
> definition of the KM_BIO_IRQ used in the NTFS code.
>
> In this release KM_BIO_IRQ was added to km_type enum on all platforms
> supporting it (sparc, ppm, i386).
>
> If you don't use HIGHMEM support or use other architecture the changes
> don't touch you.

Unfortunately the patch fixes only the case when NTFS is compiled into the
kernel. There are missing exports of kmap_pte and kmap_prot when you use
ntfs as the kernel module and depmod fails then.

The following patch adresses this issue. Could anyone please test it with
a highmem box? The patch will be included in the next release (2.0.7d or
2.0.8a).

--- kernel/ksyms.c~	Thu May 16 10:39:39 2002
+++ kernel/ksyms.c	Fri May 17 14:12:04 2002
@@ -121,6 +121,8 @@
 EXPORT_SYMBOL(kunmap_high);
 EXPORT_SYMBOL(highmem_start_page);
 EXPORT_SYMBOL(create_bounce);
+EXPORT_SYMBOL(kmap_pte);
+EXPORT_SYMBOL(kmap_prot);
 #endif

 /* filesystem internal functions */

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

