Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276561AbRI2RWI>; Sat, 29 Sep 2001 13:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276562AbRI2RV6>; Sat, 29 Sep 2001 13:21:58 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:29948 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S276561AbRI2RVs>;
	Sat, 29 Sep 2001 13:21:48 -0400
Message-ID: <3BB601AD.8890EA1D@gmx.de>
Date: Sat, 29 Sep 2001 19:15:25 +0200
From: Bernd Harries <bha@gmx.de>
Reply-To: bha@gmx.de
Organization: BHA Industries
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Bernd Harries <mlbha@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: __get_free_pages(): is the MEM really mine?
In-Reply-To: <Pine.LNX.4.33.0109271454560.5435-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings from the 2001 Linux Devel meeting in Oldenburg!

Roman Zippel looked at my driver and added code to print the usage 
counter for each page after a 9-order __get_free_pages().

We found that only the first (!) page has a count of 1, the others have 0!

That would cover my impression, that only the 1st page is really mine...

Roman found that strange and added this:

          struct page * page = virt_to_page(card_ptr->dma_blk1[n]);
          int i;
          for(i = 0; i < (1 << max_order); i++, page++)
          {
            atomic_set(&page->count, 1);
          }

And the freeing of the pages is now done page by page in the _vma_close()
function.

I will now test the version but I have only a 1-CPU box here. On an SMP Box I
could imagine that even between __get_free_pages() and the
atomic_set(&page->count, 1) someone else already uses my pages.

Could you please comment on this?

Thanks,
-- 
Bernd Harries

bha@gmx.de           http://www.freeyellow.com/members/bharries
bha@nikocity.de       Tel. +49 421 809 7343 priv.  | MSB First!
harries@stn-atlas.de       +49 421 457 3966 offi.  | Linux-m68k
bernd@linux-m68k.org      8.48'21" E  52.48'52" N  | Medusa T40
