Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129703AbRAGPVb>; Sun, 7 Jan 2001 10:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbRAGPVU>; Sun, 7 Jan 2001 10:21:20 -0500
Received: from CPE-203-45-168-41.qld.bigpond.net.au ([203.45.168.41]:7166 "EHLO
	athlon.internal") by vger.kernel.org with ESMTP id <S129784AbRAGPVK>;
	Sun, 7 Jan 2001 10:21:10 -0500
Date: Mon, 8 Jan 2001 01:20:22 +1000 (EST)
From: Dave <djdave@bigpond.net.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ftruncate returning EPERM on vfat filesystem
In-Reply-To: <E14FGI2-0002fo-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0101080002191.2613-100000@athlon.internal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,

On Sun, 7 Jan 2001, Alan Cox wrote:

> I wrote:
> > +
> > +       /* FAT cannot truncate to a longer file */
> > +       if (attr->ia_valid & ATTR_SIZE) {
> > +               if (attr->ia_size > inode->i_size)
> > +                       return -EPERM;
> > +       }
> >
> >         error = inode_change_ok(inode, attr);
> >         if (error)
> >
> > Can someone tell me if this is the cause of my samba problems, and if
> > so, why this was added and if this is safe to revert?
>
> To stop a case where the fs gets corrupted otherwise. You can change that to
> return 0 which is more correct but most not remove it.

Ok.  Glad I didn't try it. ;)

> (ftruncate is specified to make the file at most length bytes long, extending
> the file is not a guaranteed side effect according to the docs I have)

I don't understand why samba is doing it, if infact it is.
(haven't checked the source yet, and too tired to care atm)

Two other people told me to try your 2.4.0 tree, as it has some FAT
growing-truncate patches (I can't test it until later today).  I'm
guessing (hoping) that -ac3 will fix this problem.


Thanks alot for your help.

David.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
