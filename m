Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031549AbWLEVYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031549AbWLEVYK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031567AbWLEVYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:24:10 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:56211
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1031549AbWLEVYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:24:08 -0500
Date: Tue, 05 Dec 2006 13:24:12 -0800 (PST)
Message-Id: <20061205.132412.116353924.davem@davemloft.net>
To: mattjreimer@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: D-cache aliasing issue in cow_user_page
From: David Miller <davem@davemloft.net>
In-Reply-To: <f383264b0612042338y2609dd76w8ba562394800bbd0@mail.gmail.com>
References: <f383264b0612042338y2609dd76w8ba562394800bbd0@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matt Reimer" <mattjreimer@gmail.com>
Date: Mon, 4 Dec 2006 23:38:13 -0800

> In light of James Bottomsley's commit[1] declaring that kmap() and
> friends now have to take care of coherency issues, is the patch "mm:
> D-cache aliasing issue in cow_user_page"[2] correct, or could it
> potentially cause a slowdown by calling flush_dcache_page() a second
> time (i.e. once in an architecture-specific kmap() implementation, and
> once in cow_user_page())?

kmap() is a NOP unless HIGHMEM is configured.

Therefore, it cannot possibly take care of D-cache aliasing issues
across the board.
