Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263066AbUCMJLQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 04:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbUCMJLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 04:11:16 -0500
Received: from gate.ebshome.net ([66.92.248.57]:49848 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S263066AbUCMJLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 04:11:12 -0500
Date: Sat, 13 Mar 2004 01:11:10 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Bryan Rittmeyer <bryan@staidm.org>
Cc: linux-kernel@vger.kernel.org,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc32 copy_to_user dcbt fixup
Message-ID: <20040313091110.GA30393@gate.ebshome.net>
Mail-Followup-To: Bryan Rittmeyer <bryan@staidm.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20040313041547.GB11512@staidm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313041547.GB11512@staidm.org>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 08:15:47PM -0800, Bryan Rittmeyer wrote:
> copy_tofrom_user and copy_page use dcbt to prefetch source data [1].
> Since at least 2.4.17, these functions have been prefetching
> beyond the end of the source buffer, leading to two problems:
> 
> 1. Subtly broken software cache coherency. If the area following src
> was invalidate_dcache_range'd prior to submitting for DMA,
> an out-of-bounds dcbt from copy_to_user of a separate slab object
> may read in the area before DMA completion. When the DMA does complete,
> data will not be loaded from RAM because stale data is already in cache.
> Thus you get a corrupt network packet, bogus audio capture, etc.
> 

I reported this problem on -embedded list half a year ago.

This is already fixed in 2.4 tree, not sure about 2.6

Eugene.
