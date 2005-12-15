Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVLOQri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVLOQri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVLOQri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:47:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:15749 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750808AbVLOQrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:47:37 -0500
Date: Thu, 15 Dec 2005 16:47:36 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH 1/3] m68k: compile fix - hardirq checks were in wrong place
Message-ID: <20051215164736.GX27946@ftp.linux.org.uk>
References: <20051215085402.GT27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151252110.1605@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512151252110.1605@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 12:58:12PM +0100, Roman Zippel wrote:
> You separate the definition from the check, now you push the 
> responsibility to get the order right to the header users.

There are two definitions, one in old place, another in new one.  You
need both seen before the check.  On m68k hardirq.h doesn't pull irq.h;
irq.h, OTOH, *does* pull hardirq.h via linux/interrupt.h -> linux/hardirq.h ->
asm/hardirq.h.  IOW, it's less responsibility, not more.

Moreover, new variant works; old one doesn't.  Both are brittle, but the
old one is flat-out _broken_.  As in, new one works with the actual
includes in the tree with no extra changes, old one breaks on a number
of existing files in the tree.

How the hell does that push responsibility to header users?
