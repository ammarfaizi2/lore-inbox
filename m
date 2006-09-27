Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbWI0Rv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbWI0Rv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 13:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWI0Rv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 13:51:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1710 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030501AbWI0Rv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 13:51:57 -0400
Date: Wed, 27 Sep 2006 10:51:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
cc: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <43447.192.54.193.51.1159350218.squirrel@rousalka.dyndns.org>
Message-ID: <Pine.LNX.4.64.0609271031300.3952@g5.osdl.org>
References: <43447.192.54.193.51.1159350218.squirrel@rousalka.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Sep 2006, Nicolas Mailhot wrote:
> 
> It's not as if most (all?) widespread linux-embedded devices are not
> flashable nowadays. Factory recall everytime you need to fix a
> security/feature bug just costs too much

Side note: it's not even about factory recalls, it's that flash chips are 
literally cheaper than masked roms for almost all applications.

Mask roms are expensive for several reasons:

 - they force extra development costs on you, because you have to be 
   insanely careful, since you know you're stuck with it.

   So it's not even just the cost of the recall itself: it's the 
   _opportunity_ cost of having to worry about it which tends to be the 
   biggest cost by far. Most devices never get recalled, and when they do 
   get recalled, a lot of people never bother about it. So the real cost 
   is seldom the recall itself, it's just the expense of worrying about 
   it, and wasting time on trying to make things "perfect" (which never
   really works anyway)

 - during development, mask roms are a big pain in the ass, so you need to 
   build all your development boards (even the very final one! The one 
   that is supposedly identical to the released version!) with a flash 
   anyway, even if you can only program it by setting a magic jumper or 
   something.

   So using a mask rom means that your development platform pretty much 
   will never match the actual hw platform you sell. That's a DISASTER. 
   It's like always developing and testing with the compiler using the 
   "-g" flag, but then _shipping_ the binary with "-O". Nobody sane would 
   ever do that - it just means that all your verification was basically
   useless.

 - They force you to use a specialized chip. Mass production usually means 
   that in any kind of low volumes, specialized chips are always going to 
   be more expensive.

   People seem to sometimes still believe that we live in the 1980's. Mask 
   roms used to be relatively "cheaper", because it wasn't as much about 
   standardized and huge volumes of chips. These people should please 
   realize that technology has changed in the last quarter century, and 
   we're not playing "pong" any more.

[ Side note: is there a good "pong" box you can buy? I want pong and the 
  real asteroids - the one with vector graphics. And I realize I can't 
  afford the real asteroids, but dang, there should be a realistic pong
  somewhere? Some things are hard to improve on.. ]

So even if you don't actually want to upgrade the machine, it's likely to 
have a flash in it simply because it's often _cheaper_ that way. 

And it not at all uncommon to have a flash that simply cannot be upgraded 
without opening the box. Even a lot of PC's have that: a lot (most?) PC's 
have a flash that has a separate _hardware_ pin that says that it is 
(possibly just partially) read-only. So in order to upgrade it, you'd 
literally need to open the case up, set a jumper, and _then_ run the 
program to reflash it.

People do things like that for fail-safe reasons. For example, a portion 
of the flash is read-only, just so that if a re-flashing fails, you have 
the read-only portion that verifies the signature, and if it doesn't 
match, it contains enough basic logic that you can try to re-flash again.

Those kinds of fail-safes are absolutely _critical_, and I'm not talking 
about some "hypothetical" device here. I'm talking very much about devices 
that you and me and everybody else probably use every stinking day.

In fact, I can pretty much guarantee that pretty much everybody who is 
reading this is reading it on a machine that has an upgrade facility that 
is protected by cryptographic means. Your CPU. Most of the microcode 
updaters have some simple crypto in them (although sometimes that crypto 
is pretty weak and I think AMD relies more on just not documenting the 
format).

Look into the Linux kernel microcode updater code some day, and please 
realize that it talks to one of those evil "DRM-protected devices".

And dammit, this is all OK. If people want to write a GPL'd microcode 
update, they damn well should be able to. Oh, but the GPLv3 forbids them 
from doing that without giving out the keys used to sign the result.

	"But that's ok, because the FSF is looking out for all of us, and
	 we know mommy knows best."

So it's all good.

			Linus
