Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317536AbSGJQbj>; Wed, 10 Jul 2002 12:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317537AbSGJQbi>; Wed, 10 Jul 2002 12:31:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63755 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317536AbSGJQbg>;
	Wed, 10 Jul 2002 12:31:36 -0400
Message-ID: <3D2C63A1.D5721E18@zip.com.au>
Date: Wed, 10 Jul 2002 09:41:05 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.25ide24 BUG() in page_alloc.c::prep_new_page()
References: <Pine.SOL.3.96.1020710161557.22195A-100000@libra.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> Hi,
> 
> Just got the below oops while running 2.5.25ide24 (using ext3). The BUG()
> triggered is the BUG_ON(PageDirty(page)); in
> mm/page_alloc.c::prep_new_page().
> 
> Seems like a dirty page was leaked somehow...
> 

But __free_pages_ok() clears the dirty bit.

It'd be interesting to add a BUG_ON(page_count(page) == 0) to
SetPageDirty(), please.
