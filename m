Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264565AbSIQU5g>; Tue, 17 Sep 2002 16:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264568AbSIQU5g>; Tue, 17 Sep 2002 16:57:36 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:21132 "EHLO
	e33.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id <S264565AbSIQU5d>; Tue, 17 Sep 2002 16:57:33 -0400
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
From: john stultz <johnstul@us.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: anton.wilson@camotion.com, lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>
In-Reply-To: <20020917.133933.69057655.davem@redhat.com>
References: <200209172020.g8HKKPF13227@eng2.beaverton.ibm.com>
	<1032294559.22815.180.camel@cog> 
	<20020917.133933.69057655.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Sep 2002 13:57:13 -0700
Message-Id: <1032296233.22815.192.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 13:39, David S. Miller wrote:
>    From: john stultz <johnstul@us.ibm.com>
>    Date: 17 Sep 2002 13:29:18 -0700
>    
>    Some NUMA boxes do not have synced TSC, so on those systems your
>    code won't work.
> 
> It would have been really nice if x86 had specified a "system tick"
> register that incremented based upon the system bus cycles and thus
> were immune the processor rates.

Some systems do, if I'm understanding you properly. Summit based boxes
have an on-chipset performance counter that runs at 100Mhz. My
cyclone-timer patch uses this as a gettimeofday/__delay time source in
the 2.4 kernel. Additionally George Anzinger has patches that allow the
ACPI PM timer to be used as well. Intel's HPET should also provide
another time source.
 
> I foresee lots of patches coming which basically are "how does this
> x86 system provide a stable synchronized tick source".

True, but hopefully my timer-changes patch will allow for better
abstraction around these varied time sources, so one won't really need
to know how all of these different sources work. 

thanks
-john




