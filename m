Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752120AbWCCBch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbWCCBch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbWCCBch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:32:37 -0500
Received: from cantor2.suse.de ([195.135.220.15]:48864 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752120AbWCCBcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:32:36 -0500
From: Andi Kleen <ak@suse.de>
To: Zou Nan hai <nanhai.zou@intel.com>
Subject: Re: [Patch] Move swiotlb_init early on X86_64
Date: Fri, 3 Mar 2006 02:32:11 +0100
User-Agent: KMail/1.9.1
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
References: <117E3EB5059E4E48ADFF2822933287A441C94D@pdsmsx404> <1141342529.2537.11.camel@linux-znh>
In-Reply-To: <1141342529.2537.11.camel@linux-znh>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603030232.12101.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 March 2006 00:35, Zou Nan hai wrote:

> This patch modify the bootmem allocator,
> let normal bootmem allocation on 64 bit system first go above 4G
> address.

That's very ugly and likely to break some architectures. Sorry
but #ifdefs is the wrong way to do this.

Passing a limit parameter is better and use that in the swiotlb
allocation. If you're worried about changing too many callers
you could add a new entry point.

-Andi

