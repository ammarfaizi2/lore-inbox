Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316372AbSFDEsQ>; Tue, 4 Jun 2002 00:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSFDEsP>; Tue, 4 Jun 2002 00:48:15 -0400
Received: from holomorphy.com ([66.224.33.161]:42115 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316372AbSFDEsO>;
	Tue, 4 Jun 2002 00:48:14 -0400
Date: Mon, 3 Jun 2002 21:48:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: linux-2.5.20-ct1
Message-ID: <20020604044808.GF8263@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Thunder from the hill <thunder@ngforever.de>,
	Lightweight patch manager <patch@luckynet.dynu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
In-Reply-To: <20020604043724.GB8263@holomorphy.com> <Pine.LNX.4.44.0206032239500.3833-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, William Lee Irwin III wrote:
>> Please discard the atomic update patch altogether; there were enough
>> eyebrows raised that this cannot qualify as a simple cleanup.

On Mon, Jun 03, 2002 at 10:41:15PM -0600, Thunder from the hill wrote:
> Is there something serious to add about them? Is it sure that they won't 
> work or such? Otherwise I'd suggest just getting them tested.

The original patch as posted is incorrect due to a misreading on my
part of what the flags clearing did. One of the few remotely close
to correct alternatives follows, but I will not endorse it as a
candidate for inclusion, but give it only as an illustration of how
incorrect the originally posted patch was.


Cheers,
Bill


===== mm/page_alloc.c 1.63 vs edited =====
--- 1.63/mm/page_alloc.c	Tue May 28 16:57:49 2002
+++ edited/mm/page_alloc.c	Mon Jun  3 16:27:41 2002
@@ -111,7 +111,7 @@
 	if (PageWriteback(page))
 		BUG();
 	ClearPageDirty(page);
-	page->flags &= ~(1<<PG_referenced);
+	__clear_bit(PG_referenced, &page->flags);
 
 	if (current->flags & PF_FREE_PAGES)
 		goto local_freelist;
