Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267495AbUIJPhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267495AbUIJPhc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUIJPgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:36:54 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:21417 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S267497AbUIJPgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:36:15 -0400
Message-Id: <200409101533.i8AFX5um004647@localhost.localdomain>
To: Hans Reiser <reiser@namesys.com>
cc: Timothy Miller <miller@techsource.com>, Jamie Lokier <jamie@shareable.org>,
       Adrian Bunk <bunk@fs.tum.de>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Thu, 09 Sep 2004 22:22:51 MST." <41413A2B.9020405@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 10 Sep 2004 11:33:05 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> said:
> A friend asked me a question, and because he is very bright it reminded 
> me that I have not done a good job of reviewing the history of the 
> design's evolution.

The design's evolution, and your friend's question, are irrelevant. Might
be a nice story, but not relevant to discuss the _current_ design, its
shortcommings, and possible solutions.

> He asked me, why not just access a filename's size as filename/size?

Urgh.

> So, the original idea was to access metafiles as just files within a 
> directory, and it actually remains that way. However, I first decided to 
> make the standard unix metafiles less intrusive on the namespace. So 
> that led to calling it filename/..size and filename/..owner, etc. In 
> this scheme, the use of '..' was just a style convention for metafiles, 
> and not a requirement in anyway.

Oh, so metafiles could have any names at all. Awful.

> This was actually pretty decent as a design,

Could have been worse, true. Not very much, anyway.

>                                              but then a user on the 
> mailing list suggested replacing the '..' prefix with a subdirectory 
> prefix. I forget who suggested this and what the prefix was exactly. So 
> we then created a '..metas' subdirectory,

Bad design. As Ted explained, _any_ "normal" name in there will lead to
legacy applications do the wrong thing unaware of the special status of
this stuff, and this is sure to break things and/or to lead to nasty
security problems.

>                                           and this had the advantage 
> that one could ls it to see all the builtins supported by a given 
> plugin.

What kind of builtins? What is a "plugin"?

>         This is not an important advantage, and I encourage others to 
> critique it.

If it is not important, let's postpone any discussion on it until (if ever)
the important problems are solved.

> So, instead of filename/size we have filename/..metas/size. The only 
> thing gained by this is that 'size' has a rarer name of '..metas/size'. 

English, please.

> The use of the '..metas/' prefix is purely a non-mandated style 
> convention.

So it isn't mandated, and I could decide placing my own stuff under other
names, willy-nilly? See the comment above on "normal names" being
dangerous; if it hasn't a builtin way of ensuring legacy (or even new
applications) don't trip over this stuff, it is a moby nightmare security
and correctness wise.

>             File plugins that dislike it are free to violate the 
> convention. There is no deep semantic to it, just a cowardly aversion to 
> intruding on current namespace usage

"Common" and "current usage" is important to the average user, "normal" is
crucial for correctness and security,

>                                      with something as common as 'size'. 
> It has the significant disadvantage of being a longer name than 'size' 
> or '..size'. I could be talked out of it.

So far, I've seen no real reason to introduce this. If it is scrapped,
there will be no need to talk anybody out of silly ideas.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
