Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268112AbRGWARj>; Sun, 22 Jul 2001 20:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268114AbRGWAR3>; Sun, 22 Jul 2001 20:17:29 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:41175 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S268112AbRGWARS>; Sun, 22 Jul 2001 20:17:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Pavel Machek <pavel@suse.cz>, Hans Reiser <reiser@namesys.com>
Subject: Re: NFS Client patch
Date: Sun, 22 Jul 2001 11:15:07 -0400
X-Mailer: KMail [version 1.2]
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
        Craig Soules <soules@happyplace.pdl.cmu.edu>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96L.1010717180713.13980K-100000@happyplace.pdl.cmu.edu> <3B55A12C.F194DAF6@namesys.com> <20010719182405.A35@toy.ucw.cz>
In-Reply-To: <20010719182405.A35@toy.ucw.cz>
MIME-Version: 1.0
Message-Id: <01072211150706.08013@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thursday 19 July 2001 14:24, Pavel Machek wrote:
> Hi!
>
> > > In any case, what happens if the file was renamed or removed between
> > > the 2 readdir calls. A cookie identifying a name that was returned
> > > last, or should be read next is just as volatile as a cookie that
> > > contains an offset into the directory.
> >
> > No, if the file was removed, it still tells you where to start your
> > search.  A missing filename is just as good a marker as a present one.
>
> And if new file is created with same name?
> 								Pavel

The same thing that happens as if a new file was inserted BEFORE your cursor, 
in the part of the directory you've already looked at.  You ignore it.

The "filename cookie" indicates the LAST file we looked at.  We've already 
seen it.  Therefore, whether it's the same file or not, we don't care.  We 
just want the next file AFTER that one.

We're doing fairly arbitrary, unlocked reads across volatile data.  No 
algorithm is going to behave perfectly here.  We just want a behavior that is 
consistent, guaranteed to complete, and doesn't violate any obvious 
constraints about how filesystems should behave (like producing duplicate 
entries, which returning two different sets of data with the same filename 
would do).

Makes sense to me, anyway...

Rob
