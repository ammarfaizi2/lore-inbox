Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbSKJShB>; Sun, 10 Nov 2002 13:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265052AbSKJShB>; Sun, 10 Nov 2002 13:37:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32517 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265051AbSKJShA>; Sun, 10 Nov 2002 13:37:00 -0500
Date: Sun, 10 Nov 2002 10:43:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BOGUS: megaraid changes 
In-Reply-To: <200211101632.gAAGWln11508@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0211101039100.9581-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Nov 2002, J.E.J. Bottomley wrote:
> 
> How about this?  It doesn't panic, just refuses to attach the driver (although 
> this will still eventually cause a panic if your root fs is on it).

I think this is worse than the current state of art. We don't want to 
screw with users who can't do anything about it, which is 99.9% of them. 
TESTING is about as important as anything else, and inconveniencing users 
is BAD BAD BAD. 

Right now drivers with old EH handling will warn at compile time (except 
when people explicitly disable it, like in megaraid, which is in the 
process of getting fixed anyway). That's a lot better than irritating 
users. Especially since this printk() will possibly have scrolled off the 
screen by the time the "cannot load root" happens.

I've said this before, I'll say it again: anything that breaks _working_ 
is BAD. Don't do it. Don't make up new ways to screw with people who want 
to test. Don't add features that have _no_ meaning except to irritate 
people.

The compile-time warning is _plenty_ good enough.

		Linus

