Return-Path: <linux-kernel-owner+w=401wt.eu-S933108AbWLaJzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933108AbWLaJzq (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 04:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933110AbWLaJzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 04:55:46 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3770 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933108AbWLaJzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 04:55:46 -0500
Date: Sun, 31 Dec 2006 09:55:35 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Miller <davem@davemloft.net>, torvalds@osdl.org, miklos@szeredi.hu,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20061231095535.GB1702@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	David Miller <davem@davemloft.net>, torvalds@osdl.org,
	miklos@szeredi.hu, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, akpm@osdl.org
References: <20061230165012.GB12622@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612301022200.4473@woody.osdl.org> <20061230224604.GA3350@flint.arm.linux.org.uk> <20061230.212338.92583434.davem@davemloft.net> <20061231092318.GA1702@flint.arm.linux.org.uk> <1167557242.20929.647.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167557242.20929.647.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 10:27:22AM +0100, Arjan van de Ven wrote:
> 
> > 
> > However, it's not only FUSE which is suffering - direct-IO also doesn't
> > work. 
> 
> for direct-IO the kernel won't touch the data *at all*... (that's the
> point ;) 

Wrong.  One word: PIO.  We _still_ to this day have no guarantee by
block device drivers that the data they've read into the page cache
will be flushed into RAM rather than sitting in the CPU cache.

> is it still an issue then?

http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2006-November/036906.html

Depends if you think about that patch I guess.  If you're an embedded
person trying to get direct-IO working on ARM I guess that patch is
very attractive, even if it is distasteful to us.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
