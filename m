Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbSJXPeb>; Thu, 24 Oct 2002 11:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265510AbSJXPea>; Thu, 24 Oct 2002 11:34:30 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:34953 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265508AbSJXPea>; Thu, 24 Oct 2002 11:34:30 -0400
Date: Thu, 24 Oct 2002 21:16:33 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: maneesh@in.ibm.com, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [long]2.5.44-mm3 UP went into unexpected trashing
Message-ID: <20021024211633.A21583@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <3DB7A581.9214EFCC@aitel.hist.no> <3DB7A80C.7D13C750@digeo.com> <3DB7AC97.D31A3CB2@digeo.com> <20021024171528.D5311@in.ibm.com> <20021024114740.78FD37CD3@oscar.casa.dyndns.org> <20021024180809.D11418@in.ibm.com> <20021024210105.A20822@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021024210105.A20822@in.ibm.com>; from dipankar@in.ibm.com on Thu, Oct 24, 2002 at 09:01:05PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 09:01:05PM +0530, Dipankar Sarma wrote:
> OK, I think I know why this one didn't work.
> 
> If the bit_mask is 0, find_first_bit() returns 32 or BITS_PER_LONG.
> That works fine as long as NR_CPUS is 32, but when it isn't things
> are broken.
> 
>     (find_first_bit(rcu_ctrlblk.rcu_cpu_mask, NR_CPUS) != BITS_PER_LONG)) {
> 		return;
> 
> should probably work here.
> 
> I guess we need to audit all bitmask tests and fix them to check for
> the right value. 

Argh!! I spoke too soon.

AFAICS, find_first_bit() needs to be fixed to return "size" if the
bitmask is all zeros.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
