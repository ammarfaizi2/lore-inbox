Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWJQVwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWJQVwD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWJQVwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:52:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:28587 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750954AbWJQVwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:52:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=amfQkxrjLR+VevVhJLlrJuGNtJXVshbVye2sYjlStUsfD7AOB+WNfb33pbVpYYTQDa5WnBWShAlUkPBC5BSz7eMvLn3Sh1X32wlUvukGEL86j2juNWVCTazQjynAYYJS3PuhVfWETBObQ7P2mm0BzXEPnLjFXR/4SFePATbTNv4=
Message-ID: <aa4c40ff0610171451l5597dc55i97fcad4cf111acd2@mail.gmail.com>
Date: Tue, 17 Oct 2006 14:51:58 -0700
From: "James Lamanna" <jlamanna@gmail.com>
To: "Joerg Schilling" <Joerg.Schilling@fokus.fraunhofer.de>
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Cc: linux-kernel@vger.kernel.org, ismail@pardus.org.tr
In-Reply-To: <45354bf7.Lo5w3vkS8/cH+1PI%Joerg.Schilling@fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4535460c.5a4933ac.778b.ffffc157@mx.google.com>
	 <45354bf7.Lo5w3vkS8/cH+1PI%Joerg.Schilling@fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/06, Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de> wrote:
> James Lamanna <jlamanna@gmail.com> wrote:
>
> >
> > Joerg Shilling wrote:
[snip...]
> >
> > Hi Joerg,
> >
> > I am unable to duplicate this bug that supposedly exists even on older
> > kernels.
> > For instance, on a 2.6.16 kernel I do the following:
>
> Mm, I did not test, I did only check the source and it seems that I did
> interpret the check
>
>         len += offsetof(struct rock_ridge, u);
>         if (len > rs->len) {
>                 printk(KERN_NOTICE "rock: directory entry would overflow "
>                                 "storage\n");
>                 printk(KERN_NOTICE "rock: sig=0x%02x, size=%d, remaining=%d\n",
>                                 sig, len, rs->len);
>                 return -EIO;
>         }
>
> the wrong way.... because the error text is wrong. It should be corrected into
>
> "rock: directory entry would _underflow_ storage\n"

Yes I saw this check and misinterpreted it initially also.

I actually think 'overflow' is still correct since its testing for the
calcuated size (directory entry) being larger than the size reported
by the filesystem (storage).

I still submit my patch to Linus et. al. for consideration that also
detects overflow in the case of a v 1.12 PX entry. I may have time to
build a git kernel today or tomorrow and actually test it against a RR
iso image.

>
>
> Using the inode field from RRip 1.12 is definitely not trivial as it may affect
> many parts of the source and needs intensive testing.

Yes. If it is actually correct it allows for the use of iget_locked()
in isofs/inode.c instead of iget5_locked() (per
Documentation/filesystems/vfs.txt). Though I'll let a real VFS person
decide if that has any advantages.

-- James
