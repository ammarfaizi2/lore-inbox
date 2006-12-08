Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424325AbWLHEXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424325AbWLHEXK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 23:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424315AbWLHEXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 23:23:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:13021 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424325AbWLHEXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 23:23:08 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,511,1157353200"; 
   d="scan'208"; a="171995604:sNHT18010405"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <ak@suse.de>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] speed up single bio_vec allocation
Date: Thu, 7 Dec 2006 20:23:07 -0800
Message-ID: <000001c71a80$90342120$f180030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccacHuST1p5yvWpRJ27ur9AAQT1mAADda1Q
In-Reply-To: <p733b7rdsut.fsf@bingen.suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote on Thursday, December 07, 2006 6:28 PM
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> writes:
> > I tried to use cache_line_size() to find out the alignment of struct bio, but
> > stumbled on that it is a runtime function for x86_64.
> 
> It's a single global variable access:
> 
> #define cache_line_size() (boot_cpu_data.x86_cache_alignment)
> 
> Or do you mean it caused cache misses?  boot_cpu_data is cache aligned
> and practically read only, so there shouldn't be any false sharing at least.

No, I was looking for a generic constant that describes cache line size.
I needed a constant in order to avoid runtime check and to rely on compiler
to optimize a conditional check away.
