Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUBKL6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 06:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbUBKL6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 06:58:47 -0500
Received: from ns.suse.de ([195.135.220.2]:5071 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264291AbUBKL6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 06:58:44 -0500
Date: Sat, 14 Feb 2004 09:34:42 +0100
From: Andi Kleen <ak@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
Message-Id: <20040214093442.10146829.ak@suse.de>
In-Reply-To: <1076451422.866.55.camel@gaston>
References: <1076384799.893.5.camel@gaston>
	<Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
	<1076451422.866.55.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Feb 2004 09:17:02 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:


> 
> It's not bash, it's ld.so... Note that Andi's patch also fix a potential
> similar issue with the free_area_cache, if somebody does a MAP_FIXED to
> low addresses, then a un-hinted mmap, then that mmap will have chances
> to be put straight after brk, causing the same kind of interesting issues.

Actually, MAP_FIXED is already handled in the caller. It can only happen
for hints without MAP_FIXED.
 
> So if you don't take Andi's latest patch, maybe you should still take
> the part that avoid playing with free_area_cache on MAP_FIXED mappings ?

Reverting everything should have the same effect (it was really a bug I added) 
Doing that would be fine for me, that change was not critical, just nice to 
have.

-Andi
