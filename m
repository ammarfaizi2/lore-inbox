Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWHAVsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWHAVsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWHAVsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:48:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:11992 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751143AbWHAVsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:48:04 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 8 of 13] Add a bootparameter to reserve high linear address space for hypervisors
Date: Tue, 1 Aug 2006 23:47:20 +0200
User-Agent: KMail/1.9.3
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>, Andrew Morton <akpm@osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
References: <0adfc39039c79e4f4121.1154462446@ezr>
In-Reply-To: <0adfc39039c79e4f4121.1154462446@ezr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608012347.20556.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> +		/*
> +		 * reservedtop=size reserves a hole at the top of the kernel
> +		 * address space which a hypervisor can load into later.
> +		 * Needed for dynamically loaded hypervisors, so relocating
> +		 * the fixmap can be done before paging initialization.
> +		 * This hole must be a multiple of 4M.
> +		 */
> +		else if (!memcmp(from, "reservedtop=", 12)) {
> +			unsigned long reserved = memparse(from+12, &from);
> +			reserved &= ~0x3fffff;
> +			set_fixaddr_top(-reserved);
> +		}

You need to add a dummy __setup for it, otherwise it will end up in
init's environments or be warned about.

Also it should be documented somewhere in Documentation

-Andi

