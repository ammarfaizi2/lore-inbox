Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbVCDOki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbVCDOki (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 09:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVCDOhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 09:37:25 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:9883 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262405AbVCDOeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 09:34:01 -0500
Date: Fri, 4 Mar 2005 14:54:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Message-ID: <20050304135429.GC3485@openzaurus.ucw.cz>
References: <422428EC.3090905@jp.fujitsu.com> <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org> <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk> <200503010910.29460.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503010910.29460.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If there's no ->error method, at leat call ->remove so one device only
> > takes itself down.
> >
> > Does this make sense?
> 
> This was my thought too last time we had this discussion.  A completely 
> asynchronous call is probably needed in addition to Hidetoshi's proposed API, 
> since as you point out, the driver may not be running when an error occurs 
> (e.g. in the case of a DMA error or more general bus problem).  The async

Hmm, before we go async way (nasty locking, no?) could driver simply
ask "did something bad happen while I was sleeping?" at begining of each
function?

For DMA problems, driver probably has its own, timer-based,
"something is wrong" timer, anyway, no?
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

