Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTLLWKW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTLLWKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:10:22 -0500
Received: from gprs149-168.eurotel.cz ([160.218.149.168]:62593 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262056AbTLLWKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:10:18 -0500
Date: Fri, 12 Dec 2003 23:10:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing HZ (patch for HZ > 1000)
Message-ID: <20031212221045.GB314@elf.ucw.cz>
References: <1071122742.5149.12.camel@idefix.homelinux.org> <1288980000.1071126438@[10.10.2.4]> <1071216053.4187.22.camel@idefix.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071216053.4187.22.camel@idefix.homelinux.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Just one more thing about the patch I sent. I think it addresses
> something unclean in the bogomips computation. For example, in
> arch/i386/kernel/cpu/proc.c, you have:
> 
> seq_printf(m, "\nbogomips\t: %lu.%02lu\n\n",
>            c->loops_per_jiffy/(500000/HZ),
>            (c->loops_per_jiffy/(5000/HZ)) % 100);
> 
> It's clear that for any case where 5000/HZ is not an integer, the
> bogomips decimals will be wrong and if 500000/HZ isn't an integer, the
> bogomips integer part will be wrong.
> 
> For example on a 2 GHz processor with a 4000 bogomips value and HZ=1200,
> the code above will produce 3996.66 instead of 4000. Of course, as soon
> as HZ goes above 5000, you have a divide by zero right at compile time.

Well, on i386 we only run with HZ=100 and HZ=1000, so bug is latent,
but if you can find nice way to rewrite it without the bug, it would
probably be worth fixing.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
