Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267470AbTBDUcO>; Tue, 4 Feb 2003 15:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267467AbTBDUcO>; Tue, 4 Feb 2003 15:32:14 -0500
Received: from s142-179-222-244.ab.hsia.telus.net ([142.179.222.244]:36270
	"EHLO bluetooth.WNI.AD") by vger.kernel.org with ESMTP
	id <S267470AbTBDUcM>; Tue, 4 Feb 2003 15:32:12 -0500
Message-ID: <3E40264C.5050302@WirelessNetworksInc.com>
Date: Tue, 04 Feb 2003 13:45:00 -0700
From: Herman Oosthuysen <Herman@WirelessNetworksInc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Dave Jones <davej@codemonkey.org.uk>, wookie@osdl.org,
       vda@port.imtp.ilyichevsk.odessa.ua, root@chaos.analogic.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: gcc 2.95 vs 3.21 performance
References: <200302042011.h14KBuG6002791@darkstar.example.net>
In-Reply-To: <200302042011.h14KBuG6002791@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Feb 2003 20:41:46.0082 (UTC) FILETIME=[D54CA420:01C2CC8D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

 From my experience, the speed issue is caused by misalligned memory 
accesses, causing inefficient SDRAM to Cache movement of data and 
instructions.

I don't think that you necessarily need a modification to the compiler. 
  What you can do is carefully place the ALLIGN switch in a few critical 
places in the kernel code, to ensure that the code and data will be 
properly alligned for whatever processor it is compiled for, be that a 
Pentium, an ARM, a MIPS or whatever.

It would be nice if GCC can be suitably improved to do this correcly for 
all architectures, but a little bit of human help can do wonders, 
without having to fork the GCC project.

Cheers,
-- 

------------------------------------------------------------------------
Herman Oosthuysen
B.Eng.(E), Member of IEEE
Wireless Networks Inc.
http://www.WirelessNetworksInc.com
E-mail: Herman@WirelessNetworksInc.com
Phone: 1.403.569-5687, Fax: 1.403.235-3965
------------------------------------------------------------------------



John Bradford wrote:
>> > Maybe we should create a KGCC fork, optimise it for kernel
>> > complilations, then try to get our changes merged back in to GCC
>> > mainline at a later date.
>>
>>What exactly do you mean by "optimise for kernel compilations" ?
> 
> 
> I don't, that was a bad way of phrasing it - I didn't mean fork GCC
> just to create one which compiles the kernel so it runs faster, as the
> expense of other code.
> 
> What I was thinking was that if we forked GCC, we could try out all of
> these ideas that have been floating around in this thread, and if, as
> was hinted at earlier in this thread, $bigcompanies[] have not offered
> contributions because of reluctance to accept them by the GCC team, we
> would be more in a position to try them out, because we only need to
> concern ourselves with breaking the compilation of the kernel, not
> every single program that currently compiles with GCC.
> 
> The way I see it, the development series would be optimised for KGCC,
> and when we start to think about stabilising that development series,
> we try to get our KGCC changes merged back in to GCC mainline.  If
> they are not accepted, either KGCC becomes the recommended kernel
> compiler, which should cause no great difficulties, (having one
> compiler for kernels, and one for userland applications), or we start
> making sure that we haven't broken compilation with GCC, (and since a
> there would probably always be people compiling with GCC anyway, even
> if there was a KGCC, we would effectively always know if we broke
> compilation with GCC), and then the recommended compiler is just not
> the optimal one, and it would be up to the various distributions to
> decide which one they are going to use.
> 
> John.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


