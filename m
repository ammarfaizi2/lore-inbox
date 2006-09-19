Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWISQP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWISQP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWISQP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:15:28 -0400
Received: from smtp-out.google.com ([216.239.33.17]:23453 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750885AbWISQP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:15:27 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=c8guur0E/TlTatm5+/66176HmiArjh+6ru71VyCEmONgQavlodS/D6UHrB+3fFWRY
	vYiREvUNWb/0cEHbD3PfQ==
Message-ID: <4510175B.7000200@google.com>
Date: Tue, 19 Sep 2006 09:14:19 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vara Prasad <prasadav@us.ibm.com>
CC: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <45101598.7050309@us.ibm.com>
In-Reply-To: <45101598.7050309@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is an interesting idea but there appears to be following hard issues 
> (some of which you have already listed) i am not able to see how we can 
> overcome them
> 
> 1) We are going to have a duplicate of the whole function which means 
> any significant changes in the original function needs to be done on the 
> copy as well, you think maintainers would like this double work idea.

No, no ... the duplicate function isn't duplicated source code, only
object code. Either a config option via the markup macros that we've
been discussing, or something I hack up on the fly to debug a problem
dynamically. In terms of how the debugging-type source code is kept,
it's no different than something like systemtap or LTT (either would
work, and a normal diff could be used to keep out of tree stuff),
it's just how it hooks in is different to kprobes.

> 2) Inline functions is often the place where we need a fast path to 
> overcome the current kprobes overhead.

You can still instrument inline functions, you just need to hook all
the callers, not the inline itself.

> 3) As you said it is not trivial across all the platforms to do a switch 
> to the instrumented function from the original during the execution.  
> This problem is similar to the issue we are dealing with djprobes.

If we just freeze all kernel operations for a split second whilst we do
this, does it matter? Or even if we don't ... there's a brief race where
some calls are traced, and some are not ... does that even matter?
Doesn't seem like most usages would care.

M.

