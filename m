Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759134AbWK3Idg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759134AbWK3Idg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759139AbWK3Idg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:33:36 -0500
Received: from smtp.osdl.org ([65.172.181.25]:8119 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759137AbWK3Idf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:33:35 -0500
Date: Thu, 30 Nov 2006 00:29:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Srinivasa Ds <srinivasa@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       swhiteho@redhat.com, fabbione@ubuntu.com, bunk@stusta.de,
       aarora@linux.vnet.ibm.com, aarora@in.ibm.com
Subject: Re: [RFC][PATCH] Mount problem with the GFS2 code
Message-Id: <20061130002934.829334a6.akpm@osdl.org>
In-Reply-To: <456EA5BF.6090304@in.ibm.com>
References: <456EA5BF.6090304@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 15:04:55 +0530
Srinivasa Ds <srinivasa@in.ibm.com> wrote:

> ==========================================================================
> On debugging further we found that problem is while reading the super 
> block(gfs2_read_super) and comparing the magic number in it.
> When I  replace the submit_bio() call(present in gfs2_read_super) with 
> the sb_getblk() and ll_rw_block(), mount operation succeded.

umm, why on earth does gfs2_read_super() go direct-to-BIO?

Switching to sb_getblk()+ll_rw_blk() sounds like a preferable fix.

Even better would be switching to a bare sb_bread().   If sb->s_blocksize
isn't set up by then then either set it up or, if you must, use __bread().

