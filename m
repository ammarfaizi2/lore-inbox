Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbULBCAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbULBCAH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 21:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbULBCAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 21:00:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:50065 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261530AbULBCAE (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 21:00:04 -0500
Date: Wed, 1 Dec 2004 17:59:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: nikita@clusterfs.com, nickpiggin@yahoo.com.au,
       Linux-Kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH]: 1/4 batch mark_page_accessed()
Message-Id: <20041201175924.75cdcb83.akpm@osdl.org>
In-Reply-To: <20041201185827.GA5459@dmt.cyclades>
References: <16800.47044.75874.56255@gargle.gargle.HOWL>
	<20041126185833.GA7740@logos.cnet>
	<41A7CC3D.9030405@yahoo.com.au>
	<20041130162956.GA3047@dmt.cyclades>
	<20041130173323.0b3ac83d.akpm@osdl.org>
	<16813.47036.476553.612418@gargle.gargle.HOWL>
	<20041201185827.GA5459@dmt.cyclades>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> > I don't think that atomic_inc will be particularly
>  > costly. generic_file_{write,read}() call find_get_page() just before
>  > calling mark_page_accessed(), so cache-line with page reference counter
>  > is most likely still exclusive owned by this CPU. 
> 
>  Assuming that is true - what could cause the slowdown? 

It isn't true.  Atomic ops have a considerable overhead, and this is
unrelated to cache misses.   This is especially true of p4's.

Now, that overhead may be justified.  Needs more study.
