Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274362AbRJEXHq>; Fri, 5 Oct 2001 19:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274368AbRJEXHh>; Fri, 5 Oct 2001 19:07:37 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:4999 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S274362AbRJEXH2>; Fri, 5 Oct 2001 19:07:28 -0400
Message-ID: <3BBE3DD4.27DFFDCE@oracle.com>
Date: Sat, 06 Oct 2001 01:10:12 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.11-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Dan Merillat <harik@chaos.ao.net>, linux-kernel@vger.kernel.org
Subject: Re: Wierd /proc/cpuinfo with 2.4.11-pre4
In-Reply-To: <1566531237.1002293911@mbligh.des.sequent.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> >> Wow!  That's pretty impressive, a new kernel build gives me an
> >> additional _7_ CPUs!
> 
> Sorry. Mea culpa
> 
> --- setup.c.old Fri Oct  5 14:20:29 2001
> +++ setup.c     Fri Oct  5 14:28:51 2001
> @@ -2420,7 +2420,7 @@
>          * WARNING - nasty evil hack ... if we print > 8, it overflows the
>          * page buffer and corrupts memory - this needs fixing properly
>          */
> -       for (n = 0; n < 8; n++, c++) {
> +       for (n = 0; n < (clustered_apic_mode ? 8 : NR_CPUS); n++, c++) {
>         /* for (n = 0; n < NR_CPUS; n++, c++) { */
>                 int fpu_exception;
>  #ifdef CONFIG_SMP
> 
> M.
> 
> PS. I just tested this since my last post. It seems to work.

Doesn't build here...

gcc -D__KERNEL__ -I/share/src/linux-2.4.11-pre4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o setup.o setup.c
setup.c: In function `get_cpuinfo':
setup.c:2423: `clustered_apic_mode' undeclared (first use in this function)
setup.c:2423: (Each undeclared identifier is reported only once
setup.c:2423: for each function it appears in.)
make[1]: *** [setup.o] Error 1
make[1]: Leaving directory `/share/src/linux-2.4.11-pre4/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

--alessandro

 "this is no time to get cute, it's a mad dog's promenade
  so walk tall, or baby don't walk at all"
                (Bruce Springsteen, 'New York City Serenade')
