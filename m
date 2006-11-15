Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030790AbWKOSFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030790AbWKOSFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030791AbWKOSFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:05:36 -0500
Received: from mx2.netapp.com ([216.240.18.37]:8003 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1030790AbWKOSFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:05:34 -0500
X-IronPort-AV: i="4.09,425,1157353200"; 
   d="scan'208"; a="2768738:sNHT29903881"
Subject: Re: Yet another borken page_count() check in
	invalidate_inode_pages2()....
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Charles Edward Lever <chucklever@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061115084641.827494be.akpm@osdl.org>
References: <1163568819.5645.8.camel@lade.trondhjem.org>
	 <1163596689.5691.40.camel@lade.trondhjem.org>
	 <20061115084641.827494be.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Wed, 15 Nov 2006 13:05:13 -0500
Message-Id: <1163613913.5691.215.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 15 Nov 2006 18:05:44.0703 (UTC) FILETIME=[AB8A90F0:01C708E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 08:46 -0800, Andrew Morton wrote:

> but nobody could have started another writeback after the "..." because they
> couldn't have got the lock_page(), and lock_page() is required for
> ->writepage()?

Nothing can have called writepage(), but something may be calling
->writepages(). That may call set_page_writeback without taking the page
lock.

Cheers,
  Trond
