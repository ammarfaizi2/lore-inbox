Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263827AbUFBSpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbUFBSpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263820AbUFBSpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:45:19 -0400
Received: from waste.org ([209.173.204.2]:61601 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263815AbUFBSog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 14:44:36 -0400
Date: Wed, 2 Jun 2004 13:43:35 -0500
From: Matt Mackall <mpm@selenic.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, suparna@in.ibm.com, linux-aio@kvack.org
Subject: Re: [1/2] use const in time.h unit conversion functions
Message-ID: <20040602184335.GC5414@waste.org>
References: <20040601021539.413a7ad7.akpm@osdl.org> <20040602012429.GV2093@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602012429.GV2093@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 06:24:29PM -0700, William Lee Irwin III wrote:
> On Tue, Jun 01, 2004 at 02:15:39AM -0700, Andrew Morton wrote:
> > - NFS server udpates
> > - md updates
> > - big x86 dmi_scan.c cleanup
> > - merged perfctr.  No documentation though :(
> > - cris architecture update
> 
> The time conversion functions may have const args, which is in fact
> useful for when they are passed const variables as arguments so as
> to avoid discarding qualifiers from pointer types warnings. This is
> a preparatory cleanup for a minor aio bugfix.
> 
> Index: timer-2.6.7-rc2/include/linux/time.h
> ===================================================================
> +++ timer-2.6.7-rc2/include/linux/time.h	2004-06-01 16:02:01.000000000 -0700
> @@ -184,7 +184,7 @@
>   * Avoid unnecessary multiplications/divisions in the
>   * two most common HZ cases:
>   */
> -static inline unsigned int jiffies_to_msecs(unsigned long j)
> +static inline unsigned int jiffies_to_msecs(const unsigned long j)

Does this actually do something meaningful? This stuff gets passed by value.

This is the second const-correctness patch I've seen in a couple days,
and I'd like to point out that while it's a noble cause, retrofitting
const decls onto interfaces is notorious for causing ripple effects in
APIs.

-- 
Mathematics is the supreme nostalgia of our time.
