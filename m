Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVKMHMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVKMHMf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 02:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVKMHMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 02:12:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15250 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751170AbVKMHMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 02:12:34 -0500
Date: Sat, 12 Nov 2005 23:12:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: pj@sgi.com, nickpiggin@yahoo.com.au, rohit.seth@intel.com,
       torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Cleanup of __alloc_pages
Message-Id: <20051112231211.372be3a9.akpm@osdl.org>
In-Reply-To: <20051112211429.294b3783.pj@sgi.com>
References: <20051107174349.A8018@unix-os.sc.intel.com>
	<20051107175358.62c484a3.akpm@osdl.org>
	<1131416195.20471.31.camel@akash.sc.intel.com>
	<43701FC6.5050104@yahoo.com.au>
	<20051107214420.6d0f6ec4.pj@sgi.com>
	<43703EFB.1010103@yahoo.com.au>
	<1131473876.2400.9.camel@akash.sc.intel.com>
	<43716476.1030306@yahoo.com.au>
	<20051112210913.0b365815.pj@sgi.com>
	<20051112211429.294b3783.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>  fs/xfs/linux-2.6/xfs_buf.c has:
>      aentry = kmalloc(sizeof(a_list_t), GFP_ATOMIC & ~__GFP_HIGH);

That's a reasonable thing to do, actually.

GFP_ATOMIC means "don't sleep" (!__GFP_WAIT) and "use emergency pools"
(__GFP_HIGH).

XFS is saying "don't sleep" and "don't use the emergency pools".

Yes, the fact that GFP_ATOMIC also implies "use the emergency pool" is
unfortunate, and perhaps the two should always have been separated out, at
least to make the programmer think about whether the code really needs
access to the emergency pools.   Usually it does.

But I haven't seen much sign that it's causing any problems.
