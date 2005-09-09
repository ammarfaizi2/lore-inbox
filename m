Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbVIIQgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbVIIQgp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbVIIQgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:36:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:6345 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750831AbVIIQgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:36:44 -0400
Date: Fri, 9 Sep 2005 17:36:43 +0100
From: viro@ZenIV.linux.org.uk
To: Andreas Schwab <schwab@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bogus cast in bio.c
Message-ID: <20050909163643.GO9623@ZenIV.linux.org.uk>
References: <20050909155356.GF9623@ZenIV.linux.org.uk> <je4q8u1agp.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <je4q8u1agp.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 06:18:14PM +0200, Andreas Schwab wrote:
> viro@ZenIV.linux.org.uk writes:
> 
> > <qualifier> void * is not the same as void <qualifier> *...
> 
> IMHO it should.

... and indeed it should.  My apologies - that's a combination of
sparse bug and me being very low on coffee...

FWIW, looks like we are losing address_space in the first form: with current
sparse we get
fs/bio.c:686:15: warning: incorrect type in assignment (different address spaces)
fs/bio.c:686:15:    expected void [noderef] *iov_base<asn:1>
fs/bio.c:686:15:    got void [noderef] *<noident>
from the first form (cast to __user void *).  Lovely...

OK, I think I know what's going on there, will fix.
