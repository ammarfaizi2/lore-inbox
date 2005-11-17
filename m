Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030576AbVKQAZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030576AbVKQAZl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbVKQAZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:25:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4019 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030576AbVKQAZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:25:40 -0500
Date: Wed, 16 Nov 2005 16:25:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: mmap over nfs leads to excessive system load
Message-Id: <20051116162516.61cb1e6b.akpm@osdl.org>
In-Reply-To: <1132185969.8811.106.camel@lade.trondhjem.org>
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
	<1132163057.8811.15.camel@lade.trondhjem.org>
	<20051116100053.44d81ae2.akpm@osdl.org>
	<1132166062.8811.30.camel@lade.trondhjem.org>
	<20051116110938.1bf54339.akpm@osdl.org>
	<1132171500.8811.37.camel@lade.trondhjem.org>
	<20051116133130.625cd19b.akpm@osdl.org>
	<1132177785.8811.57.camel@lade.trondhjem.org>
	<20051116141052.7994ab7d.akpm@osdl.org>
	<1132179796.8811.70.camel@lade.trondhjem.org>
	<20051116144450.47436560.akpm@osdl.org>
	<1132185969.8811.106.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> The accompanying NFS patch makes use of this in order to figure out when
>  to flush the data correctly.

OK.  So with that patch, nfs_writepages() may still leave I/O pending,
uninitiated, yes?

I don't understand why NFS hasn't been BUGging as it stands at present.  It
has several end_page_writeback() calls but no set_page_writeback()s. 
end_page_writeback() or rotate_reclaimable_page() will go BUG if the page
wasn't PageWriteback().
