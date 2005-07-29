Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVG2IDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVG2IDL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 04:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVG2IDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 04:03:11 -0400
Received: from fmr22.intel.com ([143.183.121.14]:43935 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262492AbVG2IDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 04:03:08 -0400
Message-Id: <200507290802.j6T82hg08064@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Keith Owens'" <kaos@ocs.com.au>
Cc: "'Ingo Molnar'" <mingo@elte.hu>, <David.Mosberger@acm.org>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: Add prefetch switch stack hook in scheduler function 
Date: Fri, 29 Jul 2005 01:02:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWUEYvmW+w973ZzQYm1Cmso5RtSzgAAZ44w
In-Reply-To: <10766.1122623142@kao2.melbourne.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote on Friday, July 29, 2005 12:46 AM
> On Fri, 29 Jul 2005 00:22:43 -0700, 
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> >On ia64, we have two kernel stacks, one for outgoing task, and one for
> >incoming task.  for outgoing task, we haven't called switch_to() yet.
> >So the switch stack structure for 'current' will be allocated immediately
> >below current 'sp' pointer. For the incoming task, it was fully ctx'ed out
> >previously, so switch stack structure is immediate above kernel_stack(next).
> >It Would be beneficial to prefetch both stacks.
> 
> struct switch_stack for current is all write data, no reading is done.
> Is it worth doing prefetchw() for current?

Oh yes, very much so.  L2 is an out of order cache and it can only queue
limited amount of store operations.  With the number of stores for switch
stack structure, it will easily exceed that hardware limit.

> IOW, is there any measurable performance gain?

I don't have exact breakdown to how much contribute from prefetch the outgoing
process versus incoming process.  But I believe both contributes to perf.
gain.

- Ken


