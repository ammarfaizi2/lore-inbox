Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVDFL2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVDFL2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 07:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVDFL2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 07:28:36 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:24711 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262120AbVDFL2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 07:28:33 -0400
Date: Wed, 6 Apr 2005 13:28:38 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Roland Dreier <roland@topspin.com>, Paulo Marques <pmarques@grupopie.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
Message-ID: <20050406112837.GC7031@wohnheim.fh-wedel.de>
References: <4252BC37.8030306@grupopie.com> <Pine.LNX.4.62.0504052052230.2444@dragon.hyggekrogen.localhost> <521x9pc9o6.fsf@topspin.com> <Pine.LNX.4.62.0504052148480.2444@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.62.0504052148480.2444@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 April 2005 22:01:49 +0200, Jesper Juhl wrote:
> On Tue, 5 Apr 2005, Roland Dreier wrote:
> 
> >     > or simply
> >     > 	if (!(ptr = kcalloc(n, size, ...)))
> >     > 		goto out;
> >     > and save an additional line of screen realestate while you are at it...
> > 
> > No, please don't do that.  The general kernel style is to avoid
> > assignments within conditionals.
> > 
> It may be the prefered style to avoid assignments in conditionals, but in 
> that case we have a lot of cleanup to do. What I wrote above is quite 
> common in the current tree - a simple  egrep -r "if\ *\(\!\(.+=" *  in 
> 2.6.12-rc2-mm1 will find you somewhere between 1000 and 2000 cases 
> scattered all over the tree.
> 
> Personally I don't see why thy should not be used. They are short, not any 
> harder to read (IMHO), save screen space & are quite common in userspace 
> code as well (so people should be used to seeing them).
> 
> If such statements are generally frawned upon then I'd suggest an addition 
> be made to Documentation/CodingStyle mentioning that fact, and I wonder if 
> patches to clean up current users would be welcome?

I _do_ change them whenever they occur in code I maintain.  And each
time, it is an improvement.

o Functional code always has the same indentation.  I can mentally
  ignore the error path by ignoring all indented code.  Getting a
  quick overview is quite nice.

o Rather often, your preferred variant violates the 80 columns rule.
  If I need the line break anyway,...

o Keeping condition and functional code seperate avoids the Lisp-style
  bracket maze.  Some editors can help you here, but not needing any
  help would be even better, no?

Jörn

-- 
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens
