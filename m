Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWBVVA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWBVVA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWBVVA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:00:27 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:57981 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751455AbWBVVA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:00:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ko6UEncbYpUQyCoZJY/s7q+WuWkUk1nEdFLIVMRnQPhfb0xAWhb9SMiTNJyjEcHnKEiIJUW9sudW7o1wctDOhDIVaSx8snx41BnQuYhnNyKtbr2cZZwb8B3M9nMsotMpBH8KQH6k74l8AhEitLoscusqUvHbkUsYQPr3qWd+ipQ=
Message-ID: <43FCD0DC.1010707@gmail.com>
Date: Wed, 22 Feb 2006 23:00:12 +0200
From: Yoav Etsion <etsman@gmail.com>
Reply-To: etsman@cs.huji.ac.il
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Frank Ch. Eigler" <fche@redhat.com>
CC: linux-kernel@vger.kernel.org, etsman@cs.huji.ac.il
Subject: Re: Static instrumentation, was Re: RFC: klogger: kernel tracing
 and logging tool
References: <43FC8261.9000207@gmail.com> <y0mbqwze1p8.fsf@ton.toronto.redhat.com>
In-Reply-To: <y0mbqwze1p8.fsf@ton.toronto.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank,

You raise two important issues:
1. code markers/annotations for tracing/probing purposes.
2. overhead of the kernel loggers in their inactive state

Of these, I think the first is more important, as it addresses some 
basic defeciency of software development --- getting to know someone 
else's code.
In my experience, writing instrumentation for a kernel subsystem (schema 
in Klogger lingo) requires in depth understanding of the code. This 
sometimes tunnel tremendous efforts towards measurements that could 
otherwise become trivial.

Since no one knows the code like its coder, having developers annotate 
their code using some semi-formal language/definitions (or even compiler 
pragmas) can serve as the best basis for any kernel logger.
Once such markers are in place, the second issue --- overheads (as most 
anything else)--- becomes a technical issue. So even when incurring 
inactive overheads, such a tool can be very useful for developers and 
researchers alike.

After all my babble, the bottom line to the community:
will kernel developers annotate their code? can such policies be instated?

Yoav


Frank Ch. Eigler wrote:
> Yoav Etsion <etsman@gmail.com> writes:
> 
> 
>>[...]  I've developed a kernel logging tool called
>>Klogger: http://www.cs.huji.ac.il/~etsman/klogger
>>In some senses, it is similar to the LTT [...]
> 
> 
> It seems like several projects would benefit from markers being
> inserted into key kernel code paths for purposes of tracing / probing.
> 
> Both LTTng and klogger have macros that expand to largish inline
> function calls that appear to cause a noticeable amount of work even
> for tracing requests are not actually active.  (klogger munges
> interrupts, gets timestamps, before ever testing whether logging was
> requested; lttng similar; icache bloat in both cases.)
> 
> In other words, even in the inactive state, tracing markers like those
> of klogger and ltt impose some performance disruption.  Assuming that
> detailed tracing / probing would be a useful facility to have
> available, are there any other factors that block adoption of such
> markers in official kernels?  In other words, if they could go "fast
> enough", especially in the inactive case, would you start placing them
> into your code?
> 
> 
> - FChE
> 
