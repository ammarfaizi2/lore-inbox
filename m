Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280460AbRKJFJi>; Sat, 10 Nov 2001 00:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280479AbRKJFJ1>; Sat, 10 Nov 2001 00:09:27 -0500
Received: from ns.suse.de ([213.95.15.193]:29715 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280460AbRKJFJK>;
	Sat, 10 Nov 2001 00:09:10 -0500
Date: Sat, 10 Nov 2001 06:09:09 +0100
From: Andi Kleen <ak@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
Message-ID: <20011110060909.A1015@wotan.suse.de>
In-Reply-To: <p731yj8kgvw.fsf@amdsim2.suse.de> <20011109110532.B6822@krispykreme> <20011109064540.A13498@wotan.suse.de> <20011108.220444.95062095.davem@redhat.com> <20011109073946.A19373@wotan.suse.de> <20011110155603.B767@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011110155603.B767@krispykreme>; from anton@samba.org on Sat, Nov 10, 2001 at 03:56:03PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can see the average depth of the get_free_page hash is way too deep.
> I agree there are a lot of pagecache pages (17GB in the gfp test and 21GB
> in the vmalloc test), but we have to make use of the 32GB of RAM :)

Thanks for the information. I guess the fix for your case would be then
to use the bootmem allocator for allocating the page table hash.
It should have no problems with very large continuous tables, assuming
you have the (physically continuous) memory.

Another possibility would be to switch to some tree/skiplist, but that's 
probably too radical and may have other problems on smaller boxes.

-Andi
