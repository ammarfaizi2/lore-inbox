Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270627AbRHNQ7u>; Tue, 14 Aug 2001 12:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270631AbRHNQ7k>; Tue, 14 Aug 2001 12:59:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18957 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270627AbRHNQ7b>; Tue, 14 Aug 2001 12:59:31 -0400
Date: Tue, 14 Aug 2001 09:58:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kurt Garloff <garloff@suse.de>
cc: <Andries.Brouwer@cwi.nl>, <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>, <mantel@suse.de>,
        <rubini@vision.unipv.it>
Subject: Re: [PATCH] make psaux reconnect adjustable
In-Reply-To: <20010814170306.Q1085@gum01m.etpnet.phys.tue.nl>
Message-ID: <Pine.LNX.4.33.0108140954390.1679-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, probably not, as it contains a typo which lets machines without kbd
> hang. Fixed version attached. Sorry!

Hmm..

I really have two comments, but I haven't followed the whole discussion,
so feel free to just say that it's been hashed out already:

 - sysconf entries are suspicious for stuff like this. If some code really
   requires this to work correctly, that's exactly the kind of code that
   would run automatically at bootup. A sysconf doesn't really help people
   in that case - we'd be much better off with just a bootup switch.

 - do we actually need the config switch AT ALL, whether at bootup or not?
   What exactly breaks if we just always pass the AA 00 values through?
   Apparently nothing ever breaks, which makes me suspect that people are
   just being unnecessarily defensive.

In short, I'd prefer a patch that just unconditionally removes the code,
unless somebody KNOWS that it could break something. That failing, a
simple kernel command line option sounds better than more files in /proc.

Remember: the biggest mistake to do is to overdesign. The road to hell is
paved with good intentions.

		Linus

