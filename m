Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbTAPIEy>; Thu, 16 Jan 2003 03:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265187AbTAPIEy>; Thu, 16 Jan 2003 03:04:54 -0500
Received: from nowaydude.rearden.com ([64.160.169.126]:46011 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S265126AbTAPIEx>; Thu, 16 Jan 2003 03:04:53 -0500
Date: Thu, 16 Jan 2003 00:14:47 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make vm_enough_memory more efficient
Message-Id: <20030116001447.07337e9e.akpm@digeo.com>
In-Reply-To: <66360000.1042703224@titus>
References: <66360000.1042703224@titus>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jan 2003 08:13:44.0195 (UTC) FILETIME=[2FC2ED30:01C2BD37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> vm_enough_memory seems to call si_meminfo just to get the total 
> RAM, which seems far too expensive. This replaces the comment
> saying "this is crap" with some code that's less crap.
> 
> Not heavily tested (compiles and boots), but seems pretty obvious.

Yup, obviously correct.

The really hurtful part of vm_enough_memory() is the call to
get_page_cache_size(), which has to go over every CPU's local VM statistics
in get_page_state().

But I guess you're running with sysctl_overcommit_memory != 0.


