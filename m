Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbVIZWaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbVIZWaz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 18:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVIZWaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 18:30:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58788 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932512AbVIZWay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 18:30:54 -0400
Date: Mon, 26 Sep 2005 18:30:37 -0400
From: Dave Jones <davej@redhat.com>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] When L3 is present show its size in /proc/cpuinfo
Message-ID: <20050926223037.GN19275@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20050926145956.B15625@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050926145956.B15625@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 02:59:56PM -0700, Venkatesh Pallipadi wrote:
 
 > The code that prints the cache size assumes that L3 always lives in chipset and
 > is shared across CPUs. Which is not really true.
 > 
 > I think all the cachesizes reported by cpuid are in the processor itself.
 > The attached patch changes the code to reflect that.
 > 
 > Dave, any idea where that original comment in the code came from?

Been there for a long time iirc (Though I've not checked [my kingdom for
a 'git annotate' tool])

 > Are there any
 > systems which reports the L3 cache size in cpuid, when L3 sits in northbridge?

Very unlikely.
The only legacy system with L3 that I recall was the AMD K6-III (which had on-CPU L1/L2,
though some motherboards at the time also included an L3 (or L2 if used with an earlier
socket 7 cpu).  None of those off-cpu caches were detectable with cpuid, and
required reading from pci config space to determine their size/status etc.

The big question I have though is how relevant that 'weighting' is today
if we factor in L3.

		Dave

