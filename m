Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUB0W6K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263180AbUB0W4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:56:23 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:19185 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263178AbUB0WyC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:54:02 -0500
Message-ID: <403FCA7D.5040607@mvista.com>
Date: Fri, 27 Feb 2004 14:53:49 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, "Amit S. Kale" <amitkale@emsyssoft.com>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][7/7] Move debugger_entry()
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227212548.GD1052@smtp.west.cox.net> <20040227213254.GE1052@smtp.west.cox.net> <20040227214031.GF1052@smtp.west.cox.net> <20040227214605.GH1052@smtp.west.cox.net> <20040227215211.GI1052@smtp.west.cox.net> <20040227215428.GJ1052@smtp.west.cox.net>
In-Reply-To: <20040227215428.GJ1052@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> Hello.  When we use kgdboe, we can't use it until do_basic_setup() is done.
> So we have two options, not allow kgdboe to use the initial breakpoint
> or move debugger_entry() to be past the point where kgdboe will be usable.
> I've opted for the latter, as if an earlier breakpoint is needed you can
> still use serial and throw kgdb_schedule_breakpoint/breakpoint where desired.

Please don't do this.  How about configuring it along with the connection 
method.  I really don't want to have to modify the kernel just to get in early.

George
> 
> --- linux-2.6.3-rc4/init/main.c	2004-02-17 09:51:19.000000000 -0700
> +++ linux-2.6.3-rc4-kgdb/init/main.c	2004-02-17 11:33:51.854388988 -0700
> @@ -581,6 +582,7 @@ static int init(void * unused)
>  
>  	smp_init();
>  	do_basic_setup();
> +	debugger_entry();
>  
>  	prepare_namespace();
>  
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

