Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbUKRKma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbUKRKma (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbUKRKk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:40:29 -0500
Received: from holomorphy.com ([207.189.100.168]:60882 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262737AbUKRKgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:36:48 -0500
Date: Thu, 18 Nov 2004 02:36:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>, Keir.Fraser@cl.cam.ac.uk,
       haveblue@us.ibm.com, Ian.Pratt@cl.cam.ac.uk,
       linux-kernel@vger.kernel.org, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 2] Xen core patch : arch_free_page return value
Message-ID: <20041118103620.GC3217@holomorphy.com>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D122E52@liverpoolst.ad.cl.cam.ac.uk> <20041118021419.0c0d1dad.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118021419.0c0d1dad.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 02:14:19AM -0800, Andrew Morton wrote:
> Just send 'em to linux-kernel first-up and cc everyone else.  That way you
> avoid duplication of effort and everyone is on the same page.
> I'm still struggling to understand the rationale behind the mem.c change
> btw.  io_remap_page_range() _is_ remap_page_range() (or, now,
> remap_pfn_range()) on x86.  So whatever the patch is supposed to be doing,
> it's a no-op.

Sorry for stepping in so late. io_remap_page_range() has an
architecture-specific calling convention. It can't be used in code
shared across where the calling conventions differ until that's
resolved (which I intend to do, though I'm not going to stop anyone
from doing it before I get around to it).

As drivers/char/mem.c is shared across all architectures, using
io_remap_page_range() there now is unsound and some other method to
accomplish whatever it does beyond remap_pfn_range() must be found
unless the io_remap_page_range() calling convention is resolved first.


-- wli
