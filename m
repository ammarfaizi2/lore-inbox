Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBUXoA>; Wed, 21 Feb 2001 18:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRBUXnv>; Wed, 21 Feb 2001 18:43:51 -0500
Received: from hermes.mixx.net ([212.84.196.2]:11027 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129181AbRBUXnn>;
	Wed, 21 Feb 2001 18:43:43 -0500
Message-ID: <3A945272.F13610AB@innominate.de>
Date: Thu, 22 Feb 2001 00:42:42 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@transmeta.com>, linux-kernel@vger.kernel.org,
        Martin Mares <mj@suse.cz>, Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <20010221220835.A8781@atrey.karlin.mff.cuni.cz> <XFMail.20010221132959.davidel@xmailserver.org> <20010221223238.A17903@atrey.karlin.mff.cuni.cz> <971ejs$139$1@cesium.transmeta.com> <20010221233204.A26671@atrey.karlin.mff.cuni.cz> <3A94435D.59A4D729@transmeta.com> <20010221235008.A27924@atrey.karlin.mff.cuni.cz> <3A94470C.2E54EB58@transmeta.com> <20010222000755.A29061@atrey.karlin.mff.cuni.cz> <3A944C05.FC2B623A@transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> Martin Mares wrote:
> >
> > > True.  Note too, though, that on a filesystem (which we are, after all,
> > > talking about), if you assume a large linear space you have to create a
> > > file, which means you need to multiply the cost of all random-access
> > > operations with O(log n).
> >
> > One could avoid this, but it would mean designing the whole filesystem in a
> > completely different way -- merge all directories to a single gigantic
> > hash table and use (directory ID,file name) as a key, but we were originally
> > talking about extending ext2, so such massive changes are out of question
> > and your log n access argument is right.
> 
> It would still be tricky since you have to have actual files in the
> filesystem as well.

Have you looked at the structure and algorithms I'm using?  I would not
call this a hash table, nor is it a btree.  It's a 'hash-keyed
uniform-depth tree'.  It never needs to be rehashed (though it might be
worthwhile compacting it at some point).  It also never needs to be
rebalanced - it's only two levels deep for up to 50 million files.

This thing deserves a name of its own.  I call it an 'htree'.  The
performance should speak for itself - 150 usec/create across 90,000
files and still a few optmizations to go.

Random access runs at similar speeds too, it's not just taking advantage
of a long sequence of insertions into the same directory.

BTW, the discussion in this thread has been very interesting, it just
isn't entirely relevant to my patch :-)

--
Daniel
