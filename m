Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUBDHnc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 02:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266307AbUBDHnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 02:43:32 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:1442 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S266310AbUBDHna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 02:43:30 -0500
Subject: Re: Q: large files in iso9660 ?
From: Vladimir Saveliev <vs@namesys.com>
To: "P. Christeas" <p_christ@hol.gr>
Cc: Erik Mouw <erik@harddisk-recovery.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200402032310.23609.p_christ@hol.gr>
References: <200402020024.31785.p_christ@hol.gr>
	 <20040203133551.GA11957@bitwizard.nl>  <200402032310.23609.p_christ@hol.gr>
Content-Type: text/plain
Message-Id: <1075880608.1830.108.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 04 Feb 2004 10:43:28 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Wed, 2004-02-04 at 00:10, P. Christeas wrote:
> >
> > The kernel (2.6 and 2.4) has the following code in isofs_read_inode():
> >
> >         /*
> >          * The ISO-9660 filesystem only stores 32 bits for file size.
> >          * mkisofs handles files up to 2GB-2 = 2147483646 = 0x7FFFFFFE
> > bytes * in size. This is according to the large file summit paper from
> > 1996. * WARNING: ISO-9660 filesystems > 1 GB and even > 2 GB are fully *   
> >       legal. Do not prevent to use DVD's schilling@fokus.gmd.de */
> >         if ((inode->i_size < 0 || inode->i_size > 0x7FFFFFFE) &&
> >             sbi->s_cruft == 'n') {
> >                 printk(KERN_WARNING "Warning: defective CD-ROM.  "
> >                        "Enabling \"cruft\" mount option.\n");
> >                 sbi->s_cruft = 'y';
> >         }
> >
> > IOW: your kernel should have warned you about the defective CDROM and
> > truncated filesizes to 16MB (which is what the "cruft" mount option
> > does).
> >
> >
> > Erik
> 
> Makes perfect sense.
> However, this *does* enforce the limit on DVD files. If I try to disable this 
> code and make inode sizes uint32, can there be any other negative 
> implication? Of course, I am still limited to 3GB..

IIRC, mkisofs can create HFS. There should be no problem with that long
files


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

