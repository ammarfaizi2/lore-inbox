Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265243AbSLQRmO>; Tue, 17 Dec 2002 12:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbSLQRmO>; Tue, 17 Dec 2002 12:42:14 -0500
Received: from holomorphy.com ([66.224.33.161]:40632 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265243AbSLQRmN>;
	Tue, 17 Dec 2002 12:42:13 -0500
Date: Tue, 17 Dec 2002 09:49:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.52-mm1 DCU_MISS_OUTSTANDING + IFU_FETCH_MISS
Message-ID: <20021217174945.GD1922@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20021217064948.GS2690@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021217064948.GS2690@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 10:49:48PM -0800, William Lee Irwin III wrote:
> IFU_IFETCH_MISS:
> c013233c 13       1.62703     find_get_page
> c0116b00 14       1.75219     pfn_to_nid
> c0119c14 14       1.75219     kmap_atomic
> c013e7e0 15       1.87735     pte_try_to_share
> c01463f0 19       2.37797     page_add_rmap
> c01412d0 20       2.50313     do_anonymous_page
> c0141aa0 22       2.75344     handle_mm_fault
> c01416f0 24       3.00375     do_no_page
> c015c904 25       3.12891     link_path_walk
> c0117350 27       3.37922     do_page_fault

Inlining pfn_to_nid() yields:

c013e420 9        1.53846     pte_try_to_share
c0132e6c 10       1.7094      filemap_nopage
c0145850 10       1.7094      page_add_rmap
c0133658 13       2.22222     generic_file_aio_write_nolock
c01352d8 14       2.39316     buffered_rmqueue
c0140e40 17       2.90598     do_no_page
c0140b50 18       3.07692     do_anonymous_page
c01411bc 18       3.07692     handle_mm_fault
c011a820 19       3.24786     scheduler_tick
c01172d0 21       3.58974     do_page_fault

Looks good to me. No obvious difference in compile time, though.

Bill
