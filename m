Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135494AbRECX6v>; Thu, 3 May 2001 19:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135498AbRECX6m>; Thu, 3 May 2001 19:58:42 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:51729 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S135494AbRECX6f>;
	Thu, 3 May 2001 19:58:35 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105032358.f43NwOB84159@saturn.cs.uml.edu>
Subject: Re: Why recovering from broken configs is too hard
To: esr@thyrsus.com
Date: Thu, 3 May 2001 19:58:24 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org (CML2), kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010503034755.A27693@thyrsus.com> from "Eric S. Raymond" at May 03, 2001 03:47:55 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond writes:

> What you know, to start with, is (a) the configuration, (b) the
> constraints, (c) the shape of the menu tree, and (d) which constraints
> have failed.  What you want to do is find a set of corrected
> configurations which fulfill all constraints and are in some sense
> "close" to the broken one you have.  

You also know:
(e) the default config, with which you may compare the broken one

> The obvious thing to try is to start with the configuration you have
> and try mutating the variables that occur in the broken constraint(s).
> Of course, there are 3^n of these where n is the number of distinct
> variables, so this is going to blow up really fast; 3, 9, 27, 81, 243
> and we ain't even to six symbols yet.  By the time we get to the
> twelve variables that could be linked by just *one* constraint, there
> are 531,441.  Even if you can check 500 configurations a second it's
> going to take 16 minutes just to get a candidate list.

500/second seems very slow. Can't you do 1000 times that?
http://www.cs.bgu.ac.il/~omri/Humor/write_in_c.html

You could keep the bulk of your code in Python, and write a
separate config fixer in C.

> There's a third way. The cheap, dirty attack on the satisfaction 
> problem is to use what's called a "stochastic" or "hill-climbing"
> algorithm.  It's a less ambitious version of the brute-force search
> that essentially random-walks through the configuration
> space looking for valid ones.
> 
> The problem with stochastic search is that (a) it's not guaranteed
> to find a model even if models exist, and (b) you can't predict its
> running time.  Oops...
>
> Even assuming we could generate large numbers of candidate models
> quickly, I've been putting the word "close" in quotes because there's
> another nasty problem lurking here.  "Close" is not well-defined in
> this space.

Procedure:

1. throw out all junk symbols (could try spell checking first)
2. mark non-default settings as read-only
3. add missing symbols as needed to meet constraints
4. add any additional missing symbols
5. mutate the config until it works... user may ^C when bored

Rules for mutation:

1. do not modify what the user set (see #2 above)
2. configs that differ little from the one you start with are more fit
3. configs that violate fewer constraints are more fit
4. option 'm' should be the most likely mutation
5. symbols that were missing should be most likely to mutate
6. fit configs breed with each other of course

This will fix common errors. Obviously it can't fix the case
of a user with non-default settings that conflict. That is
good, because I don't want a tool to disobey me.

The above ought to work well for a config file with only a
half dozen entries. List what you care about, and let the
tool make everything right.
