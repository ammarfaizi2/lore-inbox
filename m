Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311585AbSCNLPK>; Thu, 14 Mar 2002 06:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311586AbSCNLPA>; Thu, 14 Mar 2002 06:15:00 -0500
Received: from ns.suse.de ([213.95.15.193]:20485 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311585AbSCNLO5>;
	Thu, 14 Mar 2002 06:14:57 -0500
Date: Thu, 14 Mar 2002 12:14:56 +0100
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
Message-ID: <20020314121456.A15050@wotan.suse.de>
In-Reply-To: <p73bsdrsftu.fsf@oldwotan.suse.de> <E16lT7I-0003uC-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16lT7I-0003uC-00@wagner.rustcorp.com.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 10:09:52PM +1100, Rusty Russell wrote:
> Sorry, I think one macro to get the address, one to get the contents
> is a *horrible* interface.  per_cpu() and per_cpu_ptr() or something?


It is not pretty, but I have no choice. See include/asm-x86_64/pda.h on what I 
have currently. Supporting the address in the same macro would 
double to overhead of accesing it. 

> I think you'll find that per_cpu_ptr would be fairly common, so we're
> forced into a bad interface for little gain.  You might be better off
> using another method to implement per-cpu areas.

Nope, the segment register has to stay for other reasons, and it would
be a shame to not use it for cpu data too.

I don't see it as that bad. Is it really that difficult to write _ptr
if you want the address? You can also write _noptr or _direct or whatever
if you don't want the address if you prefer that, but I want to keep
the option to do direct access even for generic code. 


-Andi
