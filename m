Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311731AbSCNSvs>; Thu, 14 Mar 2002 13:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311732AbSCNSvj>; Thu, 14 Mar 2002 13:51:39 -0500
Received: from ns.suse.de ([213.95.15.193]:49928 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311731AbSCNSv0>;
	Thu, 14 Mar 2002 13:51:26 -0500
Date: Thu, 14 Mar 2002 19:51:22 +0100
From: Andi Kleen <ak@suse.de>
To: davidm@hpl.hp.com
Cc: Andi Kleen <ak@suse.de>, Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com, rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
Message-ID: <20020314195122.A30566@wotan.suse.de>
In-Reply-To: <15504.7958.677592.908691@napali.hpl.hp.com.suse.lists.linux.kernel> <E16lMzi-0002bb-00@wagner.rustcorp.com.au.suse.lists.linux.kernel> <p73bsdrsftu.fsf@oldwotan.suse.de> <15504.58901.82038.420706@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15504.58901.82038.420706@napali.hpl.hp.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 10:04:05AM -0800, David Mosberger wrote:
> How about the following proposal:
> 
> 	- taking the address of this_cpu(var) is never allowed (can be
>           enforced with RELOC_HIDE())
> 
> 	- taking the address of per_cpu(var, n) is always legal and
> 	  will return a pointer which will access CPU n's version of
> 	  the variable, no matter what CPU dereferences the pointer
> 
> Andi, I think this would take care of the x86-64 problem as well, right?

Yes, it would. 

It would be a bit more overhead for taking the address than a 
this_cpu_address(), because one would need to fetch the CPU number first
and do the arithmetic and the array reference instead of fetching the 
address directly. But I agree that per_cpu() has much cleaner semantics than
this_cpu_address() for addresses, so it is worth it.

When one considers preemptive kernels where you can lose your CPU anytime
then it makes even more sense. But then this_cpu is only safe there when
you turn off preemption or hold some lock or run in interrupt context.
Outside such regions per_cpu() seems to be safer. 

Thanks, 
-Andi
