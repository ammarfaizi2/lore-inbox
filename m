Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130876AbQLTDu0>; Tue, 19 Dec 2000 22:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130918AbQLTDuR>; Tue, 19 Dec 2000 22:50:17 -0500
Received: from out5.mx.nwbl.wi.voyager.net ([169.207.2.77]:43015 "EHLO
	out5.mx.nwbl.wi.voyager.net") by vger.kernel.org with ESMTP
	id <S130876AbQLTDuB>; Tue, 19 Dec 2000 22:50:01 -0500
Message-ID: <3A402563.7F7E9E58@megsinet.net>
Date: Tue, 19 Dec 2000 21:20:03 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Alexander Viro <viro@math.psu.edu>, trond.myklebust@fys.uio.no,
        linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167! 
 -reproducible
In-Reply-To: <Pine.GSO.4.21.0012180631290.22952-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Mon, 18 Dec 2000, Neil Brown wrote:
> 
> > On Monday December 18, trond.myklebust@fys.uio.no wrote:
> > > >>>>> " " == M H VanLeeuwen <vanl@megsinet.net> writes:
> > >
> > >      > Trond, Neil I don't know if this is a loopback bug or an NFS
> > >      > bug but since nfs_fs.h was implicated so I thought one of you
> > >      > may be interested.
> > >
> > >      > Could you let me know if you know this problem has already been
> > >      > fixed or if you need more info.
> > >
> > > Hi,
> > >
> > > As far as I'm concerned, it's a loopback bug.
> >
> > I read it the same way.
> > Actually, I cannot see the point of copying the "struct file"!  Why
> > not just take a reference to it?  The comment tries to justify it, but
> > I don't buy it.
> 
> Wish I remembered who had complained when I proposed to kill that copying...
> It was introduced back in 2.1.110 and back then comment looked so:
> 
> +               /* Backed by a regular file - we need to hold onto
> +                  a file structure for this file.  We'll use it to
> +                  write to blocks that are not already present in
> +                  a sparse file.  We create a new file structure
> +                  based on the one passed to us via 'arg'.  This is
> +                  to avoid changing the file structure that the
> +                  caller is using */
> +
> 
> I would be happy to get rid of that crap - it was the only reason why I
> had to add the sodding file_moveto() and world would be better without it.
> If we can kill it off - let's do it and let's take fs/file_table:file_moveto()
> along.
> 
> IOW, I also think that copying the struct file is wrong. IIRC, complaints were
> bogus - losetup requires enough priviliges to make worrying about security
> implications somewhat pointless.

Ok, I've was able to cause 2 BUG's yesterday in a couple of hours, ( it was easier
to lock the machine solid than to get the BUG;-)), since loading test12 w/patch I
haven't seen a single BUG in the last 24 hours.  Any chance we can get this change
to Linus for test13?

Any specific tests you want me to run?

Martin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
