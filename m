Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVDCXGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVDCXGD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 19:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVDCXGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 19:06:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52358 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261949AbVDCXFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 19:05:54 -0400
Date: Mon, 4 Apr 2005 00:05:51 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Dag Arne Osvik <da@osvik.no>
Cc: Andreas Schwab <schwab@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Use of C99 int types
Message-ID: <20050403230551.GX8859@parcelfarce.linux.theplanet.co.uk>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no> <jezmwgxa5v.fsf@sykes.suse.de> <425072A4.7080804@osvik.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425072A4.7080804@osvik.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 12:48:04AM +0200, Dag Arne Osvik wrote:
> unsigned long happens to coincide with uint_fast32_t for x86 and x86-64, 
> but there's no guarantee that it will on other architectures.  And, at 
> least in theory, long may even provide less than 32 bits.

To port on such platform we'd have to do a lot of rewriting - so much that
the impact of this issue will be lost in noise.

Look, it's very simple:
	* too many people blindly assume that all world is 32bit l-e.
	* too many of those who try to do portable code have very little
idea of what that means - see the drivers that try and mix e.g. size_t with
int, etc.
	* stdint is not widely understood, to put it mildly.
	* ...fast... types have very unfortunate names - these are guaranteed
to create a lot of confusion.
	* pretty much everything in the kernel assumes that
4 = sizeof(int) <=
sizeof(long) = sizeof(pointer) = sizeof(size_t) = sizeof(ptrdiff_t) <=
sizeof(long long) = 8
and any platform that doesn't satisfy the above will require very serious
work on porting anyway.
