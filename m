Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTLMAMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 19:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbTLMAMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 19:12:13 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:64519 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261552AbTLMAML
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 19:12:11 -0500
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
References: <3FCDE5CA.2543.3E4EE6AA@localhost>
	<Pine.LNX.4.58.0312031533530.2055@home.osdl.org>
	<Pine.LNX.4.58.0312031614000.2055@home.osdl.org>
	<20031204192452.GC10421@parcelfarce.linux.theplanet.co.uk>
From: Nix <nix@esperi.org.uk>
X-Emacs: (setq software-quality (/ 1 number-of-authors))
Date: Sat, 13 Dec 2003 00:11:58 +0000
In-Reply-To: <20031204192452.GC10421@parcelfarce.linux.theplanet.co.uk> (viro@parcelfarce.linux.theplanet.co.uk's
 message of "Thu, 4 Dec 2003 19:27:04 +0000 (UTC)")
Message-ID: <877k11y3sh.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[catching up with vast backlog]

On Thu, 4 Dec 2003, viro@parcelfarce.linux.theplanet.co.uk mused:
> 	FWIW, it would be very nice if somebody did hard and messy work and
> produced lists of in-tree modules using given symbols.  Ideally - automated
> that, but that won't be easy to do (quite a few are used only via inlined
> wrappers and in some cases - under an ifdef; many arch-specific exports
> are of that sort).

ISTM that this could be done quite easily with a hacked-up libcpp that
does token pasting and #include processing, but does *not* process #if
statements themselves.

Preprocess every translation unit in the kernel with that, and grep each
of them for every exported symbol in turn, and bingo. :)

I'll have a hack sometime this weekend if nobody else gets around to it.

(Of course, this will say that stuff in #if 0's and other #ifdef
branches that can't be reached is in fact used, but such code isn't
common.)

> 	Some approximation might be obtained by building all modules and
> doing nm on them, with manual work for non-obvious cases.

Hang on, surely you can tell which symbols in modules are exported just
by looking for expansions of EXPORT_SYMBOL{_GPL}? Why is this bit hard?

I think the problem is you're trying to compile rather than doing a
hacked -E :) we don't need to compile for this, just do most of the
preprocessing phase.

-- 
`...some suburbanite DSL customer who thinks kernel patches are some
 form of military insignia.' --- Bob Apthorpe
