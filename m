Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVCCGbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVCCGbH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVCCGXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 01:23:39 -0500
Received: from fire.osdl.org ([65.172.181.4]:11477 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261502AbVCCGUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:20:31 -0500
Date: Wed, 2 Mar 2005 22:20:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
Message-Id: <20050302222008.4910eb7b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503022206001.4389@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>
	<20050302174507.7991af94.akpm@osdl.org>
	<Pine.LNX.4.58.0503021803510.3080@schroedinger.engr.sgi.com>
	<20050302185508.4cd2f618.akpm@osdl.org>
	<Pine.LNX.4.58.0503021856380.3365@schroedinger.engr.sgi.com>
	<20050302201425.2b994195.akpm@osdl.org>
	<Pine.LNX.4.58.0503022021150.3816@schroedinger.engr.sgi.com>
	<20050302205612.451d220b.akpm@osdl.org>
	<Pine.LNX.4.58.0503022206001.4389@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Wed, 2 Mar 2005, Andrew Morton wrote:
> 
>  > > Any mmap changes requires the mmapsem.
>  >
>  > sys_remap_file_pages() will call install_page() under down_read(mmap_sem).
>  > It relies upon page_table_lock for pte atomicity.
> 
>  This is not relevant since it only deals with file pages.

OK.   And CONFIG_DEBUG_PAGEALLOC?

> ptes are only
>  installed atomically for anonymous memory (if CONFIG_ATOMIC_OPS
>  is defined).

It's a shame.  A *nice* solution to this problem would address all pte ops
and wouldn't have such special cases...
