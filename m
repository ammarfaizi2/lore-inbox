Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbULLAGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbULLAGR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 19:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbULLAGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 19:06:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:27067 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262040AbULLAGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 19:06:05 -0500
Date: Sun, 12 Dec 2004 01:05:49 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Simos Xenitellis <simos74@gmx.net>
cc: David =?ISO-8859-1?Q?G=F3mez?= <david@pleyades.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Improved console UTF-8 support for the Linux kernel?
In-Reply-To: <1102803807.3183.59.camel@kl>
Message-ID: <Pine.LNX.4.61.0412120058230.15129@yvahk01.tjqt.qr>
References: <1102784797.4410.8.camel@kl> <20041211173032.GA13208@fargo> 
 <Pine.LNX.4.53.0412112002020.30929@yvahk01.tjqt.qr> <1102803807.3183.59.camel@kl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-2051421612-1102809949=:15129"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-2051421612-1102809949=:15129
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>I am a bit confused. Could you please comment on the following, as a
>common test steps?

I do it a bit faster (i.e. without "od"): if after a Compose operation, I see 
something, it must have been UTF8. If not (like there has been only 8 bits 
output), the current line screws up a little. <- My test strategy; does not 
need `od` to confirm.

>I am not sure how you wrote the above characters. According to UTF-8,
>characters with codepoints above 0x79 require two bytes so that to be
>valid. When you compose "ö" (you press something like ";", then "o") in
>the console?

ö is a "native key" on my keyboard, i.e. i do not need to play with compose to 
generate ö.

>For simplicity, let's assume you do something like
% loadkeys --unicode
compose '/' 'e' to U+00F6 # ('ö')
^D
% 

I did that (a shortened form of yours), and saw by `dumpkeys` that there was 
now only one compose table entry, so I think `loadkeys --unicode` overwrites 
the table? Rightly so.
Still and despite there are now no compose table entries, with the exception of 
that one, I can still generate ö. <compose><"><o> rightly gives two 7-bit 
characters (rightly so at this point).

>Good. I hope more people raise their hands for this.

...want kanji-on-console, but I guess that will not come true with VGA, which 
only supports 256 (512) chars. OTOH, [free]BSD's mouse support uses a graphical 
mouse pointer rather than a "block" one like gpm does, and as I think of it, 
such a graphical mouse (most Norton apps for DOS also had such) needs some VGA 
magic or so to set single "pixels"/bits. If single bits within the 8x{16,etc.} 
char cell can be set, we could have kanji.
Can anyone elaborate on this graphical mouse stuff?



Jan Engelhardt
-- 
ENOSPC
--1283855629-2051421612-1102809949=:15129--
