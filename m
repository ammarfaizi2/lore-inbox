Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933718AbWK0ViD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933718AbWK0ViD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 16:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933744AbWK0ViD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 16:38:03 -0500
Received: from smtp.osdl.org ([65.172.181.25]:32713 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933718AbWK0ViB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 16:38:01 -0500
Date: Mon, 27 Nov 2006 13:37:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel McNeil <daniel@osdl.org>
Subject: Re: [PATCH] fs : reorder some 'struct inode' fields to speedup
 i_size manipulations
Message-Id: <20061127133748.4ebcd6b3.akpm@osdl.org>
In-Reply-To: <200611231157.30056.dada1@cosmosbay.com>
References: <20061120151700.4a4f9407@frecb000686>
	<20061123092805.1408b0c6@frecb000686>
	<20061123004053.76114a75.akpm@osdl.org>
	<200611231157.30056.dada1@cosmosbay.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 11:57:29 +0100
Eric Dumazet <dada1@cosmosbay.com> wrote:

> On 32bits SMP platforms, 64bits i_size is protected by a seqcount 
> (i_size_seqcount).
> 
> When i_size is read or written, i_size_seqcount is read/written as well, so it 
> make sense to group these two fields together in the same cache line.
> 
> Before this patch, accessing i_size needed 3 cache lines (2 for i_size, one 
> for i_size_seqcount). After, only one cache line is needed/ (dirtied on a 
> i_size change).

I didn't understand that paragraph at all, really, so I took it out.

At present an i_size change will dirty one, two or three cachelines, most
likely one or two.

After your patch an i_size change will dirty one or two cachelines, most
likely one.

yes?

> This patch moves i_size_seqcount next to i_size, and also moves i_version to 
> let offsetof(struct inode, i_size) being 0x40 instead of 0x3c (for 32bits 
> platforms). 
> 
> For 64 bits platforms, i_size_seqcount doesnt exist, and the move of a 'long 
> i_version' should not introduce a new hole because of padding.
> 
> Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
