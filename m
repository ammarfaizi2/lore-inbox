Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbTLPEsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 23:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264356AbTLPEsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 23:48:47 -0500
Received: from rth.ninka.net ([216.101.162.244]:64640 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264339AbTLPEsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 23:48:45 -0500
Date: Mon, 15 Dec 2003 20:48:35 -0800
From: "David S. Miller" <davem@redhat.com>
To: Randolph Chung <randolph@tausq.org>
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org
Subject: Re: Question about cache flushing and fork
Message-Id: <20031215204835.0993a51a.davem@redhat.com>
In-Reply-To: <20031216044033.GT533@tausq.org>
References: <20031216044033.GT533@tausq.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003 20:40:33 -0800
Randolph Chung <randolph@tausq.org> wrote:

> Can someone please explain why it is necessary to flush the cache 
> during fork()? (i.e. call to flush_cache_mm() in dup_mmap)

Writable pages that will be shared between the child and
parent are marked read-only and COW, some cpu caches store
protection information in the cache lines in order to avoid
TLB lookups etc. so the caches must be flushed since the
page protection information is changing.
