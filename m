Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbTFMHA0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 03:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265192AbTFMHAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 03:00:25 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:2099 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265188AbTFMHAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 03:00:22 -0400
Date: Fri, 13 Jun 2003 00:15:17 -0700
From: Andrew Morton <akpm@digeo.com>
To: Roland McGrath <roland@redhat.com>
Cc: davidm@hpl.hp.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: FIXMAP-related change to mm/memory.c
Message-Id: <20030613001517.5413e511.akpm@digeo.com>
In-Reply-To: <200306130656.h5D6uGc32359@magilla.sf.frob.com>
References: <16105.28970.526326.249287@napali.hpl.hp.com>
	<200306130656.h5D6uGc32359@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2003 07:14:09.0346 (UTC) FILETIME=[621F4220:01C3317B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
>  			static struct vm_area_struct fixmap_vma = {
>   				/* Catch users - if there are any valid
>   				   ones, we can make this be "&init_mm" or
>   				   something.  */
>   				.vm_mm = NULL,
>  -				.vm_start = FIXADDR_START,
>  -				.vm_end = FIXADDR_TOP,
>  +				.vm_start = FIXADDR_USER_START,
>  +				.vm_end = FIXADDR_USER_END,
>   				.vm_page_prot = PAGE_READONLY,
>   				.vm_flags = VM_READ | VM_EXEC,
>   			};

Note that the current version of this code does not compile for User Mode
Linux.  Its FIXADDR_TOP is not a constant.   It would be nice to fix that
this time around.

It appears that this patch will break x86_64, parisc and um.

