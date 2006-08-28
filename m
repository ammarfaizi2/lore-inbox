Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWH1VDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWH1VDQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 17:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWH1VDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 17:03:16 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:11756 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751085AbWH1VDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 17:03:15 -0400
Date: Mon, 28 Aug 2006 15:03:12 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] Really ignore kmem_cache_destroy return value
Message-ID: <20060828210312.GE20105@schatzie.adilger.int>
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20060825212026.GA2246@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825212026.GA2246@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 26, 2006  01:20 +0400, Alexey Dobriyan wrote:
> * Rougly half of callers already do it by not checking return value
> * Those who check it printk something, however, slab_error already printed
>   the name of failed cache.
> * XFS BUGs on failed kmem_cache_destroy which is not the decision
>   low-level filesystem driver should make. Converted to ignore.

If you are changing this, then it is better to add the BUG() at destroy time
right now.  This makes it MUCH easier to track down the cause (i.e. when
there are slab items that failed to be released, instead of getting a BUG()
the next time someone tries to load that module and the slab already exists).

Just because a lot of code doesn't check the return value, doesn't mean
it shouldn't be possible to do so.  Consider if there is lots of code
that doesn't check the kmalloc() return value - just because it works
most of the time doesn't mean we should start removing the checks for
a failed kmalloc().

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

