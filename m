Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275017AbTHLC4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 22:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275019AbTHLC4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 22:56:14 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:37394 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S275017AbTHLC4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 22:56:13 -0400
Date: Tue, 12 Aug 2003 04:56:10 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2 of 2 - Allow O_EXCL on a block device to claim exclusive use.
Message-ID: <20030812045610.B1650@pclin040.win.tue.nl>
References: <E19m2XN-0002BU-00@notabene> <20030811082231.A20077@infradead.org> <16184.18284.969212.342794@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16184.18284.969212.342794@gargle.gargle.HOWL>; from neilb@cse.unsw.edu.au on Tue, Aug 12, 2003 at 11:48:28AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 11:48:28AM +1000, Neil Brown wrote:

> My first attempt at this did claim before openning.
> However that didn't work.
> Some aspects of the bdev that are needed for claiming are not
> initialised before it is first opened.  In particular, bd_contains,
> gets set up by do_open.

Size and structure of partitions are entirely independent of whether
someone has opened them. Thus, the corresponding bookkeeping must
not be in struct block_device, which exists only when the device
is open, but in struct gendisk or so (and only there).

It is a design mistake to have such stuff in struct block device.

