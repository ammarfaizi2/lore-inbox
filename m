Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWCSA4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWCSA4n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 19:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWCSA4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 19:56:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17859 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750941AbWCSA4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 19:56:43 -0500
Date: Sat, 18 Mar 2006 16:53:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: kernel-stuff@comcast.net, linux-kernel@vger.kernel.org,
       alex-kernel@digriz.org.uk, jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Message-Id: <20060318165302.62851448.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
	<Pine.LNX.4.64.0603181321310.3826@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
>  Gaah. Looking at the assembly code to try to figure out where the oops 
>  happened, one thing is clear: "for_each_cpu_mask()" generates some truly 
>  horrible code. C code that looks simple ends up being tons of complex 
>  assembly language due to inline functions etc.
> 
>  We've made it way too easy for people to write code that just absolutely 
>  _sucks_.

Yes, uninlining merely first_cpu() shrinks my usual vmlinux by 2.5k.  I'll
fix it up.

Meanwhile, I suppose we need to check that pointer for NULL as Parag
suggests.  I might stick a once-off WARN_ON() in there so someone gets in
and works out why we keep on having to graft mysterious null-pointer
avoidances into cpufreq.

