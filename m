Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVG1IMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVG1IMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 04:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVG1IM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 04:12:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43401 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261327AbVG1IMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 04:12:08 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Ingo Molnar <mingo@elte.hu>
cc: David.Mosberger@acm.org, Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
In-reply-to: Your message of "Thu, 28 Jul 2005 09:41:18 +0200."
             <20050728074118.GA20581@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jul 2005 18:09:08 +1000
Message-ID: <10613.1122538148@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005 09:41:18 +0200,
Ingo Molnar <mingo@elte.hu> wrote:
>
>* david mosberger <dmosberger@gmail.com> wrote:
>
>> Also, should this be called prefetch_stack() or perhaps even just
>> prefetch_task()?  Not every architecture defines a switch_stack
>> structure.
>
>yeah. I'd too suggest to call it prefetch_stack(), and not make it a
>macro & hook but something defined on all arches, with for now only ia64
>having any real code in the inline function.
>
>i'm wondering, is the switch_stack at the same/similar place as
>next->thread_info? If yes then we could simply do a
>prefetch(next->thread_info).

No, they can be up to 30K apart.  See include/asm-ia64/ptrace.h.
thread_info is at ~0xda0, depending on the config.  The switch_stack
can be as high as 0x7bd0 in the kernel stack, depending on why the task
is sleeping.

