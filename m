Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265001AbRFUPQD>; Thu, 21 Jun 2001 11:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265000AbRFUPPn>; Thu, 21 Jun 2001 11:15:43 -0400
Received: from sammy.netpathway.com ([208.137.139.2]:40975 "EHLO
	sammy.netpathway.com") by vger.kernel.org with ESMTP
	id <S264999AbRFUPPi>; Thu, 21 Jun 2001 11:15:38 -0400
Message-ID: <3B320DD3.BBC083CB@netpathway.com>
Date: Thu, 21 Jun 2001 10:08:03 -0500
From: "Gary White (Network Administrator)" <admin@netpathway.com>
Organization: Internet Pathway
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac16 kernel panic
In-Reply-To: <E15Czfx-0000x5-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the boot panic message I get with the patch applied...

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
RSDT Table at 0x1FFEC000, size 536788992 bytes.
kernel BUG at ioremap.c:73!
invalid operand: 0000



> Try this - it may help
> --- arch/i386/kernel/bootflag.c~        Mon Jun 18 19:17:30 2001
> +++ arch/i386/kernel/bootflag.c Thu Jun 21 08:19:44 2001
> @@ -168,6 +168,9 @@
>         rsdt = *(u32 *)(p+16);
>         rsdtlen = *(u32 *)(p+20);
>
> +       printk(KERN_INFO "RSDT Table at 0x%lX, size %u bytes.\n",
> +               rsdt, rsdtlen);
> +
>         rsdt = (unsigned long)ioremap(rsdt, rsdtlen);
>         if(rsdt == 0)
>                 return;
> @@ -188,6 +191,15 @@
>         for(n = 36; n+3 < i; n += 4)
>         {
>                 unsigned long rp = readl(rsdt+n);
> +               int len = 4096;
> +
> +               if(rp > 0xFFFFFFFFUL - len)
> +                       len = 0xFFFFFFFFUL - rp;
> +
> +               /* Too close to the end!! */
> +               if(len < 20)
> +                       continue;
> +
>                 rp = (unsigned long)ioremap(rp, 4096);
>                 if(rp == 0)
>                         continue;

--
Gary White               Network Administrator
admin@netpathway.com          Internet Pathway
Voice 601-776-3355            Fax 601-776-2314


