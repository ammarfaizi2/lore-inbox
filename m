Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261542AbTCKTQA>; Tue, 11 Mar 2003 14:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbTCKTQA>; Tue, 11 Mar 2003 14:16:00 -0500
Received: from mx01.nexgo.de ([151.189.8.96]:20189 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id <S261542AbTCKTP5>;
	Tue, 11 Mar 2003 14:15:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Zack Brown <zbrown@tumblerings.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Date: Tue, 11 Mar 2003 20:30:26 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030311184043.GA24925@renegade> <22230000.1047408397@flay>
In-Reply-To: <22230000.1047408397@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030311192639.E72163C5BE@mx01.nexgo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11 Mar 03 19:46, Martin J. Bligh wrote:
> > I've taken a lot of stuff from that wish list, combined it with what I
> > gathered from Larry's earlier post, and from Petr Baudis' recent post,
> > and elsewhere, and organized it into something that might be interesting.
> > If anyone would like to host this document on the web, please let me
> > know.
>
> Not sure if this was captured before (I don't see it explicitly in what
> you sent), but one thing that I don't think current tools do well is to
> keep changes seperated out. We need to be able to put a stack of 200
> patches on top of 2.5.10, then be able to break those out again easily
> come 2.5.60, once we've merged forward. Treating things as one big blob
> will work great for Linus, but badly for others.

Coincidently, I was having a little think about that exact thing earlier 
today.  Suppose we call the process of turning an exact delta into a 
delta-with-context, "softening".  So you select a set of deltas somehow 
(e.g., all deltas in wild-card set of files) then soften them by adding 
context, or in the deluxe version, convert to lists of tokens with whitespace 
markup.  The result is a first-class object in the database, called a, hmm, 
soft changeset?  (Surely there is a better name.)

A soft changeset can be carried forward in the database automatically as long 
as there are no conflicts (like patch with fuzz) and where there are 
conflicts, the soft changeset itself can be versioned.  To implement soft 
changeset versioning the lazy way, just merge the changeset with some version 
and generate a new soft changeset against some other version.  A name for the 
versioned soft changeset can be generated automatically, e.g.:

   changset.name-from.version-to.version.

You can wave your wand, and the soft changeset will turn into a universal 
diff or a BK changeset.  But it's obviously a lot cleaner, extensible, 
flexible and easier to process automatically than a text diff.  It's an 
internal format, so it can be improved from time to time with little or no 
breakage.

Did that make sense?

> At the moment, I slap the patches back on top of every new version
> seperately, which works well, but is a PITA.

Tell me about it.

> I hear this is something
> of a pain to do with Bitkeeper (don't know, I've never tried it).
> People muttered things about keeping 200 different views, which is
> fine for hardlinked diff & patch (takes < 1s to clone normally), but
> I'm not sure how long a merge would take in Bitkeeper this way? Perhaps
> people who've done this in other SCM's could comment?

I've never seriously used any commercial SCM, so nobody can accuse me of 
stealing their ideas.  On the other hand, it means I may have to take a few 
shots way wide of the target before hitting any bullseyes.

Regards,

Daniel
