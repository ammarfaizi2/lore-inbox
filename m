Return-Path: <linux-kernel-owner+w=401wt.eu-S1755190AbWL3S1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190AbWL3S1I (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 13:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755191AbWL3S1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 13:27:08 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47695 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755190AbWL3S1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 13:27:05 -0500
Date: Sat, 30 Dec 2006 10:26:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
In-Reply-To: <20061230165012.GB12622@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612301022200.4473@woody.osdl.org>
References: <20061221152621.GB3958@flint.arm.linux.org.uk>
 <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu> <20061221171739.GE3958@flint.arm.linux.org.uk>
 <20061230163955.GA12622@flint.arm.linux.org.uk> <20061230165012.GB12622@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Dec 2006, Russell King wrote:
> 
> And here's the flush_anon_page() part.
> 
> Add flush_anon_page() for ARM, to avoid data corruption issues when using
> fuse or other subsystems using get_user_pages().

Btw, since this doesn't actually change any code for anybody but ARM, just 
adds a parameter that is obviously unused by everybody else, and if it 
actually fixes a real bug for ARM, I'll obviously happily take it even 
before 2.6.20. So go ahead put it in your ARM tree, and we'll get some 
testing through that. And just ask me to pull at some point.

I wonder why nobody else seems to have a "flush_anon_page()"? This would 
seem to be a potential issue for architectures like sparc too.. Although 
maybe sparc can do a flush by physical index with "flush_dcache_page()".

		Linus
