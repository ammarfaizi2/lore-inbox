Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261299AbSJYHmI>; Fri, 25 Oct 2002 03:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261300AbSJYHmI>; Fri, 25 Oct 2002 03:42:08 -0400
Received: from sun.fadata.bg ([80.72.64.67]:46737 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S261299AbSJYHmH>;
	Fri, 25 Oct 2002 03:42:07 -0400
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Russell King <rmk@arm.linux.org.uk>,
       Roy Sigurd Karlsbakk <roy@karlsbakk.net>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       libc-alpha@sources.redhat.com
Subject: Re: Csum and csum copyroutines benchmark
References: <200210231218.18733.roy@karlsbakk.net>
	<20021024125030.A7529@flint.arm.linux.org.uk>
	<200210241249.g9OCnOp09750@Port.imtp.ilyichevsk.odessa.ua>
	<200210250643.g9P6hop13980@Port.imtp.ilyichevsk.odessa.ua>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <200210250643.g9P6hop13980@Port.imtp.ilyichevsk.odessa.ua>
Date: 25 Oct 2002 10:48:10 +0300
Message-ID: <87n0p3x8lh.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Denis" == Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:

Denis> /me said:
>> I'm experimenting with different csum_ routines in userspace now.

Denis> Short conclusion: 
Denis> 1. It is possible to speed up csum routines for AMD processors by 30%.
Denis> 2. It is possible to speed up csum_copy routines for both AMD and Intel
Denis>    three times or more. Roy, do you like that? ;)

Additional data point:

Short summary:
1. Checksum - kernelpii_csum is ~19% faster
2. Copy - lernelpii_csum is ~6% faster

Dual Pentium III, 1266Mhz, 512K cache, 2G SDRAM (133Mhz, ECC)

The only changes I made were to decrease the buffer size to 1K (as I
think this is more representative to a network packet size, correct me
if I'm wrong) and increase the runs to 1024. Max values are worthless
indeed.


Csum benchmark program
buffer size: 1 K
Each test tried 1024 times, max and min CPU cycles are reported.
Please disregard max values. They are due to system interference only.
csum tests:
                     kernel_csum - took   941 max,  740 min cycles per kb. sum=0x44000077
                     kernel_csum - took   748 max,  742 min cycles per kb. sum=0x44000077
                     kernel_csum - took 60559 max,  742 min cycles per kb. sum=0x44000077
                  kernelpii_csum - took 52804 max,  601 min cycles per kb. sum=0x44000077
                kernelpiipf_csum - took 12930 max,  601 min cycles per kb. sum=0x44000077
                        pfm_csum - took 10161 max, 1402 min cycles per kb. sum=0x44000077
                       pfm2_csum - took   864 max,  838 min cycles per kb. sum=0x44000077
copy tests:
                     kernel_copy - took   339 max,  239 min cycles per kb. sum=0x44000077
                     kernel_copy - took   239 max,  239 min cycles per kb. sum=0x44000077
                     kernel_copy - took   239 max,  239 min cycles per kb. sum=0x44000077
                  kernelpii_copy - took   244 max,  225 min cycles per kb. sum=0x44000077
                      ntqpf_copy - took 10867 max,  512 min cycles per kb. sum=0x44000077
                     ntqpfm_copy - took   710 max,  403 min cycles per kb. sum=0x44000077
                        ntq_copy - took  4535 max,  443 min cycles per kb. sum=0x44000077
                     ntqpf2_copy - took   563 max,  555 min cycles per kb. sum=0x44000077
Done


HOWEVER ...

sometimes (say 1/30) I get the following output:

Csum benchmark program
buffer size: 1 K
Each test tried 1024 times, max and min CPU cycles are reported.
Please disregard max values. They are due to system interference only.
csum tests:
                     kernel_csum - took   958 max,  740 min cycles per kb. sum=0x44000077
                     kernel_csum - took   748 max,  740 min cycles per kb. sum=0x44000077
                     kernel_csum - took   752 max,  740 min cycles per kb. sum=0x44000077
                  kernelpii_csum - took   624 max,  600 min cycles per kb. sum=0x44000077
                kernelpiipf_csum - took 877211 max,  601 min cycles per kb. sum=0x44000077
Bad sum
Aborted

which is to say that pfm_csum and pfm2_csum results are not to be
trusted (at least on PIII (or my kernel CONFIG_MPENTIUMIII=y
config?)).

~velco
