Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbVKDOG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbVKDOG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 09:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVKDOG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 09:06:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54952 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751422AbVKDOG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 09:06:56 -0500
Date: Fri, 4 Nov 2005 14:06:55 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andreas Herrmann <aherrman@de.ibm.com>
Subject: Re: [PATCH resubmit] do_mount: reduce stack consumption
Message-ID: <20051104140655.GI7992@ftp.linux.org.uk>
References: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com> <20051104114818.GG7992@ftp.linux.org.uk> <20051104125705.GB12476@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104125705.GB12476@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 01:57:05PM +0100, Heiko Carstens wrote:
> > > This is a resubmit of Andreas' patch that reduces stackframe usage in
> > > do_mount. Problem is that without this patch we get a kernel stack
> > > overflow if we run with 4k stacks (s390 31 bit mode).
> > > See original stack back trace below and Andreas' patch and analysis
> > > here:
> > > http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/1844.html
> > 
> > NAK.  Rationale: too ugly.
> 
> Ok, since I can only guess what you don't like: here is an updated patch
> that probably addresses a few things.
> If you don't like this one too, could you please explain what should be
> changed?

Depth analysis.  E.g. do_move_mount() change is simply nonsense - _this_
is not going to overflow, no matter what.  And do_add_mount() change
is also very suspicious - looks like you are attacking the wrong place
in call chain.
