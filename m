Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131138AbRAYXBb>; Thu, 25 Jan 2001 18:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132017AbRAYXBD>; Thu, 25 Jan 2001 18:01:03 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:56329 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130908AbRAYXAr>; Thu, 25 Jan 2001 18:00:47 -0500
Date: Thu, 25 Jan 2001 19:11:01 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: V Ganesh <ganesh@veritas.com>, lkml <linux-kernel@vger.kernel.org>,
        Steve Lord <lord@sgi.com>
Subject: Re: inode->i_dirty_buffers redundant ?
In-Reply-To: <20010125164432.A12984@redhat.com>
Message-ID: <Pine.LNX.4.21.0101251907110.11559-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Jan 2001, Stephen C. Tweedie wrote:

> Hi,
> 
> On Thu, Jan 25, 2001 at 04:17:30PM +0530, V Ganesh wrote:
> 
> > so i_dirty_buffers contains buffer_heads of pages coming from write() as
> > well as metadata buffers from mark_buffer_dirty_inode(). a dirty MAP_SHARED
> > page which has been write()n to will potentially exist in both lists.
> > won't doing a set_dirty_page() instead of buffer_insert_inode_queue() in
> > __block_commit_write() make things much simpler ? then we'd have i_dirty_buffers
> > having _only_ metadata, and all data pages in the i_mapping->*_pages lists.
> 
> That would only complicate things: it would mean we'd have to scan
> both lists on fsync instead of just the one, for example.  There are a
> number of places where we need buffer lists for dirty data anyway,
> such as for bdflush's background sync to disk.  We also maintain the
> per-page buffer lists as caches of the virtual-to-physical mapping to
> avoid redundant bmap()ping.  

Btw, 

We probably want another kind of "IO buffer" abstraction for 2.5 which can
support buffer's bigger than PAGE_SIZE. 

Do you have any thoughts on that, Stephen? 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
