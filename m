Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbTAUGG4>; Tue, 21 Jan 2003 01:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbTAUGG4>; Tue, 21 Jan 2003 01:06:56 -0500
Received: from dhcp34.trinity.linux.conf.au ([130.95.169.34]:11648 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S263837AbTAUGGz>; Tue, 21 Jan 2003 01:06:55 -0500
Subject: Re: [PATCH][2.5] smp_call_function_mask
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0301170014230.24250-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0301170014230.24250-100000@montezuma.mastecende.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043104744.12609.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 20 Jan 2003 23:19:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-17 at 05:18, Zwane Mwaikambo wrote:
> +	/* Wait for response */
> +	while (atomic_read(&data.started) != num_cpus)
> +		barrier();

Only old old intel x86 that does -bad- things as it
generates a lot of bus locked cycles. Better to do

	while(atomic_read(&data.started) != num_cpus)
		while(data.started.value != num_cpus)
		{
			barrier();
			cpu_relax();
		}

I would think ?

