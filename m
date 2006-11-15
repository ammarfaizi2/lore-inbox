Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161493AbWKOU6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161493AbWKOU6A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161506AbWKOU6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:58:00 -0500
Received: from mx2.netapp.com ([216.240.18.37]:16963 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1161493AbWKOU57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 15:57:59 -0500
X-IronPort-AV: i="4.09,425,1157353200"; 
   d="scan'208"; a="2814887:sNHT16070453"
Subject: Re: Yet another borken page_count() check in
	invalidate_inode_pages2()....
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Charles Edward Lever <chucklever@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061115112426.84e5417c.akpm@osdl.org>
References: <1163568819.5645.8.camel@lade.trondhjem.org>
	 <1163596689.5691.40.camel@lade.trondhjem.org>
	 <20061115084641.827494be.akpm@osdl.org>
	 <1163613913.5691.215.camel@lade.trondhjem.org>
	 <20061115112426.84e5417c.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Wed, 15 Nov 2006 15:57:45 -0500
Message-Id: <1163624265.5880.31.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 15 Nov 2006 20:58:15.0882 (UTC) FILETIME=[C55322A0:01C708F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 11:24 -0800, Andrew Morton wrote:

> The protocol is
> 
> 	lock_page()
> 	set_page_writeback()
> 	->writepage()

We're not using ->writepage().

> and there are various places which assume that nobody will start new
> writeout of a locked page.  But I forget where they are - things have always
> been this way.

Huh? There has never been a requirement to lock the page if all you want
to do is call set_page_writeback(). The only reason why we want to do
that at all is to allow the VM to track that the page is under I/O. All
other operations involved in scheduling writes are protected by internal
NFS locks.
