Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUGFWpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUGFWpr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 18:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbUGFWpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 18:45:47 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:47962 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S264640AbUGFWpk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 18:45:40 -0400
Date: Tue, 6 Jul 2004 17:45:39 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: John Richard Moser <nigelenki@comcast.net>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: post 2.6.7 BK change breaks Java?
Message-ID: <20040706224539.GA6060@hexapodia.org>
References: <20040705231131.GA5958@merlin.emma.line.org> <40EACB64.2010503@comcast.net> <20040706161451.GA26925@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040706161451.GA26925@merlin.emma.line.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 06:14:51PM +0200, Matthias Andree wrote:
> I've been pointed to the NX feature off-list and investigated, my CPU
> (AMD Athlon XP 2500+ Model 10 "Barton") doesn't support the noexec flag,
> and dmesg does not contain any output that MX was enabled, and the Java
> "Killed" problem persists when the kernel is booted with noexec=off.
> 
> It must have entered the tree between v2.6.7 and revision 1.1757 in
> Linus' tree.

BK revision numbers aren't stable, so "1.1757" doesn't say much.
Instead, quote keys, either :KEY: or :MD5KEY:, like so:
% bk prs -hnd:KEY: -r1.1657 ChangeSet
akpm@osdl.org[torvalds]|ChangeSet|20040323152307|55600
% bk prs -hnd:MD5KEY: -r1.1657 ChangeSet
4060565bRhJji9RfHpiUg8dYxnHR1A

Those identifiers are eternal and unchanging, and can be used almost
anywhere a revision number can be used.  (Note that I used a different
rev, as I don't have 1.1757 in my tree at the moment.)

> BTW, how do I tell BitKeeper "pull up to revision..."?  bk pull and bk
> undo -aREV is a way, but it's wasteful.

bk clone has a -r option, but it just does an undo internally.  You
should definitely have a local mirror of the kernel source and make
temporary clones to work in, then the only things that you're wasting
are compute cycles and disk IO (rather than network bandwidth).

% (cd mirror/linux-2.5; bk pull)
% bk clone -ql -r4060565bRhJji9RfHpiUg8dYxnHR1A mirror/linux-2.5 tmptree

This works better if you have enough RAM to cache the entire BK tree
comfortably (at least 768MB, preferably a gig).

-andy (not speaking for or associated with BitMover)
