Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSG3Vn3>; Tue, 30 Jul 2002 17:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316693AbSG3Vn2>; Tue, 30 Jul 2002 17:43:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35076 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316705AbSG3Vmy>; Tue, 30 Jul 2002 17:42:54 -0400
Date: Tue, 30 Jul 2002 14:46:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
In-Reply-To: <20020730233542.A23181@ucw.cz>
Message-ID: <Pine.LNX.4.33.0207301441050.2051-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Jul 2002, Vojtech Pavlik wrote:
> 
> Now the question remaining is how to fix that? You can just skip the
> patch. I've tried a 'bk undo', but that complains about unmerged leaves
> in that case (though really nothing depends on those changes). Or should
> I just make another cset on top of all the previous?

Ugh. there's a few things you can do

 - I often actually do a "bk undo -axxx" and then just re-do the parts I 
   want to re-do.

   NOTE! This only works if you haven't already had people pull from your 
   repository (or you'll need to ask them to do the "bk undo" as well).

 - You can reverse the cset, which means that it's still there, but there 
   is also a cset that says "undo that other cset". I prefer to not pull 
   those kinds of undo's, but they do happen, and I occasionally do them
   myself. I try to avoid it, but it's very useful for debugging ("does 
   that problem go away if I undo just that one cset?"), and sometimes 
   it _is_ the sanest way to go.

   So do "bk cset -xA.BBB"

 - in this case, maybe just adding a new cset is the proper thing. 
   Especially as reversing the cset doesn't actually get you where you
   want anyway, since you'd still have to do the "unsigned short" -> "u16"  
   translation as yet another cset.

I only get upset if the tree looks _really_ cluttered, in which case I may 
ask you to re-do it (that's happened once with the reiserfs tree).

			Linus

