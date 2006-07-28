Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161200AbWG1TqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbWG1TqM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 15:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWG1TqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 15:46:12 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:2244 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030286AbWG1TqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 15:46:10 -0400
Date: Fri, 28 Jul 2006 15:40:36 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 1/2] i386: add CFI macros for stack manipulation
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jan Beulich <jbeulich@novell.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607281543_MC3-1-C665-8359@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200607282036.45608.ak@suse.de>

On Fri, 28 Jul 2006 20:36:45 +0200, Andi Kleen wrote:
> 
> On Friday 28 July 2006 19:50, Chuck Ebbert wrote:
> > Add macros to dwarf2.h to simplify pushing and popping stack
> > variables.
> 
> I feared someone would do that patch. I've thought about it myself.
> 
> However it's not a good idea. I've already had complaints that some code in 
> x86-64 is too hard to read/debug because it uses too many macros. I think 
> it's better  if the core core still uses "real" instructions and keep the 
> CFI_* stuff as annotation that most people can just ignore.

I did this because it should prevent:

| Date: Thu, 27 Jul 2006 07:45:35 +0200
| From: Markus Armbruster <armbru@redhat.com>
| Subject: [PATCH] Fix trivial unwind info bug
| To: linux-kernel@vger.kernel.org
| Message-ID: <874px31tz4.fsf@pike.pond.sub.org>
| Content-Type: text/plain; charset=us-ascii
| 
| CFA needs to be adjusted upwards for push, and downwards for pop.
| arch/i386/kernel/entry.S gets it wrong in one place.
| 
| Signed-off-by: Markus Armbruster <armbru@redhat.com>
| 
| 
| diff --git a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
| index d9a260f..37a7d2e 100644
| --- a/arch/i386/kernel/entry.S
| +++ b/arch/i386/kernel/entry.S
| @@ -204,7 +204,7 @@ #define RING0_PTREGS_FRAME \
|  ENTRY(ret_from_fork)
|         CFI_STARTPROC
|         pushl %eax
| -       CFI_ADJUST_CFA_OFFSET -4
| +       CFI_ADJUST_CFA_OFFSET 4
|         call schedule_tail
|         GET_THREAD_INFO(%ebp)
|         popl %eax

Otherwise I was just going to indent the annotations an additional
tabstop to move them out of the way.  (They really annoy me.)

-- 
Chuck

