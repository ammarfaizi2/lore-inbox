Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbUBVC6d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 21:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbUBVC6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 21:58:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:38617 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261657AbUBVC6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 21:58:30 -0500
Date: Sat, 21 Feb 2004 19:03:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
In-Reply-To: <20040222023638.GA13840@dingdong.cryptoapps.com>
Message-ID: <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org>
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Feb 2004, Chris Wedgwood wrote:
> 
> Forcing paging will push this down to acceptable levels but it's a
> really irritating solution --- I'm still trying to think of a better
> way to stop the dentries from using such a disproportionate amount of
> memory.

Why?

It's quite likely that especially on a fairly idle machine, the dentry 
cache really _should_ be the biggest single memory user.

Why? Because an idle machine tends to largely be dominated by things like 
"updatedb" and friends running. If there isn't any other real activity, 
there's no reason for a big page cache, nor is there anything that would 
put memory pressure on the dentries, so they grow as much as they can.

Do you see any actual bad behaviour from this?

		Linus
