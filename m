Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWITTXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWITTXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWITTXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:23:16 -0400
Received: from smtp-out.google.com ([216.239.45.12]:64990 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932293AbWITTXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:23:15 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=hk4UswgLsLqANX038NTgQ10e6kCBVlDZF0vGO0KjDDkOnjyzUcQU37AIIJsJa4Ujo
	wRC1lIwrqi1844aTHbptQ==
Message-ID: <451194DA.40300@google.com>
Date: Wed, 20 Sep 2006 12:22:02 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: karim@opersys.com
CC: "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
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
References: <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919070516.GD23836@in.ibm.com> <451030A6.6040801@google.com> <45105B5E.9080107@opersys.com> <451141B1.40803@hitachi.com> <451178B0.9030205@opersys.com> <20060920180808.GI18646@redhat.com> <451186F2.3060702@google.com> <45118D63.8070604@opersys.com>
In-Reply-To: <45118D63.8070604@opersys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Martin Bligh wrote:
> 
>>It's looking to me like it might still need djprobes to implement, in
>>order to get the atomic and safe switchover from the original function
>>into the traced one. All rather sad, but seems to be true from all the
>>CPU errata, etc. If anyone can see a way round that, I'd love to hear
>>it.
> 
> 
> But we don't need to fight the errata, there are fortunately solutions
> that take care of it where it does exist (x86: djprobes/kprobes.)
> What's more interesting, though, is that the method as it is proposed
> at this stage *seems* to be easily portable to other archs. And where
> such binary trickery is difficult to pull off, nothing precludes
> having a universally "portable" mechanism including something akin to
> switching between instrumented vs. normal function at function entry.
> Even such conditional ifs can be optimized by the CPU nowadays.
> 
> The picture is, nevertheless, very bright at the moment (I think).
> Just have a 5byte filler at function entry such as Hiramatsu-san
> suggested, and use djprobes to fork to instrumented function. The
> unconditional jump in the filler will most likely be utterly
> unmeasurable, and benchmarks should confirm this.
> 
> So:
> On x86: use 5byte filler and djprobes.
> On "sane" archs: use filler and override as explained earlier.
> Elsewhere: use standard "if" or function pointer at function entry.

Do we even need the filler padding? I thought we could insert kprobes
at the beginning of any function without that ... it was only a
requirement for mid-function (sometimes). If we copy the whole function,
we don't even need that any more ...

if kprobes can do it, I don't see why djprobes can't ... after all, it
just seems to use kprobes to insert a jump, AFAICS.

M.

