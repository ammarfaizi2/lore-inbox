Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267408AbUJGPpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267408AbUJGPpQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUJGPpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:45:15 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:38085 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S267408AbUJGPoL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:44:11 -0400
Subject: Re: [PATCH] no buddy bitmap patch : for ia64 [2/2]
From: Dave Hansen <haveblue@us.ibm.com>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Luck, Tony" <tony.luck@intel.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <4165399D.7010600@jp.fujitsu.com>
References: <4165399D.7010600@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1097163793.3625.47.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 07 Oct 2004 08:43:13 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 05:42, Hiroyuki KAMEZAWA wrote:
>  #ifdef CONFIG_VIRTUAL_MEM_MAP
>  extern int ia64_pfn_valid (unsigned long pfn);
> +#define HOLES_IN_ZONE 1
>  #else
>  # define ia64_pfn_valid(pfn) 1
>  #endif

The real way to do this is to put it in a Kconfig file.  

something like:

config HOLES_IN_ZONE
	bool
	depends on VIRTUAL_MEM_MAP

right below where 'config VIRTUAL_MEM_MAP' is defined.  That way, if any
other architectures need it, they alter their Kconfig files instead of
headers.  Also, it leaves the possibility of having an arch-independent
Kconfig file for memory-related options which I'd like to do in the
future.

-- Dave

