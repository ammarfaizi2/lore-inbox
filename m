Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWJQVfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWJQVfh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWJQVfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:35:36 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:29427 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750705AbWJQVfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:35:36 -0400
Date: Tue, 17 Oct 2006 23:32:39 +0200
From: Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling)
To: linux-kernel@vger.kernel.org, jlamanna@gmail.com, ismail@pardus.org.tr
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Message-ID: <45354bf7.Lo5w3vkS8/cH+1PI%Joerg.Schilling@fokus.fraunhofer.de>
References: <4535460c.5a4933ac.778b.ffffc157@mx.google.com>
In-Reply-To: <4535460c.5a4933ac.778b.ffffc157@mx.google.com>
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Lamanna <jlamanna@gmail.com> wrote:

>
> Joerg Shilling wrote:
> > Ismail Donmez <ismail@pardus.org.tr> wrote:
> >
> > > > Well, this is why I did offer a preliminary version of thelatest mkisofs
> > > > sources.....
> > >
> > > Well a simple mkisofs some_file > test.iso and mounting that on a loop
> > > device 
> > > worked fine.
> > >
> > >
> > > > But note: your patch does not fix the original implementation bug and it
> > > > is
> > > > most unlikely that the hack will do the right things in all cases.
> > >
> > > Well I don't know whats the original implementation bug and rock.c seems to
> > > be 
> > > pretty much old with no active maintainer.
> > 
> > Please read again my original mail....
> > 1) you need to create images with Rock Ridge
> > 
> > 2) a correct implementation is prepared to deal with more recent versions 
> >     without a need for new changes.
> > 
> >     So, if the implementation does not deal with the new version _without_ 
> >     explicitely knowing about v1.12 it is still broken.
>
> Hi Joerg,
>
> I am unable to duplicate this bug that supposedly exists even on older
> kernels.
> For instance, on a 2.6.16 kernel I do the following:

Mm, I did not test, I did only check the source and it seems that I did 
interpret the check 

        len += offsetof(struct rock_ridge, u); 
        if (len > rs->len) { 
                printk(KERN_NOTICE "rock: directory entry would overflow " 
                                "storage\n"); 
                printk(KERN_NOTICE "rock: sig=0x%02x, size=%d, remaining=%d\n", 
                                sig, len, rs->len); 
                return -EIO; 
	}

the wrong way.... because the error text is wrong. It should be corrected into

"rock: directory entry would _underflow_ storage\n"


Using the inode field from RRip 1.12 is definitely not trivial as it may affect
many parts of the source and needs intensive testing.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
