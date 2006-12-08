Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424321AbWLHEhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424321AbWLHEhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 23:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424339AbWLHEhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 23:37:18 -0500
Received: from ns2.suse.de ([195.135.220.15]:56876 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424321AbWLHEhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 23:37:16 -0500
From: Andi Kleen <ak@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [patch] speed up single bio_vec allocation
Date: Fri, 8 Dec 2006 05:37:11 +0100
User-Agent: KMail/1.9.5
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <000001c71a80$90342120$f180030a@amr.corp.intel.com>
In-Reply-To: <000001c71a80$90342120$f180030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612080537.11936.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 December 2006 05:23, Chen, Kenneth W wrote:
> Andi Kleen wrote on Thursday, December 07, 2006 6:28 PM
> > "Chen, Kenneth W" <kenneth.w.chen@intel.com> writes:
> > > I tried to use cache_line_size() to find out the alignment of struct bio, but
> > > stumbled on that it is a runtime function for x86_64.
> > 
> > It's a single global variable access:
> > 
> > #define cache_line_size() (boot_cpu_data.x86_cache_alignment)
> > 
> > Or do you mean it caused cache misses?  boot_cpu_data is cache aligned
> > and practically read only, so there shouldn't be any false sharing at least.
> 
> No, I was looking for a generic constant that describes cache line size.

The same kernel binary runs on CPUs with 
different cache line sizes. For example P4 has 128 bytes, Core2 64 bytes.

However there is a worst case alignment that is used for static
alignments which is L1_CACHE_BYTES. It would be normally 128 bytes
on a x86 kernel, unless it is especially compiled for a CPU with
a smaller cache line size.

-Andi
