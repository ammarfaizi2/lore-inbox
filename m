Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbSKEG4P>; Tue, 5 Nov 2002 01:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264771AbSKEG4P>; Tue, 5 Nov 2002 01:56:15 -0500
Received: from air-2.osdl.org ([65.172.181.6]:26752 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264749AbSKEG4P>;
	Tue, 5 Nov 2002 01:56:15 -0500
Date: Mon, 4 Nov 2002 22:58:20 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Christoph Hellwig <hch@infradead.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use seq_file for /proc/swaps
In-Reply-To: <20021030162924.A30082@infradead.org>
Message-ID: <Pine.LNX.4.33L2.0211042228140.19130-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I see you've already done this.  I was about to work on it
tonight (Monday night my time).  Oh well...thanks.


On Wed, 30 Oct 2002, Christoph Hellwig wrote:

| On Tue, Oct 29, 2002 at 10:12:59PM -0800, Randy.Dunlap wrote:
|
| > That meant that I had to duplicate create_seq_entry() or
| > export it.  For now I have duplicated it, and that would make
| > 3 copies of it in the kernel -- and that's bad IMO, so it would
| > need to be exported (but I didn't do that for now).
|
| Not sure whether that three lines of code are really worth exporting :)

Yeah, but I don't like duplicating code either.
More to find (or miss) whenever global changes are needed.

| > And there's the question of __init ordering: when will the __init
| > function mm/swap.c::swap_setup(), calling create_seq_entry(),
| > happen in relation to create_proc_entry() being ready to work?
|
| create_proc_entry() works as soon as kmalloc() works, i.e. it's fine
| for all initcalls.`

I was concerned about the ordering of procswaps_init() and
proc_root_init().  What happens if procswaps_init() is
called before proc_root_init() is called?
Or is there initcall ordering that prevents that?
If so, where is it?

-- 
~Randy


