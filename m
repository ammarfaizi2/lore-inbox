Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbTL0J2r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 04:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265240AbTL0J2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 04:28:47 -0500
Received: from rth.ninka.net ([216.101.162.244]:23168 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S265212AbTL0J2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 04:28:45 -0500
Date: Sat, 27 Dec 2003 01:28:32 -0800
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: andrea@suse.de, ncw1@axis.demon.co.uk, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, rohit.seth@intel.com
Subject: Re: 2.6.0 Huge pages not working as expected
Message-Id: <20031227012832.27190a34.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0312261956510.14874@home.osdl.org>
References: <20031226105433.GA25970@axis.demon.co.uk>
	<20031226115647.GH27687@holomorphy.com>
	<20031226201011.GA32316@axis.demon.co.uk>
	<Pine.LNX.4.58.0312261226560.14874@home.osdl.org>
	<20031227033620.GG1676@dualathlon.random>
	<Pine.LNX.4.58.0312261956510.14874@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Dec 2003 20:01:57 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> I can understand a one-way L1, simply to keep the cycle time low, but 
> what's the point of a one-way L2? Braindead external cache controller?

Most sparc64's are the same, as are the ancient sparc32 chips.

Most R4000/R5000 mips chips are like this as well.

It's stupid, but unfortunately pervasive. :)

> Does it keep fragmentation down?
> 
> That's the problem that Davem had in one of his cache-coloring patches: it
> worked well enough if you had lots of memory, but it _totally_ broke down
> when memory was low. You couldn't allocate higher-order pages at all after
> a while because of the fragmented memory.

That's right, but it could also have been because my approach to
the implementation sucked.

For example, if you just keep breaking apart order 1 or greater chunks
to give particular colors out, and later some of them get freed and some
of them don't, you get less and less buddy coalescing over time.

One idea to combat this is to make page liberation (ie. vmscan and friends)
smarter about this when swapping, kicking out page cache pages, or whatever.
Ie. see which freed pages have buddies we can liberate.  I never experimented
with any ideas like that.
