Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268471AbTCFWpz>; Thu, 6 Mar 2003 17:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268472AbTCFWpz>; Thu, 6 Mar 2003 17:45:55 -0500
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:22690 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S268471AbTCFWpw>; Thu, 6 Mar 2003 17:45:52 -0500
Date: Thu, 6 Mar 2003 23:54:27 +0100
From: Herbert Rosmanith <herp@wildsau.idv.uni.linz.at>
Message-Id: <200303062254.h26MsROQ005679@wildsau.idv.uni.linz.at>
To: kasperd@daimi.au.dk, kernel@wildsau.idv.uni.linz.at,
       linux-kernel@vger.kernel.org, root@chaos.analogic.com,
       vda@port.imtp.ilyichevsk.odessa.ua
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: emm386 hangs when booting from linux
To: vda@port.imtp.ilyichevsk.odessa.ua
Date: Thu, 6 Mar 2003 23:54:27 +0100 (MET)
From: "Herbert Rosmanith" <herp@wildsau.idv.uni.linz.at>
Cc: kernel@wildsau.idv.uni.linz.at ("H.Rosmanith (Kernel Mailing List)"),
	kasperd@daimi.au.dk (Kasper Dupont), root@chaos.analogic.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <200303061028.h26ASKu02263@Port.imtp.ilyichevsk.odessa.ua> from "Denis Vlasenko" at Mar 06, 2003 12:25:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> BTW, you may try linld:
> 
> http://port.imtp.ilyichevsk.odessa.ua/linux/vda/linld/
> 
> instead of loadlin. Its source is way smaller ;)

interesting! it works! however, I noticed some surprising effects.

I boot Linux via BIOS, then boot DOS via LINUX
when I boot linux again via LINLD, the "Uncompressing Linux ..."
takes a lot longer as compared to doing a LINLD from a DOS which
was booted by BIOS. I think this has something to do with switching....
oh! I know .... machine_real_start() from linux turns off the cache,
so this could be the reason. Ok, so I'll check this out by chaning CR0.

anyway, where loadlin hangs when loading the kernel from a Linux-booted
DOS, linld will go. The only hang I experience is cycling the boot-sequence

1) BIOS ->boots ... Linux
2) Linux boots DOS by switching to RM16, loading MBR and jmp 0:7c00
3) DOS boots Linux again via linld
4) Linux restores the realmode IDT by restoring a previously made copy of 0-3fff
5) Linux boots DOS by switching to RM16, loading MBR and jmp 0:7c00

after the C:\> DOS prompt appears, I dont have a keyboard anymore. Anyway,
that's not much of a worry right now. Now I have to figure out *how*
linld works!

thanks for your hint!
herbert



