Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWJJNXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWJJNXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWJJNXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:23:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18098 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750733AbWJJNXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:23:12 -0400
Message-ID: <452B9EB1.4090806@RedHat.com>
Date: Tue, 10 Oct 2006 09:22:57 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060911 Red Hat/1.0.5-0.1.el4 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Trond Myklebust <Trond.Myklebust@netapp.com>
CC: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM: Fix the gfp_mask in invalidate_complete_page2
References: <1160170629.5453.34.camel@lade.trondhjem.org>	 <2069.1160473410@redhat.com> <1160480576.5466.27.camel@lade.trondhjem.org>	 <452B8F92.6000307@RedHat.com> <1160483226.5466.34.camel@lade.trondhjem.org>
In-Reply-To: <1160483226.5466.34.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Trond Myklebust wrote:
> On Tue, 2006-10-10 at 08:18 -0400, Steve Dickson wrote:
>> Trond Myklebust wrote:
>>> No. Invalidatepage does precisely the wrong thing: it invalidates dirty
>>> data instead of committing it to disk. If you need to have the data
>>> invalidated, then you should call truncate_inode_pages().
>> Just curious... would it make sense to call truncate_inode_pages()
>> to purge the the readdir cache? Meaning, in nfs_revalidate_mapping()
>> truncate_inode_pages() would be called for S_ISDIR inodes?
> 
> Why? If, as in the case of an NFS directory, there are no dirty pages
> then the two are supposed to be 100% equivalent.
Well as you know, lately we've had problems with 
invalidate_inode_pages2() failing to invalidate pages (regardless of
their state). So I was thinking truncate_inode_pages() might be
better for directories since there seem to be more a guarantee that
the pages will be gone with truncate_inode_pages() than
invalidate_inode_pages2() (due to the fact there will not be any
dirty pages).

But since you have to call truncate_inode_pages under the
inode->i_mutex, there might be a performance hit...

steved.

