Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136016AbRAGQsP>; Sun, 7 Jan 2001 11:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136066AbRAGQrz>; Sun, 7 Jan 2001 11:47:55 -0500
Received: from hermes.mixx.net ([212.84.196.2]:41989 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S136065AbRAGQrt>;
	Sun, 7 Jan 2001 11:47:49 -0500
Message-ID: <3A589D06.D65FDDA9@innominate.de>
Date: Sun, 07 Jan 2001 17:44:54 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave <djdave@bigpond.net.au>,
        linux-kernel@vger.kernel.org
Subject: Re: ftruncate returning EPERM on vfat filesystem
In-Reply-To: <Pine.LNX.4.30.0101071613130.1132-100000@athlon.internal> <E14FGI2-0002fo-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
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
> 
> (ftruncate is specified to make the file at most length bytes long, extending
> the file is not a guaranteed side effect according to the docs I have)

Speaking as an old time dos hacker, this is allowed and commonly done. 
I wouldn't read too much into the fact that it's not documented.  :-) 
As I recall, new clusters are allocated but not cleared.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
