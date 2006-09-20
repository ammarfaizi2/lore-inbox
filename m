Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWITLAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWITLAS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 07:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWITLAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 07:00:18 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:37562 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1751115AbWITLAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 07:00:15 -0400
Message-ID: <45111F37.2060607@hitachi.com>
Date: Wed, 20 Sep 2006 20:00:07 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Organization: Systems Development Lab., Hitachi, Ltd., Japan
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: prasanna@in.ibm.com
Cc: Martin Bligh <mbligh@google.com>, Vara Prasad <prasadav@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <4510413F.2030200@us.ibm.com> <45104468.50106@google.com> <20060919093056.GA21618@in.ibm.com>
In-Reply-To: <20060919093056.GA21618@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

S. P. Prasanna wrote:
> Some more coplicated method.
> How about inserting a (instruction size) number of breakpoints and
> wait untill all the threads gets scheduled atleast once (so that
> threads would hit the breakpoint, if their IPs are in the middle of
> instruction we want to replace with jump) and then replace with
> jump instruction.

I think there is no need to insert so many breakpoints.
Instead of that, you merely wait that all the threads which are
running on each processors at that time gets scheduled, if the kernel
is *NOT* preemptive.

If the kernel is preemptive, some threads might sleep on the target
address. In this case, we can use freeze_processes() to ensure safety.
This idea was proposed by Ingo.

Thanks,
-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com

