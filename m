Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752038AbWG1Qhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbWG1Qhb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbWG1Qhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:37:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752038AbWG1Qha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:37:30 -0400
Date: Fri, 28 Jul 2006 09:33:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Masover <ninja@slaphack.com>
cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jeff@garzik.org>, Hans Reiser <reiser@namesys.com>,
       Andrew Morton <akpm@osdl.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view"
 expressed by kernelnewbies.org regarding reiser4 inclusion)
In-Reply-To: <44CA31D2.70203@slaphack.com>
Message-ID: <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org>
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl>
 <44CA31D2.70203@slaphack.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Jul 2006, David Masover wrote:
> 
> But what's wrong with people doing such experiments outside the kernel?
> AFAICS, "exotic, site-specific one" is not something that would be considered
> for inclusion.

Here's a few ground rules at least from my viewpoint:

 - as long you call them "plugins" and treat them as such, I (and I 
   suspect a lot of other people) are totally uninterested, and in fact, a 
   lot of people will suspect that the primary aim is to either subvert 
   the kernel copyright rules, or at best to create a mess of incompatible 
   semantics with no sane overlying rules for locking etc.

 - the kernel does not, and _will_ not, support "hooks" that aren't 
   actually used (and make sense) by normal kernel uses, for largely the 
   same reasons. Interfaces need to be architected, make sense, and have 
   real and valid GPL'd uses.

In other words, if a filesystem wants to do something fancy, it needs to 
do so WITH THE VFS LAYER, not as some plugin architecture of its own. We 
already have exactly the plugin interface we need, and it literally _is_ 
the VFS interfaces - you can plug in your own filesystems with 
"register_filesystem()", which in turn indirectly allows you to plug in 
your per-file and per-directory operations for things like lookup etc.

If that isn't enough, then the filesystem shouldn't make its own internal 
plug-in architecture that bypasses the VFS layer and exposes functionality 
that isn't necessarily sane. For example, reiser4 used to have (perhaps 
still does) these cool files that can be both directories and links, and I 
don't mind that at all, but I _do_ mind the fact that when Al Viro (long 
long ago) pointed out serious locking issues with them, those seemed to be 
totally brushed away.

So as far as I'm concerned, the problem with reiser4 is that it hasn't 
tried to work with the VFS people. Now, I realize that the main VFS people 
aren't always easy to work with (Al and Christoph, take a bow), but that 
doesn't really change the basic facts. Al in particular is _always_ right. 
I don't think I've ever had the cojones to argue with Al..

			Linus
