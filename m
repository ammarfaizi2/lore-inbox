Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267539AbUBSUGQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267532AbUBSUGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:06:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49301 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267539AbUBSUF7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:05:59 -0500
Date: Thu, 19 Feb 2004 20:05:54 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tridge <tridge@samba.org>, Jamie Lokier <jamie@shareable.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
Message-ID: <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk>
References: <16435.60448.70856.791580@samba.org> <Pine.LNX.4.58.0402181457470.18038@home.osdl.org> <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 11:48:50AM -0800, Linus Torvalds wrote:
> The VFS rule is:
>  - all new dentries start off with the two magic bits clear
>  - whenever we shrink a dentry, we clear the two magic bits in the parent
> 
> and that is _all_ the VFS layer ever does. Even Al won't find this 
> obnoxious (yeah, we might clear the bits after a timeout on things that 
> need re-validation, but that's in the noise).
 
> Notice what the above does? After the above loop, bit two will be set IFF 
> the dentry cache now contains every single name in the directory. 
> Otherwise it will be clear. Bit two will basically be a "dcache complete" 
> bit.

What about dentry getting dropped in the middle of that loop _and_
another task setting the first bit again before the loop ends?
