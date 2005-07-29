Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbVG2H4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVG2H4q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 03:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVG2Hqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 03:46:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39313 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262493AbVG2Hp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 03:45:56 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Ingo Molnar'" <mingo@elte.hu>, David.Mosberger@acm.org,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function 
In-reply-to: Your message of "Fri, 29 Jul 2005 00:22:43 MST."
             <200507290722.j6T7Mig07477@unix-os.sc.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Jul 2005 17:45:42 +1000
Message-ID: <10766.1122623142@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005 00:22:43 -0700, 
"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>On ia64, we have two kernel stacks, one for outgoing task, and one for
>incoming task.  for outgoing task, we haven't called switch_to() yet.
>So the switch stack structure for 'current' will be allocated immediately
>below current 'sp' pointer. For the incoming task, it was fully ctx'ed out
>previously, so switch stack structure is immediate above kernel_stack(next).
>It Would be beneficial to prefetch both stacks.

struct switch_stack for current is all write data, no reading is done.
Is it worth doing prefetchw() for current?  IOW, is there any
measurable performance gain?

