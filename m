Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWFTAww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWFTAww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 20:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWFTAww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 20:52:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54662 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965023AbWFTAwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 20:52:51 -0400
Date: Mon, 19 Jun 2006 17:56:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Mahoney <jeffm@suse.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: [PATCH 03/04] reiserfs: reorganize bitmap loading functions
Message-Id: <20060619175606.6e7cb919.akpm@osdl.org>
In-Reply-To: <20060615014203.GA8216@locomotive.unixthugs.org>
References: <20060615014203.GA8216@locomotive.unixthugs.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney <jeffm@suse.com> wrote:
>
> +	for (i = 0; i < SB_BMAP_NR(sb); i++)
> +		bitmap[i].bh = reiserfs_read_bitmap_block(sb, i);

Can return NULL.

> +	/* make sure we have them all */
> +	for (i = 0; i < SB_BMAP_NR(sb); i++) {
> +		wait_on_buffer(bitmap[i].bh);

Will go oops.
