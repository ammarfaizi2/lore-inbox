Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSE2Wod>; Wed, 29 May 2002 18:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315629AbSE2Woc>; Wed, 29 May 2002 18:44:32 -0400
Received: from jalon.able.es ([212.97.163.2]:32215 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315628AbSE2Wo3>;
	Wed, 29 May 2002 18:44:29 -0400
Date: Thu, 30 May 2002 00:44:23 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, davej@suse.de
Subject: Re: [PATCH] intel-x86 model config cleanup
Message-ID: <20020529224423.GA3174@werewolf.able.es>
In-Reply-To: <20020529143544.GA2224@werewolf.able.es> <3CF53C03.5040301@mandrakesoft.com> <3CF53C34.2080300@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.29 Jeff Garzik wrote:
>Jeff Garzik wrote:
>
>>
>> This implies separating the concept of a "generic x86 kernel that 
>> supports N CPU types" from "kernel supports one CPU type and one 
>> only." The i386/config.in is currently a mishmash of both.  Dave Jones 
>> did some work along these lines in his "cpuchoice" diff, which I have 
>> attached.
>

Could this be organized this way ?

CONFIG_VENDOR_ CONFIG_CPU_        CONFIG_M

GENERIC	       GENERIC_386        386      
               GENERIC_486        486      
               GENERIC_586        586      
               GENERIC_686        686      
INTEL          INTEL_386          386      
               INTEL_486          486      
               INTEL_PENTIUM      586      
               INTEL_PENTIUMMMX   586      
               INTEL_PENTIUMPRO   686      
               INTEL_PENTIUM2     686      
               INTEL_CELERON2     686      
               INTEL_PENTIUM3     686      
               INTEL_CELERON3     686      
               INTEL_PENTIUM4     686      
AMD            AMD_386            386
               AMD_486            486
               AMD_K5             586      
               AMD_K6             K6      
               AMD_K6II           K6      
               AMD_K6III          K6      
               AMD_K7             K7      
               AMD_DURON          K7      
               AMD_ATHLON         K7      
CYRIX          CYRIX_386          386      
               CYRIX_486          486      
               CYRIX_586          586      
               CYRIX_686          686      
VIA            CYRIX_III          686      
TRANSMETA      TRANSMETA_CRUSOE   ???      
NATSEMI        NATSEMI_586        586      
RISE           RISE_586           586      
IDT            IDT_WINCHIPC6      ???      
               IDT_WINCHIP2       ???      
               IDT_WINCHIP2A      ???      
               IDT_WINCHIP3       ???      

Then for each model you would define its generic CONFIG_M<arch>, and
the specific features not contained in the generic. And then define
the rest of features based on generic.
The CONFIG_M<arch> would serve as a flag for 'this cpu has all features
of a generic xxx'.

Or if you are worried about namespace pollution these could be named
CONFIG_CPU_VENDOR_, CONFIG_CPU_, CONFIG_CPU_M.

BTW: any more stars in processor vendor/model sky ?

Comments awaited...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre9-jam1 #1 SMP mié may 29 02:20:48 CEST 2002 i686
