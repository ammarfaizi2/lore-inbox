Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbSJ3QXC>; Wed, 30 Oct 2002 11:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbSJ3QXC>; Wed, 30 Oct 2002 11:23:02 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:53778 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264729AbSJ3QXB>; Wed, 30 Oct 2002 11:23:01 -0500
Date: Wed, 30 Oct 2002 16:29:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use seq_file for /proc/swaps
Message-ID: <20021030162924.A30082@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <20021029121319.A19590@infradead.org> <Pine.LNX.4.33L2.0210292145270.16850-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L2.0210292145270.16850-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Tue, Oct 29, 2002 at 10:12:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 10:12:59PM -0800, Randy.Dunlap wrote:
> Are you and/or Greg U. going to do a CONFIG_SWAP option?

Yes. It's already in -ac.

> I moved the proc_swaps_operations to swapfile.c like you asked.
> I like that part of this patch.
> But it makes more sense to me to move the create_seq_entry() call
> to mm/swap.c:: in its __init swap_setup() function
> (or add another __init function in swapfile.c to do this ?).

Despite it's name swap.c has absolutely nothing to do with
swapping :)  So please add another initfunc to swapfile.c.

> That meant that I had to duplicate create_seq_entry() or
> export it.  For now I have duplicated it, and that would make
> 3 copies of it in the kernel -- and that's bad IMO, so it would
> need to be exported (but I didn't do that for now).

Not sure whether that three lines of code are really worth exporting :)

> And there's the question of __init ordering: when will the __init
> function mm/swap.c::swap_setup(), calling create_seq_entry(),
> happen in relation to create_proc_entry() being ready to work?

create_proc_entry() works as soon as kmalloc() works, i.e. it's fine
for all initcalls.`

