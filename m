Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTEFGek (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 02:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTEFGej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 02:34:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8677 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262406AbTEFGei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 02:34:38 -0400
Date: Mon, 05 May 2003 22:39:44 -0700 (PDT)
Message-Id: <20030505.223944.23027730.davem@redhat.com>
To: akpm@digeo.com
Cc: rusty@rustcorp.com.au, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030505234248.7cc05f43.akpm@digeo.com>
References: <20030505.211606.28803580.davem@redhat.com>
	<20030505224815.07e5240c.akpm@digeo.com>
	<20030505234248.7cc05f43.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Mon, 5 May 2003 23:42:48 -0700
   
   Can't think of anything very clever there, except to go and un-percpuify the
   disk stats.  I think that's best, really - disk requests only come in at 100
   to 200 per second - atomic_t's or int-plus-per-disk-spinlock will be fine.
   
Use some spinlock we already have to be holding during the
counter bumps.

Frankly, these things don't need to be %100 accurate.  Using
a new spinlock or an atomic_t for this seems rediculious.
