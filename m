Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263635AbUD0BHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263635AbUD0BHv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 21:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUD0BHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 21:07:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25017 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263635AbUD0BHu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 21:07:50 -0400
Date: Tue, 27 Apr 2004 02:07:48 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Grzegorz Kulewski <kangur@polcom.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       raven@themaw.net
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?
Message-ID: <20040427010748.GY17014@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net> <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net> <Pine.LNX.4.58.0404261102280.19703@ppc970.osdl.org> <Pine.LNX.4.58.0404262350450.3003@alpha.polcom.net> <Pine.LNX.4.58.0404261510230.19703@ppc970.osdl.org> <Pine.LNX.4.58.0404270034110.4469@alpha.polcom.net> <20040426225620.GP17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404270157160.6900@alpha.polcom.net> <20040427002323.GW17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404261758230.19703@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404261758230.19703@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 06:00:12PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 27 Apr 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > > Apr 27 01:49:23 polb01 claim: 3:0 e08e223e -> 0
> > 
> > whee... 6 claims of hda - all by the same owner.
> 
> Would it make sense to add a "dump_stack()" and to print out the name of 
> the binary that causes this too? Ie add something like
> 
> 	printk("dumping stack for %s:\n", current->comm);
> 	dump_stack();
> 
> to the bd_claim() debugging thing...
> 
> It will fill the logs, but I don't think it happens often enough to be a 
> bother...

I'd put it in drivers/md/dm-table.c::open_dev() - it's practically certain
candidate for that crap (note the subsequent failing claims of hdd - they
are definitely from dm code).
