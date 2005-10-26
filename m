Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVJZPVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVJZPVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 11:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVJZPVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 11:21:05 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:56980
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S964785AbVJZPVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 11:21:04 -0400
Message-Id: <435FBB1A.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 26 Oct 2005 17:21:30 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: DIE_GPF vs. DIE_PAGE_FAULT/DIE_TRAP
References: <435FB26B.76F0.0078.0@novell.com> <200510261701.52611.ak@suse.de>
In-Reply-To: <200510261701.52611.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 26.10.05 17:01:52 >>>
>On Wednesday 26 October 2005 16:44, Jan Beulich wrote:
>> What is the reason for notify_die(DIE_GPF, ...) to be run late in
the GP
>> fault handler (on both i386 and x86-64), while for other exceptions
it
>> gets run first thing (as I would have expected for all exceptions)?
>
>"die"s as the name says are normally only supposed to run when the
>error is determined to be an illegal kernel fault.  Page fault
>got an exception to that to make kprobes work. For the others
>it is mostly only because there is no good way to check
>for illegal kernel faults first.

Hmm, then this isn't really useful for a debugger. There ought to be a
chance to filter exceptions early (i.e. debugger accesses to non-mapped
memory or non-existing MSRs) and a chance to detect bad faults (note
that the kernel normal exception recovery mechanism may not be usable
here because for example page faults first try to service the fault
before scanning the fixup tables, but a debugger will normally not want
a page-in to happen behind its back). I thought the latter was what gets
reported as DIE_OOPS, while the former would be the filtering occasions
(and I actually took the "grossly misnamed" comment in asm/kdebug.h as
additional indication for that).

Jan
