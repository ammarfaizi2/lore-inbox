Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266773AbUGLNxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266773AbUGLNxs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUGLNwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:52:54 -0400
Received: from ozlabs.org ([203.10.76.45]:58055 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266182AbUGLNwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:52:50 -0400
Date: Mon, 12 Jul 2004 18:39:30 +1000
From: Anton Blanchard <anton@samba.org>
To: Shai Fultheim <shai@scalex86.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "'Linux Kernel ML'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alignment for CPU maps, add padding semantics
Message-ID: <20040712083930.GA2324@krispykreme>
References: <S266631AbUGKWxO/20040711225314Z+1231@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S266631AbUGKWxO/20040711225314Z+1231@vger.kernel.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> The attached patch add missing alignments for CPU maps (cpu_online_map,
> node_2_cpu_mask, cpu_2_node, cpu_2_logical_apicid).  It allows better
> cache-line utilization by having the most usable part of each map on
> same cache-line.

These bitmaps are pretty much readonly and 4 bytes on most machines and 
this change makes them up to 128 bytes long. They are also naturally
aligned in the 4 byte case so cannot cross a cacheline boundary.

It makes much more sense to have all these readonly structures packed
together in the same cacheline.

Anton
