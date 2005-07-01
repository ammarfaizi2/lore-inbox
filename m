Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263272AbVGAIGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbVGAIGt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 04:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbVGAIGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 04:06:48 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:5638 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S263269AbVGAIGS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 04:06:18 -0400
Message-ID: <42C4F97B.1080803@slaphack.com>
Date: Fri, 01 Jul 2005 03:06:19 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubert Chan <hubert@uhoreg.ca>
Cc: Ross Biro <ross.biro@gmail.com>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca>	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>	<8783be6605062914341bcff7cb@mail.gmail.com> <878y0svj1h.fsf@evinrude.uhoreg.ca>
In-Reply-To: <878y0svj1h.fsf@evinrude.uhoreg.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Chan wrote:
> On Wed, 29 Jun 2005 17:34:41 -0400, Ross Biro <ross.biro@gmail.com> said:
> 
> 
>>I'm confused.  Can someone on one of these lists enlighten me?
> 
> 
>>How is directories as files logically any different than putting all
>>data into .data files and making all files directories (yes you would
>>need some sort of special handling for files that were really called
>>.data).  Then it's just a matter of deciding what happens when you
>>call open and stat on one of these files?
> 
> 
> Logically, I don't think there is a difference. A filesystem that
> doesn't support file-as-dir could implement the same functionality that
> way. [1]  In fact, that's essentially what MacOS X/NeXTSTEP does with its
> bundle format -- it's just a regular directory with regular files
> inside.

I, personally, would hate it if everything in my /bin suddenly became a 
directory, mainly because everything would stop working.  Is that the 
kind of thing you're suggesting?

I'm a little confused about the .data idea, I guess.

>>But we could have a whole new set of system calls that treat things as
>>magic, and if files as directories is as cool as many people think,
>>apps will start using the new api.  If not, they won't and the new api
>>can be deprecated.
> 
> 
> File-as-dir doesn't require new system calls (that I know of), which is
> the whole point of the idea.  Existing programs can edit the strange new
> attributes without being modified.

That is indeed the point, but scroll down.

> The main thing blocking file-as-dir is that there are some
> locking(IIRC?) issues.  And, of course, some people wouldn't want it to
> be merged into the mainline kernel.  (Of course, the latter doesn't
> prevent Namesys from maintaining their own patches for people to play
> around with.)

What's the locking issue?  I think that was more about transactions...

[...]
> People like Horst (and probably others, who are less vocal), I think,
> don't think that it's even worth trying it out because they don't see
> any major advantages.  Or at least they think that the potential
> negatives outweigh the potential positives.  I respect that they have
> different opinions, but I of course disagree and attempt to convince
> them otherwise.

Did the /meta (metafs) idea get killed while I was out?  Using that 
approach, your potential negatives are that apps which crawl the entire 
FS tree, starting at /, with hardcoded apps for /proc and /sys, are now 
broken -- but then, /sys already broke them once, so I don't 
particularly care if we break them again.

Potential positives?  I think even just because we like the idea is 
enough, because it doesn't break anything and doesn't really affect 
anyone who doesn't use it.

Maybe there are coding standards, but I think others are working that 
out now.
