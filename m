Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTLDRaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 12:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTLDRaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 12:30:20 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:3996 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261931AbTLDRaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 12:30:14 -0500
Date: Thu, 4 Dec 2003 18:26:53 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
Message-ID: <20031204172653.GA12516@wohnheim.fh-wedel.de>
References: <1070485676.4855.16.camel@nucleon> <20031203214443.GA23693@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0312031600460.2055@home.osdl.org> <20031204141725.GC7890@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0312040712270.2055@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0312040712270.2055@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 December 2003 07:20:21 -0800, Linus Torvalds wrote:
> On Thu, 4 Dec 2003, Jörn Engel wrote:
> >
> > Isn't that a problem already handled by all compressing filesystems?
> > Or did I miss something really stupid?
> 
> Yes, compression and encryption are really the same thing from a fs
> implementation standpoint - they just have different goals. So yes, any
> compressed filesystem will largely have all the same issues.
> 
> And compression isn't very easy to tack on later either.

So - as sick as it sounds - jffs2 may actually be the fs of choice
when doing encryption, even though working on a hard drive and not
flash.  Cool. :)

> Encryption does have a few extra problems, simply because of the intent.
> In a compressed filesystem it is ok to say "this information tends to be
> small and hard to compress, so let's not" (for example, metadata). While
> in an encrypted filesystem you shouldn't skip the "hard" pieces..

Depends on how much security you really care about.  If you really
don't mind the pain involved, some metadata should explicitly *not* be
encrypted, to avoid known plaintext attacks.  To a serious attacker,
this could be a death stroke for ext[23] over cryptoloop, actually.

In real life, though, the humans are usually the weakest link, so this
doesn't matter anyway.

> (Encrypted filesystems also have the key management issues, further
> complicating the thing, but that complication tends to be at a higher
> level).

Trivial, as long as you can live with a single key for the whole
filesystem.  If that is not acceptable, there may even be problems in
the vfs already.

Jörn

-- 
Data dominates. If you've chosen the right data structures and organized
things well, the algorithms will almost always be self-evident. Data
structures, not algorithms, are central to programming.
-- Rob Pike
