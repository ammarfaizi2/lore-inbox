Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266178AbUBCVLe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 16:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUBCVLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 16:11:34 -0500
Received: from [62.38.227.126] ([62.38.227.126]:45198 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S266178AbUBCVLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 16:11:32 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: Q: large files in iso9660 ?
Date: Tue, 3 Feb 2004 23:10:23 +0200
User-Agent: KMail/1.6
References: <200402020024.31785.p_christ@hol.gr> <20040203133551.GA11957@bitwizard.nl>
In-Reply-To: <20040203133551.GA11957@bitwizard.nl>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402032310.23609.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> The kernel (2.6 and 2.4) has the following code in isofs_read_inode():
>
>         /*
>          * The ISO-9660 filesystem only stores 32 bits for file size.
>          * mkisofs handles files up to 2GB-2 = 2147483646 = 0x7FFFFFFE
> bytes * in size. This is according to the large file summit paper from
> 1996. * WARNING: ISO-9660 filesystems > 1 GB and even > 2 GB are fully *   
>       legal. Do not prevent to use DVD's schilling@fokus.gmd.de */
>         if ((inode->i_size < 0 || inode->i_size > 0x7FFFFFFE) &&
>             sbi->s_cruft == 'n') {
>                 printk(KERN_WARNING "Warning: defective CD-ROM.  "
>                        "Enabling \"cruft\" mount option.\n");
>                 sbi->s_cruft = 'y';
>         }
>
> IOW: your kernel should have warned you about the defective CDROM and
> truncated filesizes to 16MB (which is what the "cruft" mount option
> does).
>
>
> Erik

Makes perfect sense.
However, this *does* enforce the limit on DVD files. If I try to disable this 
code and make inode sizes uint32, can there be any other negative 
implication? Of course, I am still limited to 3GB..
