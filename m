Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265416AbSJSATE>; Fri, 18 Oct 2002 20:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265417AbSJSATD>; Fri, 18 Oct 2002 20:19:03 -0400
Received: from ns.suse.de ([213.95.15.193]:42253 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265416AbSJSATB>;
	Fri, 18 Oct 2002 20:19:01 -0400
Date: Sat, 19 Oct 2002 02:25:02 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, jun.nakajima@intel.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, asit.k.mallick@intel.com,
       sunil.saxena@intel.com
Subject: Re: [PATCH] fixes for building kernel using Intel compiler
Message-ID: <20021019022502.B18201@wotan.suse.de>
References: <F2DBA543B89AD51184B600508B68D4000E6ADE5B@fmsmsx103.fm.intel.com.suse.lists.linux.kernel> <p73u1jjnvea.fsf@oldwotan.suse.de> <20021018.171504.96943359.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021018.171504.96943359.davem@redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 05:15:04PM -0700, David S. Miller wrote:
>    From: Andi Kleen <ak@suse.de>
>    Date: 19 Oct 2002 02:07:41 +0200
>    
>    > -/* Enable FXSR and company _before_ testing for FP problems. */
>    > -       /*
>    > -        * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
>    > -        */
>    > -       if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
>    > -               extern void __buggy_fxsr_alignment(void);
>    > -               __buggy_fxsr_alignment();
>    > -       }
>    
>    Why does that not work? IMHO it is legal ISO-C
> 
> Depending upon the compiler to optimize away the non-existent function
> reference is not ISO-C :-)  Although the fact the Intel compiler isn't
> doing this is amusing.

True :-)

Well it should. There are tons of similar patterns all over the kernel
which use the same trick.
If it didn't optimize  all of these, there would be many more problems.

-Andi
