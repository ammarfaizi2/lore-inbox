Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbVHOSST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbVHOSST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbVHOSST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:18:19 -0400
Received: from verein.lst.de ([213.95.11.210]:8918 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S964883AbVHOSSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:18:18 -0400
Date: Mon, 15 Aug 2005 20:17:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: xfs-masters@oss.sgi.com
Cc: sfrench@samba.org, sct@redhat.com, okir@monad.swb.de.sgi.com,
       trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com,
       urban@teststation.com, nathans@sgi.com, akpm@osdl.org,
       samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, samba@samba.org, linux-xfs@oss.sgi.com
Subject: Re: [xfs-masters] [-mm PATCH 2/32] fs: fix-up schedule_timeout() usage
Message-ID: <20050815181752.GA23701@lst.de>
References: <20050815180514.GC2854@us.ibm.com> <20050815180804.GE2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815180804.GE2854@us.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 11:08:04AM -0700, Nishanth Aravamudan wrote:
> Description: Use schedule_timeout_{,un}interruptible() instead of
> set_current_state()/schedule_timeout() to reduce kernel size. Also use
> helper functions to convert between human time units and jiffies rather
> than constant HZ division to avoid rounding errors.

The XFS changes are still wrong for the same rason as last time,
we actually do want the daemons to do work if they're woken earlier
using wake_up_process.

