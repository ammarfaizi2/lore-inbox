Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265429AbSJSAjL>; Fri, 18 Oct 2002 20:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265431AbSJSAjL>; Fri, 18 Oct 2002 20:39:11 -0400
Received: from fmr01.intel.com ([192.55.52.18]:23254 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265429AbSJSAjI>;
	Fri, 18 Oct 2002 20:39:08 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000E6ADE6B@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: RE: [PATCH] fixes for building kernel using Intel compiler
Date: Fri, 18 Oct 2002 17:45:08 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, it removes most of such cases. It happens only for a general boolean
controlling expression, and this is the only spot as far as we tested. But
our argument is that the checking code is not required because
thread.i387.fxsave is __attribute__ ((aligned (16))). If __attribute__
((aligned (...))) is broken, we should see more problems.

Thanks,
Jun

-----Original Message-----
From: Andi Kleen [mailto:ak@suse.de]
Sent: Friday, October 18, 2002 5:25 PM
To: David S. Miller
Cc: ak@suse.de; jun.nakajima@intel.com; torvalds@transmeta.com;
linux-kernel@vger.kernel.org; asit.k.mallick@intel.com;
sunil.saxena@intel.com
Subject: Re: [PATCH] fixes for building kernel using Intel compiler


On Fri, Oct 18, 2002 at 05:15:04PM -0700, David S. Miller wrote:
>    From: Andi Kleen <ak@suse.de>
>    Date: 19 Oct 2002 02:07:41 +0200
>    
>    > -/* Enable FXSR and company _before_ testing for FP problems. */
>    > -       /*
>    > -        * Verify that the FXSAVE/FXRSTOR data will be 16-byte
aligned.
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
