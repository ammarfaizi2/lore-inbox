Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317464AbSGZK23>; Fri, 26 Jul 2002 06:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSGZK23>; Fri, 26 Jul 2002 06:28:29 -0400
Received: from [195.39.17.254] ([195.39.17.254]:9344 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317464AbSGZK21>;
	Fri, 26 Jul 2002 06:28:27 -0400
Date: Fri, 26 Jul 2002 12:31:04 +0200
From: Pavel Machek <pavel@elf.ucw.cz>
To: Robert Love <rml@tech9.net>
Cc: akpm@zip.com.au, riel@conectiva.com.br, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5-rmap: VM strict overcommit
Message-ID: <20020726103104.GA279@elf.ucw.cz>
References: <1026928763.1116.11.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026928763.1116.11.camel@sinai>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> diff -urN linux-2.5.26-rmap/Documentation/vm/overcommit-accounting linux/Documentation/vm/overcommit-accounting
> --- linux-2.5.26-rmap/Documentation/vm/overcommit-accounting	Wed Dec 31 16:00:00 1969
> +++ linux/Documentation/vm/overcommit-accounting	Wed Jul 17 10:45:47 2002
> @@ -0,0 +1,77 @@
> +The Linux kernel supports four overcommit handling modes
> +
> +0	-	Heuristic overcommit handling. Obvious overcommits of
> +		address space are refused. Used for a typical system. It
> +		ensures a seriously wild allocation fails while allowing
> +		overcommit to reduce swap usage.  This is the default.
> +
> +1	-	No overcommit handling. Appropriate for some scientific
> +		applications.
> +
> +2	-	(NEW) swapless strict overcommit. The total address space
> +		commit for the system is not permitted to exceed 95% of
> +		free memory. This mode utilizes the new stricter accounting
> +		but does not impose a very strict rule.  It is possible that
> +		the system could kill a process accessing pages in certain
> +		cases.  If mode 3 is too strict when no swap is	present
> +		this is the best you can do.
> +
> +3	-	(NEW) strict overcommit. The total address space commit
> +		for the system is not permitted to exceed swap + half ram.
> +		In almost all situations this means a process will not be
> +		killed while accessing pages but only by malloc failures
> +		that are reported back by the kernel mmap/brk code.

In what scenario can "strict overcommit" kill?

> +4	-	(NEW) paranoid overcommit. The total address space commit
> +		for the system is not permitted to exceed swap. The machine
> +		will never kill a process accessing pages it has mapped
> +		except due to a bug (ie report it!).

...and why is that scenario impossible on "paranoid overcommit"?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
