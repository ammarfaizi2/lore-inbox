Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWITN1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWITN1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWITN1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:27:21 -0400
Received: from mail7.hitachi.co.jp ([133.145.228.42]:53167 "EHLO
	mail7.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1751253AbWITN1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:27:20 -0400
Message-ID: <451141B1.40803@hitachi.com>
Date: Wed, 20 Sep 2006 22:27:13 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Organization: Systems Development Lab., Hitachi, Ltd., Japan
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: karim@opersys.com
Cc: Martin Bligh <mbligh@google.com>, prasanna@in.ibm.com,
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
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919070516.GD23836@in.ibm.com> <451030A6.6040801@google.com> <45105B5E.9080107@opersys.com>
In-Reply-To: <45105B5E.9080107@opersys.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karim,

Karim Yaghmour wrote:
> Martin Bligh wrote:
>> be that many? Still doesn't fix the problem Matieu just pointed
>> out though. Humpf.
> 
> There's one possibility if we're willing to insert a placeholder
> at function entry that allows to essentially do what Andrew
> suggests without much impact. Specifically, if you need a 5-byte
> operation to jump to the alternate instrumented function, you
> can then do something like:

This method is very similar to the djprobe.
And I had gotten the same idea to support preemptive kernel.

> 1- At build time insert 5-byte unconditional jump to instruction
> right after placeholder.

This means the below code, doesn't this?
---
	jmp 1f /* short jump consumes 2 bytes */
	nop
	nop
	nop
1:
---

> 2- At runtime for diverting flow:
>    - Replace first byte with int3 (atomically)
>    - Replace next 4 bytes with instrumented function destination

     - Serialize all processor's cache by using IPI and cpuid.

>    - Replace first byte
> 3- At runtime for returning flow:
>    - Do #2 but for the original placeholder jump.


I think the djprobe can provide most of functionalities which
your idea requires.
I'll update the djprobe against for 2.6.17 or later as soon as
possible. Would you try to use it?

Thanks,

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com





