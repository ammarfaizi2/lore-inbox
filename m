Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267898AbRGROsW>; Wed, 18 Jul 2001 10:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267899AbRGROsK>; Wed, 18 Jul 2001 10:48:10 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:17417 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267892AbRGROrx>; Wed, 18 Jul 2001 10:47:53 -0400
Message-ID: <3B55A14B.9ADBFC0A@namesys.com>
Date: Wed, 18 Jul 2001 18:46:35 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Craig Soules <soules@happyplace.pdl.cmu.edu>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
In-Reply-To: <Pine.LNX.3.96L.1010717180713.13980K-100000@happyplace.pdl.cmu.edu> <3B54BA7A.42B0E107@namesys.com> <01071815300708.12129@starship>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Wednesday 18 July 2001 00:21, Hans Reiser wrote:
> > Craig Soules wrote:
> > > On Wed, 18 Jul 2001, Hans Reiser wrote:
> > > > I take issue with the word "properly".  We have bastardized our
> > > > FS design to do it.  NFS should not be allowed to impose stable
> > > > cookie maintenance on filesystems, it violates layering.  Simply
> > > > returning the last returned filename is so simple to code, much
> > > > simpler than what we have to do to cope with cookies.  Linux
> > > > should fix the protocol for NFS, not ask Craig to screw over his
> > > > FS design.  Not that I think that will happen.....
> > >
> > > Unfortunately to comply with NFSv2, the cookie cannot be larger
> > > than 32-bits.  I believe this oversight has been correct in later
> > > NFS versions.
> > >
> > > I do agree that forcing the underlying fs to "fix" itself for NFS
> > > is the wrong solution. I can understand their desire to follow unix
> > > semantics (although I don't entirely agree with them), so until I
> > > think up a more palatable solution for the linux community, I will
> > > just keep my patches to myself :)
> > >
> > > Craig
> >
> > 64 bits as in NFS v4 is still not large enough to hold a filename.
> > For practical reasons, ReiserFS does what is needed to work with NFS,
> > but what is needed bad design features, and any FS designer who
> > doesn't feel the need to get along with NFS should not have
> > acceptance of bad design be made a criterion for the acceptance of
> > his patches.  Just let NFS not work for Craig's FS, what is the
> > problem with that?
> 
> I was planning to add coalesce-on-delete to my ext2 directory index
> patch at some point, now I see I'll step right into this NFS
> doo-d^H^H^H^H^H problem.  What to do?  Obviously it's not an option
> to have NFS not work for ext2.  Just leaving the directory
> uncoalesced fixes the problem in some sense and doesn't hurt things
> all that much.  Ext2 has been running that way for years.
> 
> Can I automagically know that a directory is mounted via NFS and
> disable the coalescing?  Or maybe I need a -o coalesce=on/off, with
> "off" as the default.  Ugh.
> 
> As you point out, this sucks.
> 
> --
> Daniel

The NFS v4 committee clowns had this pointed out to them, and failed to fix it.  I personally think
we should just fix Linux NFS to use filenames as cookies if both client and server are
"v4.cookie_monster" compliant.  That is not to say that I actually have a person free to do that
work, but it sure gets tempting at times.....

When we implement more advanced directories for ReiserFS (which we deferred doing until after
Reiser4), we will probably have to code up a v4.cookie_monster implementation.

Hans
