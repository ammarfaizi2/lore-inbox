Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030491AbVKPVKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030491AbVKPVKO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbVKPVKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:10:14 -0500
Received: from pat.uio.no ([129.240.130.16]:41197 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030491AbVKPVKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:10:12 -0500
Subject: Re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051116205637.88606.qmail@web34112.mail.mud.yahoo.com>
References: <20051116205637.88606.qmail@web34112.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 16:09:51 -0500
Message-Id: <1132175392.8811.49.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.855, required 12,
	autolearn=disabled, AWL 1.15, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 12:56 -0800, Kenny Simpson wrote:
> I tried the same test, but instead of ftruncate64, I simply did a pwrite64 to get the file
> extended... and got 40M+ with mostly outbound traffic, and much less CPU usage..... 
> 
> Unfortunately, once my test file hit 4295065601, Bad Things (TM) started to happen.  The system
> time went to 100% of a CPU, and the nfs traffic on that mount stopped.
> 
> I got an oprofile of the spinning system:
> samples  %        symbol name
> 301039   27.9748  zap_pte_range
> 156234   14.5184  unmap_vmas
> 111760   10.3856  __bitmap_weight
> 103624    9.6295  _spin_lock
> 97063     9.0198  unmap_page_range
> 67011     6.2272  unmap_mapping_range
> 59382     5.5182  sub_preempt_count
> 51258     4.7633  zap_page_range
> 25235     2.3450  page_address
> 16768     1.5582  unmap_mapping_range_vma
> 13257     1.2319  debug_smp_processor_id
> 11594     1.0774  add_preempt_count
> 
> I also seem unable to kill the test process.
> 
> Any ideas?  (2**32 file size issue somewhere?)

Is this NFSv2?

Cheers,
  Trond

