Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWIARec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWIARec (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 13:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWIARec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 13:34:32 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:37906 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1751243AbWIARec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 13:34:32 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile error
X-Message-Flag: Warning: May contain useful information
References: <20060901015818.42767813.akpm@osdl.org>
	<20060901160023.GB18276@stusta.de>
	<20060901101340.962150cb.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 01 Sep 2006 10:34:24 -0700
In-Reply-To: <20060901101340.962150cb.akpm@osdl.org> (Andrew Morton's message of "Fri, 1 Sep 2006 10:13:40 -0700")
Message-ID: <adak64nij8f.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2006 17:34:26.0700 (UTC) FILETIME=[DF2ECCC0:01C6CDEC]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> What's __raw_writeq() supposed to do, anyway?  On alpha
    Andrew> it's writeq() without an mb().  On parisc it's writeq()
    Andrew> only the data is byte-reversed.  On sparc64() it's
    Andrew> incomprehensible.  On everything else it's writeq().

My understanding is that __raw_writeq() is like writeq() except not
strongly ordered and without the byte-swap on big-endian
architectures.  The __raw_writeX() variants are convenient to avoid
having to write inefficient code like writel(swab32(foo), ...) when
talking to a PCI device that wants big-endian data.  Without the raw
variant, you end up with a double swap on big-endian architectures.

sparc64 looks wrong, since __raw_writeq() seems identical to writeq(),
which seems to imply it's going to swab what is stores.

 - R.
