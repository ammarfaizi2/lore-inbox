Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262894AbVDHSGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbVDHSGO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbVDHSGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:06:14 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:26582 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262894AbVDHSF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:05:57 -0400
Date: Fri, 8 Apr 2005 11:05:40 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050408180540.GA4522@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org> <20050408171518.GA4201@taniwha.stupidest.org> <Pine.LNX.4.58.0504081037310.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504081037310.28951@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 10:46:40AM -0700, Linus Torvalds wrote:

> I can indeed stat the entire tree in that time (assuming it's in memory,
> of course, but my kernel trees are _always_ in memory ;), but in order to
> do so, I have to be good at finding the names to stat.

<pause ... tapity tap>

I just tested this (I wanted to be sure you didn't have some 47GHz
LiHe cooled Xeon or something).

On my somewhat slowish machine[1] (by today's standards anyhow) I can
stat a checked out tree (ie. the source files and not SCM files) in
about 0.10s it seems and 0.26s for an entire tree with BK files in it.

> In particular, you have to be extremely careful. You need to make
> sure that you don't stat anything you don't need to.

Actually, I could probably make this *much* still faster with a
caveat.  Given that my editor when I write a file will write a
temporary file and rename it, for files in directories where nlink==2
I can check chat first and skip the stat of the individual files.

And I guess if I was bored I could have my editor or some daemon
sitting in the background intelligently using dnotify to have this
information on-hand more or less instantly.  For this purpose though
that seems like a lot of effort for no real gain right now.

> Anybody who can't list the files they work on _instantly_ is doing
> something damn wrong.

Well, I do like to do "bk sfiles -x" fairly often.  But then again I
can stat dirs and compare against a cache to make that fast too.


[1] Dual AthlonMP 2200
