Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbSJ2Cay>; Mon, 28 Oct 2002 21:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbSJ2Cay>; Mon, 28 Oct 2002 21:30:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24239 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261504AbSJ2Caw>;
	Mon, 28 Oct 2002 21:30:52 -0500
Date: Mon, 28 Oct 2002 18:27:57 -0800 (PST)
Message-Id: <20021028.182757.77947646.davem@redhat.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [patch][cft] zero-copy dma cd writing and ripping
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021028161857.GK2937@suse.de>
References: <20021028155401.GI2937@suse.de>
	<1035822310.8970.9.camel@rth.ninka.net>
	<20021028161857.GK2937@suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Mon, 28 Oct 2002 17:18:57 +0100
   
   A related question. get_user_pages() does page_cache_get() on the page,
   except if it's reserved. First question is 'why' doesn't it do that on a
   reserved page? We get this conditional when mapping, and the unmapping
   needs to check for reserved as well before doing page_cache_release().
   Surely the extra reference would be ok to hold for PageReserved pages
   as well?

The basic behavior of the whole MM for reserved pages is supposed
to be to not do any kind of reference counting, COW'ing, etc. on
them.

Any deviation from this behavior is going to lead to problems and
can be considered a bug until some later time at which we decide
to change this behavior.

Look at how copy_page_range() deals with reserved pages, for
example.  This logic is all over the VM.
