Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268337AbUHXVWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268337AbUHXVWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268332AbUHXVWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:22:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57772 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268337AbUHXVWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:22:34 -0400
Date: Tue, 24 Aug 2004 22:22:32 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, reiser@namesys.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040824212232.GF21964@parcelfarce.linux.theplanet.co.uk>
References: <20040824202521.GA26705@lst.de> <412BA741.4060006@pobox.com> <20040824205343.GE21964@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824205343.GE21964@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 09:53:44PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
 
> Feh.  That's far from the worst parts of the mess introduced by "hybrid"
> crap - trivial sys_link(2) deadlocks triggerable by any user rate a bit
> higher on the suckitude scale, IMO.

While we are at it - consider these hybrids vetoed until
	a) sys_link()/sys_link() deadlock is fixed
	b) sys_link()/sys_rename() deadlock is fixed
	c) correctness proof of the locking scheme (in
Documentation/filesystems/directory-locking) is updated to match the
presense of the file/directory hybrids.

Rationale: (a) and (b) - immediately exploitable by any user, (c) - "convince
us that there's no more crap of that kind".  IMO a reasonable request, seeing
that the first look at the patches in -mm4 had turned up two exploits in
that area, despite the *YEARS* of warnings about potential trouble and need
to be careful there (actually, I've given Hans too much credit and assumed
that link/link never happens since nobody would be dumb enough to provide
->link() method for non-directory inodes; turns out that somebody is dumb
enough and link/link is as exploitable as link/rename).
