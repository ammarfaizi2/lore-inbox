Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbTBNRbd>; Fri, 14 Feb 2003 12:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTBNRbd>; Fri, 14 Feb 2003 12:31:33 -0500
Received: from SMTP7.andrew.cmu.edu ([128.2.10.87]:32157 "EHLO
	smtp7.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S263204AbTBNRbc>; Fri, 14 Feb 2003 12:31:32 -0500
Subject: Re: [PATCH][2.5][4/14] smp_call_function_on_cpu - MIPS
From: Justin Carlson <justinca@cs.cmu.edu>
To: Zwane Mwaikambo <zwane@zwane.ca>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.50.0302140356050.3518-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0302140356050.3518-100000@montezuma.mastecende.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Feb 2003 12:41:06 -0500
Message-Id: <1045244466.1044.13.camel@PISTON.AHS.RI.CMU.EDU>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 04:33, Zwane Mwaikambo wrote:
> +}
> +
> +int smp_call_function (void (*func) (void *info), void *info, int retry, int wait)
> +{
> +	return smp_call_function_on_cpu(func, info, wait, cpu_online_map);
>  }

IIRC, the semantics of smp_call_function() are to call the function on
all other cpus.  So shouldn't this be

	return smp_call_function_on_cpu(func, info, wait, cpu_online_map & ~(1<<smp_processor_id()));

?

Also, maybe you were planning to do this in a future patch, but
shouldn't smp_call_function() be moved to non-arch-specific code, given
this change?

-Justin


