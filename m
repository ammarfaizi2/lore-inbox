Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143881AbRAHOBa>; Mon, 8 Jan 2001 09:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143886AbRAHOBW>; Mon, 8 Jan 2001 09:01:22 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:38387 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S143881AbRAHOBM>;
	Mon, 8 Jan 2001 09:01:12 -0500
Date: Mon, 8 Jan 2001 15:00:11 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Stefan Traby <stefan@hello-penguin.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        drepper@gnu.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
Message-ID: <20010108150011.A13441@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <20010108141721.C13072@stefan.sime.com> <Pine.GSO.4.21.0101080821450.4061-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0101080821450.4061-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Jan 08, 2001 at 08:35:10AM -0500
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-fijiji0 (i686)
X-APM: 100% 400 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 08:35:10AM -0500, Alexander Viro wrote:
> On Mon, 8 Jan 2001, Stefan Traby wrote:
> > Try 'getconf LINK_MAX /ramfs'.
> > While the result (127) is in some way SuS/POSIXLY_CORRECT,
> > it's not the truth.
> > 
> > Why not start to fix this problem outside the funny switch/case in glibc ?
> > The filesystem itself should able to handle this.
> 
> Sigh... And the API would be?

Oh, IMHO that's not too important.
API should be accepted by you and Ulrich Drepper.
API should not be expected to return static values. (for example: reiserfs
may return different values dependend on filesystem-version)

I think the easiest way would be to define ioctls for this.
So VFS needs no changes; the only discussion would be about the
standard name for "request-names", and Ulrich could fall back to
his magic calculations if EINVAL is returned.

Because I have no knowledge on this I suggest that you and Ulrich fight
together on a more flexible solution than the current one. I guess
that Linus would accept this without thinking too much about it.

-- 

  ciao - 
    Stefan

"     ( cd /lib ; ln -s libBrokenLocale-2.2.so libNiedersachsen.so )     "
    
Stefan Traby                Linux/ia32               fax:  +43-3133-6107-9
Mitterlasznitzstr. 13       Linux/alpha            phone:  +43-3133-6107-2
8302 Nestelbach             Linux/sparc       http://www.hello-penguin.com
Austria                                    mailto://st.traby@opengroup.org
Europe                                   mailto://stefan@hello-penguin.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
