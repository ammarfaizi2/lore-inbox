Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbUEBA2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUEBA2r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 20:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUEBA2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 20:28:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:39627 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262802AbUEBA2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 20:28:43 -0400
Date: Sat, 1 May 2004 17:28:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Andrew Morton <akpm@osdl.org>, bunk@fs.tum.de, eyal@eyal.emu.id.au,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
In-Reply-To: <20040502000046.GA24649@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58.0405011722550.18014@ppc970.osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
 <408F9BD8.8000203@eyal.emu.id.au> <20040501201342.GL2541@fs.tum.de>
 <Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org> <20040501161035.67205a1f.akpm@osdl.org>
 <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org>
 <20040502000046.GA24649@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 May 2004, Chris Wedgwood wrote:
> 
> I'm confused.

We all are, don't worry.

> I thought it has been decreed using kernel headers in userspace was a
> bad idea (DONT DO THAT) so in theory we can just ignore this issue?

Absolutely. But "in theory" is a thing we may want to strive for, but not 
at the expense of "in practice".

Sadly, we used to encourage (yeah, yeah, I should 'fess up: it was me, I'm 
guilty, I was stupid) user-space code to include kernel headers. 
Admittedly, that was about ten years ago, and we've tried to fix it ever 
since, but the thing is, I think backwards compatibility in the end is 
more important than "in theory". And silently breaking things in subtle 
ways would be bad.

What we _could_ do is to move _all_ the "_syscallX()" stuff into the
__KERNEL__ define, which would at least break any potential pre-glibc
users in a very visible way. What I _don't_ want to do is to have somebody
by mistake compile against updated kernel headers, and it still compiles,
but just doesn't work at run-time the way it's supposed to. THAT is
confusing and bad.

In short: either we should make non-kernel users break in _really_ obvious
(and hopefully easy-to-fix) ways, or we should keep things compatible. 
None of the "oh, the return value changed subtly" thing, please ;)

		Linus
