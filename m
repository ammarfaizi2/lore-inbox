Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUCCK7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUCCK6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:58:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:20890 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262431AbUCCK6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:58:25 -0500
Date: Wed, 3 Mar 2004 02:58:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, hugh@veritas.com,
       wli@holomorphy.com
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-Id: <20040303025820.2cf6078a.akpm@osdl.org>
In-Reply-To: <20040303070933.GB4922@dualathlon.random>
References: <20040303070933.GB4922@dualathlon.random>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> --- sles-objrmap/mm/rmap.c.~1~	2004-03-03 06:45:38.995594456 +0100
>  +++ sles-objrmap/mm/rmap.c	2004-03-03 07:01:39.200621104 +0100
>  @@ -470,7 +470,7 @@ try_to_unmap_obj_one(struct vm_area_stru
>   	if (!pte)
>   		goto out;
>   
>  -	if (vma->vm_flags & VM_LOCKED) {
>  +	if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
>   		ret =  SWAP_FAIL;
>   		goto out_unmap;

I keep on wanting to put that in there too.  But pages in a VM_RESERVED vma
should not find their way onto the LRU.  Maybe we should be checking for
that in do_no_page().


