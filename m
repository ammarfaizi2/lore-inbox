Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVJCPfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVJCPfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVJCPfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:35:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:13757 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932301AbVJCPfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:35:18 -0400
Date: Mon, 3 Oct 2005 16:35:15 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Nix <nix@esperi.org.uk>
Cc: jonathan@jonmasters.org, Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Why no XML in the Kernel?
Message-ID: <20051003153515.GW7992@ftp.linux.org.uk>
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com> <35fb2e590510021153r254b7eb0haf9f9e365bed051e@mail.gmail.com> <87oe66r62s.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87oe66r62s.fsf@amaterasu.srvr.nix>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 04:08:43PM +0100, Nix wrote:
> Considerations of ugliness and difficulty of implementing the equivalent
> of writes to procs files did not shift the twit: but starting top on a
> busy system and showing said twit the CPU load spikes as /proc/[0-9]*
> got iterated over, and asking `how severe would this be if *all* of
> /proc and /sys had to be generated for every single request?' seems to
> have imparted enough clue.

Another fun consideration in that area is that XML (or s-exp, or trees,
whatever representation you prefer) has nothing to help with dynamic data
structures.  Exporting snapshots does not work since the real state
includes the information about locks being held - without that you
can't tell which invariants hold at the moment, since the real ones
include lock state.  And forcing all locks involved into known state
is nowhere near feasible, of course.  OTOH, exporting dynamic state
including locks and walking the damn thing is
	a) not feasible with XML
	b) would require giving userland way too much access to locking,
creating a nightmare wrt deadlock potential.
