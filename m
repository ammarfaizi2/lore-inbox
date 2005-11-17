Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030582AbVKQA2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030582AbVKQA2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030583AbVKQA2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:28:21 -0500
Received: from pat.uio.no ([129.240.130.16]:29875 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030582AbVKQA2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:28:20 -0500
Subject: Re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051116162516.61cb1e6b.akpm@osdl.org>
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
	 <20051116162516.61cb1e6b.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 19:28:00 -0500
Message-Id: <1132187281.11869.1.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.953, required 12,
	autolearn=disabled, AWL 1.05, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 16:25 -0800, Andrew Morton wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >
> > The accompanying NFS patch makes use of this in order to figure out when
> >  to flush the data correctly.
> 
> OK.  So with that patch, nfs_writepages() may still leave I/O pending,
> uninitiated, yes?
> 
> I don't understand why NFS hasn't been BUGging as it stands at present.  It
> has several end_page_writeback() calls but no set_page_writeback()s. 
> end_page_writeback() or rotate_reclaimable_page() will go BUG if the page
> wasn't PageWriteback().

It does have SetPageWriteback() calls in the asynchronous writeback
path. As you can see from the patch I just sent, I only needed to
replace them with set_page_writebacks().

Cheers,
 Trond

