Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933881AbWK0WBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933881AbWK0WBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 17:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933880AbWK0WBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 17:01:46 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45008 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933875AbWK0WBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 17:01:44 -0500
Date: Mon, 27 Nov 2006 14:01:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs : reorder some 'struct inode' fields to speedup
 i_size manipulations
Message-Id: <20061127140131.0353bbca.akpm@osdl.org>
In-Reply-To: <456B5E04.50007@cosmosbay.com>
References: <20061120151700.4a4f9407@frecb000686>
	<20061123092805.1408b0c6@frecb000686>
	<20061123004053.76114a75.akpm@osdl.org>
	<200611231157.30056.dada1@cosmosbay.com>
	<20061127133748.4ebcd6b3.akpm@osdl.org>
	<456B5E04.50007@cosmosbay.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006 22:52:04 +0100
Eric Dumazet <dada1@cosmosbay.com> wrote:

> > I didn't understand that paragraph at all, really, so I took it out.
> > 
> > At present an i_size change will dirty one, two or three cachelines, most
> > likely one or two.
> > 
> > After your patch an i_size change will dirty one or two cachelines, most
> > likely one.
> > 
> > yes?
> 
> nope
> 
> Before :
> ---------
>   offsetof(i_size) = 0x3C
> 
> i_size is 8 bytes, so i_size spans 2 cache lines (if 64 or 32 bytes cache lines)

This all depends on the offset of the inode, and you don't know what that is.

offsetof(ext3_inode_info, vfs_inode) != offsetof(nfs_inode, vfs_inode), etc.
