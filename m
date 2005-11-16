Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbVKPU4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbVKPU4i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbVKPU4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:56:38 -0500
Received: from web34112.mail.mud.yahoo.com ([66.163.178.110]:30384 "HELO
	web34112.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030501AbVKPU4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:56:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Xi+vcHrfCQcsZY/O0YlAkyeHomae8KLrBR8LmZ2GNGjSAR4sIpR3eR6ikiPHLYwmVwt7rkBquwOtfnaGIn7oWiAgbP+vSTM3OfUtSWC7A0+Ib6gRifxKe6BiX7YhBojAcxhD7O0Kbzg5L92NI7tLeM6zCwqL2rl3pUDQxzSDFxo=  ;
Message-ID: <20051116205637.88606.qmail@web34112.mail.mud.yahoo.com>
Date: Wed, 16 Nov 2005 12:56:36 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: mmap over nfs leads to excessive system load
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <1132171500.8811.37.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried the same test, but instead of ftruncate64, I simply did a pwrite64 to get the file
extended... and got 40M+ with mostly outbound traffic, and much less CPU usage..... 

Unfortunately, once my test file hit 4295065601, Bad Things (TM) started to happen.  The system
time went to 100% of a CPU, and the nfs traffic on that mount stopped.

I got an oprofile of the spinning system:
samples  %        symbol name
301039   27.9748  zap_pte_range
156234   14.5184  unmap_vmas
111760   10.3856  __bitmap_weight
103624    9.6295  _spin_lock
97063     9.0198  unmap_page_range
67011     6.2272  unmap_mapping_range
59382     5.5182  sub_preempt_count
51258     4.7633  zap_page_range
25235     2.3450  page_address
16768     1.5582  unmap_mapping_range_vma
13257     1.2319  debug_smp_processor_id
11594     1.0774  add_preempt_count

I also seem unable to kill the test process.

Any ideas?  (2**32 file size issue somewhere?)

-Kenny



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
