Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136695AbREATUi>; Tue, 1 May 2001 15:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136699AbREATU3>; Tue, 1 May 2001 15:20:29 -0400
Received: from hera.cwi.nl ([192.16.191.8]:49616 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S136695AbREATUS>;
	Tue, 1 May 2001 15:20:18 -0400
Date: Tue, 1 May 2001 21:20:12 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105011920.VAA57933.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org, stian@sletner.com
Subject: Re: [PATCH] Dead keys
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From stian@sletner.com Tue May  1 20:05:26 2001

	Normally, you wouldn't notice this too much, since the compose rules
	are set up in such a way that you can use the dead keys to compose what
	you would expect, anyway.  However, if you were to press a dead key and
	then space, or some un-composable key (to get the dead key character by
	itself), you would get the wrong character.  Instead of '¨' (ISO 8859-1
	decimal 168: DIAERESIS), you would get '"' (ASCII decimal 34); instead
	of '´' (ISO 8859-1 decimal 180: ACUTE ACCENT), you would get '\'' (ASCII
	decimal 39); and instead of '¸' (ISO 8859-1 decimal 184: CEDILLA), you
	would get ',' (ASCII decimal 44).

	I took the liberty of creating a patch that changes this in keyboard.c,
	and also adds compose rules to defkeymap.map so they can be used
	properly.  If there is some reason why this shouldn't be applied, I'd
	like to know what, since this makes my console life easier. :)

I think the main reason why it shouldn't be applied is that it changes
something. This keyboard stuff is unbelievably complicated. Many people
and distributions have wrestled with it and have got it working for them.
When you change stuff, you force people to start worrying about this again.

[In other words, a global rewrite may be allowed, but non-compatible changes
in a few details only is really a bad idea.]

But there are other reasons why your patch is a bad idea. Everybody has
a double quote in his keymap, so using that to create umlauts is easy.
Only few people have a diaeresis in their keymap, so requiring a diaeresis
makes life more difficult for most people.
(In other words, composing ASCII to make ISO 8859-1 is better than composing
ISO 8859-1 to make ISO 8859-1.)

Finally, you have loadkeys. If you change your private keymap
you achieve what you desire for yourself without disturbing others.

Andries
