Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbVKPSiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbVKPSiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbVKPSiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:38:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20131 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030431AbVKPSiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:38:16 -0500
Date: Wed, 16 Nov 2005 18:38:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, theonetruekenny@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: mmap over nfs leads to excessive system load
Message-ID: <20051116183808.GA5642@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Andrew Morton <akpm@osdl.org>, theonetruekenny@yahoo.com,
	linux-kernel@vger.kernel.org
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com> <1132163057.8811.15.camel@lade.trondhjem.org> <20051116100053.44d81ae2.akpm@osdl.org> <1132166062.8811.30.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132166062.8811.30.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 01:34:22PM -0500, Trond Myklebust wrote:
> Not really. The pages aren't flushed at this time. We the point is to
> gather several pages and coalesce them into one over-the-wire RPC call.
> That means we cannot really do it from inside ->writepage().
> 
> We do start the actual RPC calls in ->writepages(), though.

This is a problem we have in various filesystems.  Except for really
bad OOM situations the filesystem should never get a writeout request
for a single file.  We should really stop having ->writepage called by
the VM and move this kind of batching code into the VM.  I'm runnin into
similar issues for XFS and unwritten/delayed extent conversion once again.

