Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267137AbTAPPNs>; Thu, 16 Jan 2003 10:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267135AbTAPPNs>; Thu, 16 Jan 2003 10:13:48 -0500
Received: from franka.aracnet.com ([216.99.193.44]:55495 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267137AbTAPPNs>; Thu, 16 Jan 2003 10:13:48 -0500
Date: Thu, 16 Jan 2003 07:22:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make vm_enough_memory more efficient
Message-ID: <75430000.1042730552@titus>
In-Reply-To: <20030116001447.07337e9e.akpm@digeo.com>
References: <66360000.1042703224@titus> <20030116001447.07337e9e.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> vm_enough_memory seems to call si_meminfo just to get the total 
>> RAM, which seems far too expensive. This replaces the comment
>> saying "this is crap" with some code that's less crap.
>> 
>> Not heavily tested (compiles and boots), but seems pretty obvious.
> 
> Yup, obviously correct.

Cool.
 
> The really hurtful part of vm_enough_memory() is the call to
> get_page_cache_size(), which has to go over every CPU's local VM statistics
> in get_page_state().
> 
> But I guess you're running with sysctl_overcommit_memory != 0.

Yup, I manually disable that because it's so expensive. I'll see if
I can make the default case cheaper as well.

M.

