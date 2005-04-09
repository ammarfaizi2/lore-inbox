Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVDIQwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVDIQwe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 12:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVDIQwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 12:52:34 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:49381 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261240AbVDIQwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 12:52:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=oY04axRbgxBgux4Ja++1vGZW3fSmi9es5nuH3Ap227Gk5fAyt+3EqalluBTNKhpPD4UngoXhbJbLaL3Jzp5FWmdNGWZS8b1DRcNy6VEr85lboDOzB3kMHx6Ir3txIY0YLr3T4E8KzvjxWNLUdmceEmDR7a8hItSAKT+xfxiHWNY=
Message-ID: <311601c905040909525ef8242e@mail.gmail.com>
Date: Sat, 9 Apr 2005 10:52:30 -0600
From: "Eric D. Mudama" <edmudama@gmail.com>
Reply-To: "Eric D. Mudama" <edmudama@gmail.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Kernel SCM saga..
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0504072318010.15339@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <1112858331.6924.17.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org>
	 <Pine.LNX.4.61.0504072318010.15339@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 8, 2005 4:52 PM, Roman Zippel <zippel@linux-m68k.org> wrote:
> The problem is you pay a price for this. There must be a reason developers
> were adding another GB of memory just to run BK.
> Preserving the complete merge history does indeed make repeated merges
> simpler, but it builds up complex meta data, which has to be managed
> forever. I doubt that this is really an advantage in the long term. I
> expect that we were better off serializing changesets in the main
> repository. For example bk does something like this:
> 
>         A1 -> A2 -> A3 -> BM
>           \-> B1 -> B2 --^
> 
> and instead of creating the merge changeset, one could merge them like
> this:
> 
>         A1 -> A2 -> A3 -> B1 -> B2
> 
> This results in a simpler repository, which is more scalable and which
> is easier for users to work with (e.g. binary bug search).
> The disadvantage would be it will cause more minor conflicts, when changes
> are pulled back into the original tree, but which should be easily
> resolvable most of the time.

The kicker comes that B1 was developed based on A1, so any test
results were based on B1 being a single changeset delta away from A1. 
If the resulting 'BM' fails testing, and you've converted into the
linear model above where B2 has failed, you lose the ability to
isolate B1's changes and where they came from, to revalidate the
developer's results.

With bugs and fixes that can be validated in a few hours, this may not
be a problem, but when chasing a bug that takes days or weeks to
manifest, that a developer swears they fixed, one has to be able to
reproduce their exact test environment.

I believe that flattening the change graph makes history reproduction
impossible, or alternately, you are imposing on each developer to test
the merge results at B1 + A1..3 before submission, but in doing so,
the test time may require additional test periods etc and with
sufficient velocity, might never close.  This is the problem CVS has
if you don't create micro branches for every single modification.

--eric
