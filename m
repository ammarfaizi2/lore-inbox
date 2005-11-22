Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVKVJ40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVKVJ40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 04:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVKVJ40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 04:56:26 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:50392 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S964875AbVKVJ4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 04:56:25 -0500
Date: Tue, 22 Nov 2005 10:56:39 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Matthew Frost <artusemrys@sbcglobal.net>
Cc: Marc Koschewski <marc@osknowledge.org>,
       Steven Rostedt <rostedt@goodmis.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Xose Vazquez Perez <xose.vazquez@gmail.com>
Subject: Re: [RFC] Documentation dir is a mess
Message-ID: <20051122095639.GA6724@stiffy.osknowledge.org>
References: <20051121173404.GA7886@stiffy.osknowledge.org> <20051122060648.8827.qmail@web81904.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122060648.8827.qmail@web81904.mail.mud.yahoo.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Frost <artusemrys@sbcglobal.net> [2005-11-21 22:06:48 -0800]:

> --- Marc Koschewski <marc@osknowledge.org> wrote:
> 
> > * Steven Rostedt <rostedt@goodmis.org> [2005-11-20 20:56:59 -0500]:
> > 
> > > On Sun, 2005-11-20 at 16:30 -0800, Greg KH wrote:
> > > > On Sun, Nov 20, 2005 at 01:19:09PM +0100, Xose Vazquez Perez wrote:
> > > > > hi,
> > > > > 
> > > > > _today_ Documentation/* is a mess of files. It would be good
> > > > > to have the _same_ tree as the code has:
> > > > 
> > > > Do you have a proposal as to what specific files in that directory
> > > > should go where?  Just basing it on the source tree will not get
> > > > you very far...
> > > 
> > > Actually I think it's a good start.  When I'm looking for
> > > documentation, I usually just do a grep -r on the Documentation
> > > directory hoping I get a correct hit and then manually look 
> > > through all the results I get. 
> > > It does get tedious, and I miss things all the time.
> > 
> > As you're just about to maybe make a decision on reorganisation: how
> > about a separation of user- and developer-relevant documentation? 
> > I mean, kernel boot parameters are relevant to a user whereas 
> > mm/* stuff is not.
> 
> There's a problem in the general conception that user/developer is a
> mutex.  The whole idea is that anyone may become a developer at will.  A
> division of Documentation/ to make an artificial distinction that the
> community doesn't necessarily believe in doesn't seem too useful.

Sure, a developer is always a user. But even if so, we could, however,
split some docs into a developer and an end-user part. Configuring
PCMCIA doesn't mean I wanted to be 'bothered' by some internals of the
implementation.

What about a such an approach?

Documentation/howto/.../...
Documentation/howto/pcmcia/...
Documentation/howto/.../...
Documentation/dev/...
Documentation/dev/pcmcia/...
Documentation/dev/...

> 
> Now, I don't mean to suggest that you're wrong; I'm sure you have a valid
> point.  If I may rephrase, it sounds more like you're looking for
> "fingertip reference" versus "in-depth documentation".  The documents
> that exist may not conform themselves well to that sort of division,
> necessarily.  However, I'm sure that there exist fingertip references
> outside of Documentation/ and the kernel tree; many of them are for
> 'newbies'.
> 

Most docs out there one may find through Google or whatever mostly hit
one particular case. Ie. 'PCMCIA networking device on DELL Inspiron
8200' and not just a common information on how PCMCIA networking is
setup in userland.

Moreover, having such information within the Documentation tree would
make sense as a user has information on how to _use_ a sub-system right
when she _enables_ the sub-system (via new kernel installation).

If the docs would be in a commonly used form (Headlines, prerequisites
[tools], ...) it would just be a benefit.

Besides this, it would be nice to reflect the source tree just _a bit_
within the Documentation tree - ie. create a Documentation/drivers dir
within information on drivers along with their supported devices in a
human readable form (no device IDs) and the params the module is able to
handle. Sure, there's 'modinfo'. But let's have a look ...

['sg' is just a common module, no particular reason I took this one]

marc@stiffy:~$ modinfo sg
filename:       /lib/modules/2.6.15-rc2-marc/kernel/drivers/scsi/sg.ko
author:         Douglas Gilbert
description:    SCSI generic (sg) driver
license:        GPL
version:        3.5.33
alias:          char-major-21-*
vermagic:       2.6.15-rc2-marc preempt PENTIUM4 gcc-4.0
depends:        scsi_mod
srcversion:     B8A3D2FFE5BA5BB2348A9AC
parm:           allow_dio:allow direct I/O (default: 0 (disallow)) (int)
parm:           def_reserved_size:size of buffer reserved for each fd
(int)
marc@stiffy:~$

What does a non-developer get out of 'allow direct I/O'?
- What id direct I/O?
- How does it affect performance?
- What are the common pitfalls? 
- Why do I have the choice at all?

What does a non-developer get out of 'size of buffer reserved for each fd'?
- What is a buffer?
- What size is best? Rather small? Rather big? Dependant on my system?
- What are the common pitfalls? 
- Why do I have the choice at all?

There are things to answer. And not Google does answer these question.
Most users (and even more the newbies) are unable to get such
information out of Google. I know people having PCs (with or without
Linux) who are unable to get any relevant technical information out of
Google although they used computers for years now.

Marc

> Is this a useful interpretation?  Would an incorporation of this sort of
> functional division meet your request?  Does anyone have the time to
> devote to it?  Am I just reading out of the bit bucket?
> 
> Matt
