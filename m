Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266568AbUH1EYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266568AbUH1EYr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 00:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268166AbUH1EYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 00:24:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24543 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266568AbUH1EYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 00:24:43 -0400
Date: Fri, 27 Aug 2004 21:24:32 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: paulus@samba.org, ak@muc.de, davem@davemloft.net, ak@suse.de,
       wli@holomorphy.com, davem@redhat.com, raybry@sgi.com,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64 support
 added
In-Reply-To: <20040827204241.25da512b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0408272121300.16949@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
 <20040816143903.GY11200@holomorphy.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
 <B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
 <20040827233602.GB1024@wotan.suse.de> <Pine.LNX.4.58.0408271717400.15597@schroedinger.engr.sgi.com>
 <20040827172337.638275c3.davem@davemloft.net> <20040827173641.5cfb79f6.akpm@osdl.org>
 <20040828010253.GA50329@muc.de> <20040827183940.33b38bc2.akpm@osdl.org>
 <16687.59671.869708.795999@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0408272021070.16607@schroedinger.engr.sgi.com>
 <20040827204241.25da512b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004, Andrew Morton wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
> >
> >  So I think the move to atomic for rss acceptable?
>
> Short-term, yes.  Longer term (within 12 months), no - 50-bit addresses on
> power5 will cause it to overflow.

I would expect the page size to rise as well. On IA64 we already have
16KB-64KB pages corresponding to 256TB - 1PB. Having to manage a couple of
billion pages could be a significant performance impact. Better increase
the page size.

I still would also like to see atomic64_t. I think there was a patch
posted to linux-ia64 a couple of months back introducing atomic64_t but it
was rejected since it would not be supportable on other arches.
