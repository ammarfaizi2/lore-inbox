Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274530AbRJEXWH>; Fri, 5 Oct 2001 19:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274520AbRJEXVq>; Fri, 5 Oct 2001 19:21:46 -0400
Received: from femail28.sdc1.sfba.home.com ([24.254.60.18]:10201 "EHLO
	femail28.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274513AbRJEXVm>; Fri, 5 Oct 2001 19:21:42 -0400
Message-ID: <3BBE3F7D.621B727C@didntduck.org>
Date: Fri, 05 Oct 2001 19:17:17 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Alessandro Suardi <alessandro.suardi@oracle.com>,
        Dan Merillat <harik@chaos.ao.net>, linux-kernel@vger.kernel.org
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

It would be more appropriate to do:
	for (n = 0; n < min(8, NR_CPUS); n++, c++) {

-- 

						Brian Gerst
