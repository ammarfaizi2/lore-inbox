Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWDUARD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWDUARD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWDUARB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:17:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63679 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932167AbWDUARA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:17:00 -0400
Date: Thu, 20 Apr 2006 17:15:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: hch@infradead.org, dhowells@redhat.com, torvalds@osdl.org,
       steved@redhat.com, sct@redhat.com, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] FS-Cache: Export find_get_pages()
Message-Id: <20060420171550.55f1b125.akpm@osdl.org>
In-Reply-To: <21746.1145555150@warthog.cambridge.redhat.com>
References: <20060420171922.GB21659@infradead.org>
	<20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
	<20060420165935.9968.11060.stgit@warthog.cambridge.redhat.com>
	<21746.1145555150@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > > The attached patch exports find_get_pages() for use by the kAFS filesystem
> > > in conjunction with it caching patch.
> > 
> > Why don't you use pagevec ?
> 
> You mean pagevec_lookup() I suppose... That's probably reasonable, though
> slower.
> 

But the code's using pagevecs now.  In a strange manner.

+		nr_pages = find_get_pages(vnode->vfs_inode.i_mapping, first,
+					  PAGEVEC_SIZE, pvec.pages);

that's an open-coded pagevec_lookup().
