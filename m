Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314047AbSDXCWl>; Tue, 23 Apr 2002 22:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314507AbSDXCWl>; Tue, 23 Apr 2002 22:22:41 -0400
Received: from pat.uio.no ([129.240.130.16]:48821 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S314047AbSDXCWk> convert rfc822-to-8bit;
	Tue, 23 Apr 2002 22:22:40 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbols in 2.4.9-dj1
In-Reply-To: <d8jk7qym0ai.fsf@fimm.ifi.uio.no>
From: ilmari@ping.uio.no (Dagfinn Ilmari =?iso-8859-1?q?Manns=E5ker?=)
Organization: PING
Date: Wed, 24 Apr 2002 04:22:35 +0200
Message-ID: <d8j8z7dn8d0.fsf@fimm.ifi.uio.no>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2
 (sparc-sun-solaris2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ilmari@ping.uio.no (Dagfinn Ilmari Mannsåker) writes:

> Hi,
>
> When compiling 2.5.9-dj1 with modular MD/LVM and EXT3, I got the
> following unresolved symbols:
>
> % depmod -ae -F System.map -b debian/tmp-image -r 2.5.9-dj1
> depmod: *** Unresolved symbols in
>          debian/tmp-image/lib/modules/2.5.9-dj1/kernel/drivers/md/md.o
> depmod:         blk_get_readahead
> depmod: *** Unresolved symbols in
>          debian/tmp-image/lib/modules/2.5.9-dj1/kernel/fs/jbd/jbd.o
> depmod:         exit_files
>
> Seems like some missing EXPORT_SYMBOL statements.

It worked when I added EXPORT_SYMBOL statements for these symbols to
ksyms.c. Here's the patch (I hope they're in the right locations).

-- 
Dagfinn I. Mannsåker
aka. Ilmari

--- kernel/ksyms.c.orig Wed Apr 24 04:17:42 2002
+++ kernel/ksyms.c      Wed Apr 24 04:20:52 2002
@@ -340,6 +340,7 @@
 EXPORT_SYMBOL(init_buffer);
 EXPORT_SYMBOL(refile_buffer);
 EXPORT_SYMBOL(wipe_partitions);
+EXPORT_SYMBOL(blk_get_readahead);
 
 /* tty routines */
 EXPORT_SYMBOL(tty_hangup);
@@ -553,6 +554,7 @@
 EXPORT_SYMBOL(is_bad_inode);
 EXPORT_SYMBOL(event);
 EXPORT_SYMBOL(brw_page);
+EXPORT_SYMBOL(exit_files);
 
 #ifdef CONFIG_UID16
 EXPORT_SYMBOL(overflowuid);
