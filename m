Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311729AbSCNSv6>; Thu, 14 Mar 2002 13:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311732AbSCNSvt>; Thu, 14 Mar 2002 13:51:49 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:22185 "EHLO
	postfix2-2.free.fr") by vger.kernel.org with ESMTP
	id <S311729AbSCNSvc>; Thu, 14 Mar 2002 13:51:32 -0500
To: Christoph Hellwig <hch@ns.caldera.de>
Subject: Re: your mail (tipar)
Message-ID: <1016131891.3c90f13373d0a@imp.free.fr>
Date: Thu, 14 Mar 2002 19:51:31 +0100 (MET)
From: =?ISO-8859-1?Q?Romain_Li=E9vin?= <rlievin@free.fr>
Cc: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200203132044.g2DKiba00923@ns.caldera.de>
In-Reply-To: <200203132044.g2DKiba00923@ns.caldera.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP IMAP webmail program 2.2.42
X-Originating-IP: 195.220.37.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +static int tipar_open(struct inode *inode, struct file *file)
> > +{
> > +       unsigned int minor = minor(inode->i_rdev) - TIPAR_MINOR_0;
> > +
> > +       if (minor >= PP_NO)
> > +               return -ENXIO;
> > +
> > +       if(table[minor].opened)
> > +               return -EBUSY;
> > +
> > +       table[minor].opened++;
> > +
> 
> I think <asm/bitops.h> operations on one unsigned long for all devices
> would be better, and at least non-racy.

Well, but I have never seen a such use in any kernrl modules. Is it the right
way to use ?

> 
> > +       case TIPAR_DELAY:
> > +               delay = arg;
> 
> Needs get_user/copy_from_user

In the modules tree, they use copy_to_user. They use the same construction
rather than using get_user. More informations ?

Romain

---
Romain Liévin (aka roms)
http://lpg.ticalc.org/prj_tilp, prj_usb, prj_tidev, prj_gtktiemu
mail: roms@lpg.ticalc.org
