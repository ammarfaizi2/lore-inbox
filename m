Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWITJnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWITJnV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 05:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWITJnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 05:43:21 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:64950 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750875AbWITJnV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 05:43:21 -0400
Message-ID: <45110C6B.6010909@aitel.hist.no>
Date: Wed, 20 Sep 2006 11:39:55 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: prasanna@in.ibm.com
CC: Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
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
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com>
In-Reply-To: <20060919063821.GB23836@in.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

S. P. Prasanna wrote:
>>
>> Yes, that's simple. but slower, as you have a double jump. Probably
>> a damned sight faster than int3 though.
>>
>> M.
>>     
>
> The advantage of using int3 over jmp to launch the instrumented
> module is that int3 (or breakpoint in most architectures) is an
> atomic operation to insert.
>   
Yes, 5 bytes is not an atomic write except on 64-bit. So a race is possible.

How about this workaround:
1. Overwrite the start of the function with a hlt, which is atomic.
2. Write that 5-byte jump after the hlt.
3. Overwrite the hlt with nop so things will work
4. interrupt any cpus that got stuck on the hlt - or just wait for the 
timer.

Helge Hafting

