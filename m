Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261288AbSJ1PGI>; Mon, 28 Oct 2002 10:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbSJ1PGI>; Mon, 28 Oct 2002 10:06:08 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:40860 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S261288AbSJ1PGG>;
	Mon, 28 Oct 2002 10:06:06 -0500
Date: Mon, 28 Oct 2002 16:12:20 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: New csum and csum_copy routines - and a test/benchmark program
Message-ID: <20021028151220.GA1521@werewolf.able.es>
References: <200210280819.g9S8Jfp25782@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200210280819.g9S8Jfp25782@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Mon, Oct 28, 2002 at 14:12:01 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.28 Denis Vlasenko wrote:
>
>Duron 650
>=========
>csum tests:
>                     kernel_csum - took  2612 max, 1887 min cycles per kb. sum=0xfad28968
>                     kernel_csum - took  2654 max, 1887 min cycles per kb. sum=0xfad28968
>                     kernel_csum - took  2105 max, 1887 min cycles per kb. sum=0xfad28968
>                    kernel2_csum - took  2636 max, 1925 min cycles per kb. sum=0xfad28968
>                  kernelpii_csum - took 11879 max, 1735 min cycles per kb. sum=0xaeffd53b
>                kernelpiipf_csum - took  2565 max, 1642 min cycles per kb. sum=0xaeffd53b
>copy tests:
>                     kernel_copy - took  5812 max, 4854 min cycles per kb. sum=0xfad28968
>                     kernel_copy - took  5741 max, 4854 min cycles per kb. sum=0xfad28968
>                     kernel_copy - took 17680 max, 4859 min cycles per kb. sum=0xfad28968
>                  kernelpii_copy - took  7204 max, 6381 min cycles per kb. sum=0xe3bca07e
>                kernelpiipf_copy - took  8429 max, 7477 min cycles per kb. sum=0xe3bca07e
>
>Celeron 1200
>============
>csum tests:
>                     kernel_csum - took  7368 max, 6833 min cycles per kb. sum=0x291132e0
>                     kernel_csum - took  9038 max, 6845 min cycles per kb. sum=0x291132e0
>                     kernel_csum - took  7112 max, 6836 min cycles per kb. sum=0x291132e0
>                    kernel2_csum - took  7254 max, 6871 min cycles per kb. sum=0x291132e0
>                  kernelpii_csum - took  4696 max, 4109 min cycles per kb. sum=0x484713aa
>                kernelpiipf_csum - took  4715 max, 4271 min cycles per kb. sum=0x484713aa
>copy tests:
>                     kernel_copy - took 13927 max,13450 min cycles per kb. sum=0x291132e0
>                     kernel_copy - took 14009 max,13406 min cycles per kb. sum=0x291132e0
>                     kernel_copy - took 13957 max,13447 min cycles per kb. sum=0x291132e0
>                  kernelpii_copy - took 15039 max,11335 min cycles per kb. sum=0x5474077d
>                kernelpiipf_copy - took 14137 max,13059 min cycles per kb. sum=0x5474077d

Ejem, I have read your comment about not posting results, but can really a PII
do this:

Pentium2 400, 512Kb cache
=========================
Csum benchmark program
buffer size: 4 Mb
Each test tried 32 times, max and min CPU cycles are reported.
Please disregard max values. They are due to system interference only.
csum tests:
                     kernel_csum - took  2586 max, 2541 min cycles per kb. sum=0x7a86335d
                     kernel_csum - took  2566 max, 2541 min cycles per kb. sum=0x7a86335d
                     kernel_csum - took  2703 max, 2541 min cycles per kb. sum=0x7a86335d
                    kernel2_csum - took  2890 max, 2556 min cycles per kb. sum=0x7a86335d
                  kernelpii_csum - took  1682 max, 1494 min cycles per kb. sum=0x993114b2
                kernelpiipf_csum - took  1688 max, 1493 min cycles per kb. sum=0x993114b2
                        kpf_csum - took  1742 max, 1703 min cycles per kb. sum=0xf3500fff
                        kpf_csum - took  1805 max, 1747 min cycles per kb. sum=0xf3500fff
                        kpf_csum - took  1746 max, 1703 min cycles per kb. sum=0xf3500fff
                        kpf_csum - took  1777 max, 1747 min cycles per kb. sum=0xf3500fff
copy tests:
                     kernel_copy - took  4507 max, 4306 min cycles per kb. sum=0x7a86335d
                     kernel_copy - took  4704 max, 4306 min cycles per kb. sum=0x7a86335d
                     kernel_copy - took  4833 max, 4306 min cycles per kb. sum=0x7a86335d
                  kernelpii_copy - took  3688 max, 3504 min cycles per kb. sum=0xa3cf0a14
                kernelpiipf_copy - took  4961 max, 4516 min cycles per kb. sum=0xa3cf0a14
Done

I had to set empty prefetch in kpf_csum. 
I can't run kpf_copy benchmarks, they crash even with empty prefetch.
Do they contain PIII specific code ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre11-jam2 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
