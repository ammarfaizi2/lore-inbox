Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281224AbRKEQvA>; Mon, 5 Nov 2001 11:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281227AbRKEQuu>; Mon, 5 Nov 2001 11:50:50 -0500
Received: from geos.coastside.net ([207.213.212.4]:13043 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S281224AbRKEQui>; Mon, 5 Nov 2001 11:50:38 -0500
Mime-Version: 1.0
Message-Id: <p05100316b80c6f3df6f3@[207.213.214.37]>
In-Reply-To: <20011105111239.3403b162.rusty@rustcorp.com.au>
In-Reply-To: <E15zF9H-0000NL-00@wagner>
 <15zGYm-1gibkeC@fmrl05.sul.t-online.com>
 <20011102132014.41f2d90a.rusty@rustcorp.com.au>
 <20011104013951Z16981-4784+741@humbolt.nl.linux.org>
 <20011105111239.3403b162.rusty@rustcorp.com.au>
Date: Mon, 5 Nov 2001 08:49:04 -0800
To: Rusty Russell <rusty@rustcorp.com.au>,
        Daniel Phillips <phillips@bonn-fries.net>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Cc: tim@tjansen.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:12 AM +1100 11/5/01, Rusty Russell wrote:
>Firstly, do not perpetuate the myth of /proc being "human readable".  (Hint:
>what language do humans speak?)  It supposed to be "admin readable" and
>"machine readable".

That's the key observation, seems to me. In our development, we've 
adopted a standard of tagged values, where a single-value file is 
tagged by its name, and multiple-value files have a tag:value per 
line (where value might be an n-tuple).

The result is easy to parse for userland code that needs the values 
and relatively easy (because ASCII and consistent) for admins to 
read. A pretty-printer provides an interface for mere humans.

I suppose one could add typing information as well, but it seems to 
me that a reader of /proc/stuff is either completely ignorant of the 
content (eg cat), and typing is irrelevant, or it knows what's there 
(eg ps) and typing is redundant, as long as there are unambiguous 
tags.

I think of the tagged list of n-tuples as a kind of ASCII 
representation of a simple struct. One could of course create a 
general ASCII representation of a C struct, and no doubt it's been 
done innumerable times, but I don't think that helps in this 
application.

Of course, one tagged value can be "version"....
-- 
/Jonathan Lundell.
