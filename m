Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267896AbRGROr7>; Wed, 18 Jul 2001 10:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267894AbRGROru>; Wed, 18 Jul 2001 10:47:50 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:12553 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267892AbRGROri>; Wed, 18 Jul 2001 10:47:38 -0400
Message-ID: <3B55A12C.F194DAF6@namesys.com>
Date: Wed, 18 Jul 2001 18:46:04 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Jan Harkes <jaharkes@cs.cmu.edu>
CC: Craig Soules <soules@happyplace.pdl.cmu.edu>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
In-Reply-To: <Pine.LNX.3.96L.1010717180713.13980K-100000@happyplace.pdl.cmu.edu> <3B54BA7A.42B0E107@namesys.com> <20010718100037.A18393@cs.cmu.edu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes wrote:
> 
> On Wed, Jul 18, 2001 at 02:21:46AM +0400, Hans Reiser wrote:
> > Craig Soules wrote:
> > > Unfortunately to comply with NFSv2, the cookie cannot be larger than
> > > 32-bits.  I believe this oversight has been correct in later NFS versions.
> > >
> > > I do agree that forcing the underlying fs to "fix" itself for NFS is the
> > > wrong solution. I can understand their desire to follow unix semantics
> > > (although I don't entirely agree with them), so until I think up a more
> > > palatable solution for the linux community, I will just keep my patches to
> > > myself :)
> > >
> > > Craig
> >
> > 64 bits as in NFS v4 is still not large enough to hold a filename.
> > For practical reasons, ReiserFS does what is needed to work with NFS,
> > but what is needed bad design features, and any FS designer who
> > doesn't feel the need to get along with NFS should not have acceptance
> > of bad design be made a criterion for the acceptance of his patches.
> > Just let NFS not work for Craig's FS, what is the problem with that?
> 
> Those 64-bits could be used for a simple hash to identify the filename.

That is what reiserfs does today.  It sucks.  The performance is worse for many to most apps because
files are not in lexicographic order, and stem compression is impossible.

> 
> In any case, what happens if the file was renamed or removed between the
> 2 readdir calls. A cookie identifying a name that was returned last, or
> should be read next is just as volatile as a cookie that contains an
> offset into the directory.

No, if the file was removed, it still tells you where to start your search.  A missing filename is
just as good a marker as a present one.

Hans
