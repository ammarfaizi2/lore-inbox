Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267340AbRGKPzx>; Wed, 11 Jul 2001 11:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267339AbRGKPzn>; Wed, 11 Jul 2001 11:55:43 -0400
Received: from zeke.inet.com ([199.171.211.198]:9384 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S267338AbRGKPz3>;
	Wed, 11 Jul 2001 11:55:29 -0400
Message-ID: <3B4C7615.FADBF9A3@inet.com>
Date: Wed, 11 Jul 2001 10:51:49 -0500
From: "Jordan Breeding" <jordan.breeding@inet.com>
Reply-To: Jordan <ledzep37@home.com>,
        Jordan Breeding <jordan.breeding@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Hugh Dickins <hugh@veritas.com>, Jordan <ledzep37@home.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: Re: Discrepancies between /proc/cpuinfo and Dave J's x86info
In-Reply-To: <Pine.LNX.4.30.0107111421300.2003-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Wed, 11 Jul 2001, Hugh Dickins wrote:
> 
> > As others have said, cpuid level 3 corresponds to Processor Serial
> > Number enabled.  I think what you have here is a machine on which
> > the BIOS has disabled PSN on the first CPU, but left it enabled on the
> > second CPU, and so the kernel has then disabled it on the second CPU.
> 
> I'll bet that's exactly what it is. Good work.
> 
> This patch (against 247pre6) should keep the cpuinfo in sync with the real
> state of the CPU..
> 
> regards,
> 
> Dave.
> 
> --
> | Dave Jones.        http://www.suse.de/~davej
> | SuSE Labs
> 
> diff -urN --exclude-from=/home/davej/.exclude linux-247pre7/arch/i386/kernel/setup.c linux-dj/arch/i386/kernel/setup.c
> --- linux-247pre7/arch/i386/kernel/setup.c      Wed Jul 11 13:16:10 2001
> +++ linux-dj/arch/i386/kernel/setup.c   Wed Jul 11 13:18:27 2001
> @@ -1994,6 +1994,7 @@
>                 wrmsr(0x119,lo,hi);
>                 printk(KERN_NOTICE "CPU serial number disabled.\n");
>                 clear_bit(X86_FEATURE_PN, &c->x86_capability);
> +               c->cpuid_level--;
>         }
>  }

It does keep everything in sync here.  Thanks for the help.

Jordan
