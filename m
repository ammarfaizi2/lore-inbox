Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbRAUCSX>; Sat, 20 Jan 2001 21:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129867AbRAUCSN>; Sat, 20 Jan 2001 21:18:13 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:36260 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S129835AbRAUCSC>; Sat, 20 Jan 2001 21:18:02 -0500
Date: Sun, 21 Jan 2001 03:03:19 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.10.10101201612240.10849-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.10.10101210212130.17965-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 20 Jan 2001, Linus Torvalds wrote:

> Now, there are things to look out for: when you do these kinds of dummy
> "struct page" tricks, some macros etc WILL NOT WORK. In particular, we do
> not currently have a good "page_to_bus/phys()" function. That means that
> anybody trying to do DMA to this page is currently screwed, simply because
> he has no good way of getting the physical address.
> 
> This is a limitation in general: the PTE access functions would also like
> to have "page_to_phys()" and "phys_to_page()" functions. It gets even
> worse with IO mappings, where "CPU-physical" is NOT necessarily the same
> as "bus-physical".

That's why I want to avoid dummy struct page and use a real mem_map
instead. I have two options:
1. I map everything together in one mem_map, like it's still done for
m68k, the overhead here is in the phys_to_virt()/virt_to_phys() function.
2. I use several nodes like mips64/arm and virt_to_page() gets more
complex, but this usually assumes a specific memory layout to keep it
fast.
Once that problem is solved, I can manage the memory on the card like the
main memory and use it however I want. I probably do something like ia64
and use the highest bits as an offset into a table.

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
