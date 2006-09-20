Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWITSYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWITSYh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWITSYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:24:37 -0400
Received: from smtp-out.google.com ([216.239.45.12]:63692 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932204AbWITSYf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:24:35 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=NC2VIvIixoBtXgEYt8DUHJ6Dxb2k6OXLZTMDZ35DS/lhlIcX/qtinh8tf1eHIBcGk
	Q8dPDsJQAS5HnTgMWtRfA==
Message-ID: <451186F2.3060702@google.com>
Date: Wed, 20 Sep 2006 11:22:42 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Frank Ch. Eigler" <fche@redhat.com>
CC: Karim Yaghmour <karim@opersys.com>,
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
References: <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919070516.GD23836@in.ibm.com> <451030A6.6040801@google.com> <45105B5E.9080107@opersys.com> <451141B1.40803@hitachi.com> <451178B0.9030205@opersys.com> <20060920180808.GI18646@redhat.com>
In-Reply-To: <20060920180808.GI18646@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Ch. Eigler wrote:
> Hi -
> 
> On Wed, Sep 20, 2006 at 01:21:52PM -0400, Karim Yaghmour wrote:
> 
> 
>>[...]  IOW, we should be able to do what Martin suggests fairly
>>easily (if we agree on a 5-byte "null" jump at the entry of
>>functions of interest). Right? [...]
> 
> 
> My interpretation of Martin's Monday proposal is that, if implemented,
> we wouldn't need any of this nop/int3 stuff.  If function being
> instrumented were recompiled on-the-fly, then it could sport plain &
> direct C-level calls to the instrumentation handlers.

It's looking to me like it might still need djprobes to implement, in
order to get the atomic and safe switchover from the original function
into the traced one. All rather sad, but seems to be true from all the
CPU errata, etc. If anyone can see a way round that, I'd love to hear
it.

What it would give you above and beyond djprobes is an easier and more
flexible way to actually do the instrumentation itself.

M.
