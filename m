Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbRE0VsX>; Sun, 27 May 2001 17:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262434AbRE0VsO>; Sun, 27 May 2001 17:48:14 -0400
Received: from www.inreko.ee ([195.222.18.2]:26587 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S262420AbRE0VsD>;
	Sun, 27 May 2001 17:48:03 -0400
Date: Sun, 27 May 2001 23:50:31 +0200
From: Marko Kreen <marko@l-t.ee>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Edgar Toernig <froese@gmx.de>, Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Message-ID: <20010527235031.B17617@l-t.ee>
In-Reply-To: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org> <0105270036060Z.06233@starship> <3B1101ED.3BF181F6@gmx.de> <01052722451714.06233@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01052722451714.06233@starship>; from phillips@bonn-fries.net on Sun, May 27, 2001 at 10:45:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2001 at 10:45:17PM +0200, Daniel Phillips wrote:
> On Sunday 27 May 2001 15:32, Edgar Toernig wrote:
> > Daniel Phillips wrote:
> > > I'm not claiming there isn't breakage somewhere,
> >
> > you break UNIX fundamentals.  But I'm quite relieved now because I'm
> > pretty sure that something like that will never go into the kernel.
> 
> OK, I'll take that as "I couldn't find a piece of code that breaks, so 
> it's on to the legal issues".
> 
> SUS doesn't seem to have a lot to say about this.  The nearest thing to 
> a ruling I found was "The special filename dot refers to the directory 
> specified by its predecessor".  Which is not the same thing as:
> 
>    open("foo", O_RDONLY) == open ("foo/.", O_RDONLY)
> 
> I don't know about POSIX (I don't have it: a pox on standards 
> organizations that don't make their standards freely available) but SUS 
> doesn't seem to forbid this.

My question is: Is it needed?  You are advocating quite
non-obvious behaviour on a UNIX-like fs.  Cant the end result
achieved in more obvious manner?

I see at most 3 types of magic files:

1) regular file - nothing special.  Whether it has CHR/BLK set
   or not is irrelevant.

2) file with subdevs.  As 1) but you can acces dev/something
   for subdev 'something'.  Permissions should be probably taken
   from 'dev'.  Ofcourse you cant do 'ls' on the thing.

3) magicdev as directory.  Act as ordinary directory.  Only
   reason is to group devices.

And all those should be manageable by devfsd, so you can tell
devfsd to take subdev and create it as file somewhere else.
So 2) and 3) are more like 'defaults'.

So: is there additional type required with non-obvious file/dir
behaviour mix?

-- 
marko

