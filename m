Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264926AbUFLVWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264926AbUFLVWa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 17:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbUFLVWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 17:22:30 -0400
Received: from sziami.cs.bme.hu ([152.66.242.225]:50362 "EHLO sziami.cs.bme.hu")
	by vger.kernel.org with ESMTP id S264926AbUFLVW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 17:22:28 -0400
Date: Sat, 12 Jun 2004 23:22:15 +0200 (CEST)
From: Koblinger Egmont <egmont@uhulinux.hu>
X-X-Sender: egmont@sziami.cs.bme.hu
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: information leak in vga console scrollback buffer
In-Reply-To: <20040612205903.GA22428@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58L0.0406122301250.25004@sziami.cs.bme.hu>
References: <Pine.LNX.4.58L0.0406122137480.20424@sziami.cs.bme.hu>
 <20040612204352.GA22347@taniwha.stupidest.org> <Pine.LNX.4.58L0.0406122253580.25004@sziami.cs.bme.hu>
 <20040612205903.GA22428@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2004, Chris Wedgwood wrote:

> > Rationale? (At least an rtfm-like pointer to that?)
>
> Maybe I didn't full understand you.  Generally I find it desirable to
> be able to read things that scrolled off the screen a long time ago.
> It's very useful for unattended machines if I need to 'look' back.

Generally console's scrollback buffer disappears as soon as you switch to
another console.

It'd be a really nice idea if all the consoles had a configurable amount
of scrollback buffer which is always remembered. IMHO with todays machines
having a scrollback buffer of 1000 lines for 6 or a little bit more
consoles (at most 63 IIRC) is affordable as well as the processor time
needed to copy the data from/to vga/normal memory on each console switch
and at every Nth Shift+PageUp (no matter what N is). But this is a whole
different story.

What I'm talking about is: normally after people switch away from a
console they assume that the scrollback buffer is no longer available
since this is the behavior they experience normally. E.g. Z does a 'cat
my-long-private-file' and then logs out. Then even if getty clears the
screen, one can press Shift+PageUp to go back and read parts of this file.
Z is about to leave the computer but don't want others to be able to
scroll back with Shift+PageUp. So switches console (Alt+Fx) and the
scrollback buffer is gone. He is happy. But shouldn't be.

With the trick I described it is possible to bring back some random parts
of previous texts, often some garbage with stupid flashing characters, but
maybe parts of Z's my-long-private-file. The behavior seems to be random
to me, uncontrollable by the user (I see no way to force private data to
be cleared from the vga buffer) and clearly not intentional.

Please try what I wrote, I'm sure that you misunderstood me (I'm trying to
write as clear as I can but I'm not native English speaker and not even
good in English, so it might be that my bugreport is a little bit hard to
understand). I'm sure not talking about a feature, nor am I a Linux newbie
who has just seen Shift+PageUp a few days ago for the first time (even
though I'm very far from being a kernel hacker ;-))



-- 
Egmont
