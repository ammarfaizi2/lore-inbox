Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbSKVVI6>; Fri, 22 Nov 2002 16:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbSKVVI6>; Fri, 22 Nov 2002 16:08:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58787 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264724AbSKVVI5>;
	Fri, 22 Nov 2002 16:08:57 -0500
Date: Fri, 22 Nov 2002 13:12:59 -0800 (PST)
Message-Id: <20021122.131259.66318468.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: akpm@digeo.com
Subject: Re: [BK-2.5] [PATCH] bootmem crash fix
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200211222005.gAMK5t319194@hera.kernel.org>
References: <200211222005.gAMK5t319194@hera.kernel.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
   Date: Fri, 22 Nov 2002 19:31:53 +0000

   	From Roman Zippel.  Don't assume that physical memory starts at
   	physical address zero.
   
 Which would be a nice improvement, however:

   -	free_area_init_node(0, &contig_page_data, NULL, zones_size, 0, NULL);
   +	free_area_init_node(0, &contig_page_data, NULL, zones_size,
   +			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);

__pa(PAGE_OFFSET) is not necessarily the first physical address in
the system either.

I've never seen this even implied to be the case :-)
In any event, it isn't well defined and we should make it
so.
