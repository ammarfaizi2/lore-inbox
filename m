Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWJJM1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWJJM1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWJJM1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:27:09 -0400
Received: from mx2.netapp.com ([216.240.18.37]:17941 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S964791AbWJJM1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:27:08 -0400
X-IronPort-AV: i="4.09,289,1157353200"; 
   d="scan'208"; a="416645770:sNHT17773268"
Subject: Re: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Steve Dickson <SteveD@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <452B8F92.6000307@RedHat.com>
References: <1160170629.5453.34.camel@lade.trondhjem.org>
	 <2069.1160473410@redhat.com> <1160480576.5466.27.camel@lade.trondhjem.org>
	 <452B8F92.6000307@RedHat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Tue, 10 Oct 2006 08:27:06 -0400
Message-Id: <1160483226.5466.34.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 10 Oct 2006 12:27:23.0475 (UTC) FILETIME=[70320230:01C6EC67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 08:18 -0400, Steve Dickson wrote:
> 
> Trond Myklebust wrote:
> > 
> > No. Invalidatepage does precisely the wrong thing: it invalidates dirty
> > data instead of committing it to disk. If you need to have the data
> > invalidated, then you should call truncate_inode_pages().
> Just curious... would it make sense to call truncate_inode_pages()
> to purge the the readdir cache? Meaning, in nfs_revalidate_mapping()
> truncate_inode_pages() would be called for S_ISDIR inodes?

Why? If, as in the case of an NFS directory, there are no dirty pages
then the two are supposed to be 100% equivalent.

Trond
