Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263873AbUDPWpe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbUDPWpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:45:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:40401 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263917AbUDPWoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:44:34 -0400
Date: Fri, 16 Apr 2004 15:46:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: msync() needed before munmap() when writing to shared mapping?
Message-Id: <20040416154652.7ab27e79.akpm@osdl.org>
In-Reply-To: <20040416220223.GA27084@mail.shareable.org>
References: <20040416220223.GA27084@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:
>
> I've followed the logic from do_munmap() and it looks good:
> unmap_vmas->zap_pte_range->page_remove_rmap->set_page_dirty.
> 
> Can someone confirm this is correct, please?

yup, zap_pte_range() transfers pte dirtiness into pagecache dirtiness when
tearing down the mapping, leaving the dirty page floating about in
pagecache for kupdate/kswapd/fsync to catch.  Longstanding behaviour.

