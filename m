Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267884AbRGROBH>; Wed, 18 Jul 2001 10:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267886AbRGROA5>; Wed, 18 Jul 2001 10:00:57 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:22937 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S267884AbRGROAs>; Wed, 18 Jul 2001 10:00:48 -0400
Date: Wed, 18 Jul 2001 10:00:38 -0400
To: Hans Reiser <reiser@namesys.com>
Cc: Craig Soules <soules@happyplace.pdl.cmu.edu>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
Message-ID: <20010718100037.A18393@cs.cmu.edu>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Craig Soules <soules@happyplace.pdl.cmu.edu>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96L.1010717180713.13980K-100000@happyplace.pdl.cmu.edu> <3B54BA7A.42B0E107@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B54BA7A.42B0E107@namesys.com>
User-Agent: Mutt/1.3.18i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2001 at 02:21:46AM +0400, Hans Reiser wrote:
> Craig Soules wrote:
> > Unfortunately to comply with NFSv2, the cookie cannot be larger than
> > 32-bits.  I believe this oversight has been correct in later NFS versions.
> > 
> > I do agree that forcing the underlying fs to "fix" itself for NFS is the
> > wrong solution. I can understand their desire to follow unix semantics
> > (although I don't entirely agree with them), so until I think up a more
> > palatable solution for the linux community, I will just keep my patches to
> > myself :)
> > 
> > Craig
> 
> 64 bits as in NFS v4 is still not large enough to hold a filename.
> For practical reasons, ReiserFS does what is needed to work with NFS,
> but what is needed bad design features, and any FS designer who
> doesn't feel the need to get along with NFS should not have acceptance
> of bad design be made a criterion for the acceptance of his patches.
> Just let NFS not work for Craig's FS, what is the problem with that?

Those 64-bits could be used for a simple hash to identify the filename.

In any case, what happens if the file was renamed or removed between the
2 readdir calls. A cookie identifying a name that was returned last, or
should be read next is just as volatile as a cookie that contains an
offset into the directory.

Jan

