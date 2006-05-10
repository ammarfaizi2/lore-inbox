Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWEJTvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWEJTvO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 15:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWEJTvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 15:51:14 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:37546 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751502AbWEJTvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 15:51:13 -0400
Subject: Re: [RFC] Hugetlb demotion for x86
From: Dave Hansen <haveblue@us.ibm.com>
To: Adam Litke <agl@us.ibm.com>
Cc: linux-mm@kvack.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1147287400.24029.81.camel@localhost.localdomain>
References: <1147287400.24029.81.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 10 May 2006 12:49:59 -0700
Message-Id: <1147290600.17933.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 13:56 -0500, Adam Litke wrote:
> 
> +       do_munmap(mm, start, HPAGE_SIZE);
> +       start = do_mmap_pgoff(0, start, HPAGE_SIZE, prot, flags, 0);
> +       if (start < 0) {
> +               return VM_FAULT_OOM;
> +       } 


Hmm..  These are being done in this path, right?

	do_page_fault()
	handle_mm_fault()
	__handle_mm_fault()
	hugetlb_fault()
	hugetlb_demote_page()

I believe do_munmap() requires a write on mmap_sem(), but
do_page_fault() only takes a read.

-- Dave

