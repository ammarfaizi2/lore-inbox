Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263183AbUDZW4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbUDZW4W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 18:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263307AbUDZW4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 18:56:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:690 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263183AbUDZW4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 18:56:21 -0400
Date: Mon, 26 Apr 2004 23:56:20 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       raven@themaw.net
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?)
Message-ID: <20040426225620.GP17014@parcelfarce.linux.theplanet.co.uk>
References: <20040426013944.49a105a8.akpm@osdl.org> <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net> <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net> <Pine.LNX.4.58.0404261102280.19703@ppc970.osdl.org> <Pine.LNX.4.58.0404262350450.3003@alpha.polcom.net> <Pine.LNX.4.58.0404261510230.19703@ppc970.osdl.org> <Pine.LNX.4.58.0404270034110.4469@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404270034110.4469@alpha.polcom.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 12:38:53AM +0200, Grzegorz Kulewski wrote:
> On Mon, 26 Apr 2004, Linus Torvalds wrote:
> > Try turning off MD first. Then quota, and if neither of those matters, 
> > start tuning off the individual filesystem drivers (reiser, xfs).
> 
> Yes, when I turned off MD and DM it started to work. Thanks. Can I help 
> more to track the problem down? (I currently have no MD or DM volumes in 
> my system - I just wanted to start experimenting with them...)

Add
	printk("claim: %d:%d %p -> %d\n",
		MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev), holder, res);
in the very end of fs/block_dev.c::bd_claim() (just before return) and
	printk("release: %d:%d\n", 
		MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
in bd_release() (same file).
