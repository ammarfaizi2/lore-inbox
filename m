Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbSJCTrq>; Thu, 3 Oct 2002 15:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261301AbSJCTrq>; Thu, 3 Oct 2002 15:47:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38672 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261296AbSJCTro>; Thu, 3 Oct 2002 15:47:44 -0400
Date: Thu, 3 Oct 2002 12:52:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jaroslav Kysela <perex@suse.cz>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA fixes #1
In-Reply-To: <Pine.LNX.4.33.0210032104500.521-100000@pnote.perex-int.cz>
Message-ID: <Pine.LNX.4.33.0210031241280.23619-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Oct 2002, Jaroslav Kysela wrote:
> > 
> > Note that BK really only helps if you are careful, and I can synchronize 
> > with your BK tree. The fact that your BK tree contains non-alsa stuff 
> 
> Please, remove the bksend script from Documentation/BK-usage/bksend . 
> You don't like it and it's completely crappy. BK does renumbering of 
> ChangeSets itselves. So everybody has different numbers for changesets.

The numbering is not important, and yes, it will change between merges 
etc. BK doesn't actually use the numbers for anything internally, the ID's 
for changesets are the cset "keys".

What is important (and what BK checks) is that the _parent_ has to exist 
(and that's checked through the key, not through any numbering).

> The fix changeset was made using clean clone of BK repository of linux 2.5 
> kernel tree and one "temporary" clone of first BK repository.

This particular BK changeset may have applied - a number of your earlier 
ones did not. I stopped testing (for example, your _first_ bk patch in the 
first ALSA merge _did_ apply, but the second patch did not - because it 
depended on other changes you had done outside of ALSA, in particular 
apparently you had merged code from the trivial patch tree)

> > already means that I cannot sync with it, which makes it pretty much 
> > unusable.
> 
> Are you willing to do 'bk pull' from my BK tree to avoid such problems?
> I have already a repository on bkbits.net.

I'm more than willing to do that - that's how I do most of my BK merges by
far (I used to have to accept the JFS merges as emailed BK patches,
because IBM had these strange export rules, but that's been fixed for the
last month or two already).

But I can only do that if the tree is clean - ie there aren't "random"
changes there. Ie no BK merges with other people, no non-ALSA patches etc.  
I know you've had some of those, since I've seen the effects of it through
non/applying patches, and through the fact that you obviously had the
DECLARE_BITMAP() change in your tree, even though it wasn't in mine (ie
the result of applying your patches as patches didn't actually compile
without modifications).

But if there is a clean tree to pull from, that is absolutely the 
preferred method for me to sync up, _especially_ with things like drivers. 
Then an email that just says

	Linus,
	  please do

		bk pull .....

	to receive changes to the following files

	.. diffstat list ..

	through the following changes

	 .. changset list ..

and then I don't even need to see the diffs themselves if I can just see
that it only touches the ALSA files (that's another reason why I really
want clean trees - immediately that there is a changeset to a non-ALSA
file I want to see diffs, so that I have a clue about potential conflicts)

		Linus

