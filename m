Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266742AbUGLGn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266742AbUGLGn6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 02:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266743AbUGLGn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 02:43:58 -0400
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:45972 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266742AbUGLGnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 02:43:55 -0400
References: <cone.1089613755.742689.28499.502@pc.kolivas.org> <20040711233750.2050c4b1.akpm@osdl.org>
Message-ID: <cone.1089614621.957671.28499.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Instrumenting high latency
Date: Mon, 12 Jul 2004 16:43:41 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Con Kolivas <kernel@kolivas.org> wrote:
>>
>> Because of the recent discussion about latency in the kernel I asked William 
>> Lee Irwin III to help create some instrumentation to determine where in the 
>> kernel there were still sustained periods of non-preemptible code. He hacked 
>> together this simple patch which times periods according to the preempt 
>> count.
> 
> Looks sane.
> 
>> The patch appears to require CONFIG_PREEMPT enabled on uniprocessor and is 
>> i386 only at the moment.
> 
> Not sure what you mean by "on uniprocessor"?  AFAICT the patch will work
> as-is on uniprocessor and on SMP.  Looks like it'll work with
> CONFIG_PREEMPT=n, too, although that would be a slightly bizarre thing to

That was WLI's aim, but I had one user report an OOPS with that combination.

> do.
> 
> +				print_symbol("%s\n",
> +					__get_cpu_var(preempt_exit));
> 
> I'll change this to
> 
> 				print_symbol("%s",
> 					__get_cpu_var(preempt_exit));
> 				printk("\n");
> 
> so it doesn't make a mess with CONFIG_KALLSYMS=n.

Ok 

It's not heavily tested but ran for a day on my box at home. It can trip 
over itself saying that it's own code paths are a problem too if it gets 
real busy.

Cheers,
Con

