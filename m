Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136421AbRAGShT>; Sun, 7 Jan 2001 13:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136339AbRAGShK>; Sun, 7 Jan 2001 13:37:10 -0500
Received: from dialin111.pg1-nt.dusseldorf.nikoma.de ([213.54.96.111]:34542
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S136410AbRAGSg6>; Sun, 7 Jan 2001 13:36:58 -0500
Date: Sun, 7 Jan 2001 00:11:21 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Daniel Stodden <stodden@in.tum.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hisax/sportster dependency error
In-Reply-To: <87zoh5ig36.fsf@bitch.localnet>
Message-ID: <Pine.LNX.4.30.0101060338180.13176-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2001, Daniel Stodden wrote:

> --- linux-2.4/drivers/isdn/hisax/Makefile.orig  Sat Jan  6 02:47:31 2001
> +++ linux-2.4/drivers/isdn/hisax/Makefile       Sat Jan  6 02:21:22 2001
> @@ -34,7 +34,7 @@
>  hisax-objs-$(CONFIG_HISAX_ASUSCOM) += asuscom.o isac.o arcofi.o hscx.o
>  hisax-objs-$(CONFIG_HISAX_TELEINT) += teleint.o isac.o arcofi.o hfc_2bs0.o
>  hisax-objs-$(CONFIG_HISAX_SEDLBAUER) += sedlbauer.o isac.o arcofi.o hscx.o isar.o
> -hisax-objs-$(CONFIG_HISAX_SPORTSTER) += sportster.o isac.o arcofi.o hfc_2bs0.o
> +hisax-objs-$(CONFIG_HISAX_SPORTSTER) += sportster.o isac.o arcofi.o hfc_2bs0.o hscx.o
>  hisax-objs-$(CONFIG_HISAX_MIC) += mic.o isac.o arcofi.o hfc_2bs0.o
>  hisax-objs-$(CONFIG_HISAX_NETJET) += nj_s.o netjet.o isac.o arcofi.o
>  hisax-objs-$(CONFIG_HISAX_NETJET_U) += nj_u.o netjet.o icc.o

Thanks, I'll put that into the next ISDN update.

> question: something which i missed to ask for about year now:
>
> bitch[3]:~$ cat /proc/ioports
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-007f : rtc
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 0220-022f : soundblaster
> 0268-026f : sportster
> 02f8-02ff : serial(set)
> 0330-0333 : MPU-401 UART
> 0376-0376 : ide1
> 0378-037a : parport0
> 03c0-03df : vga+
>   03c0-03df : matrox
> 03f8-03ff : serial(set)
> 0668-066f : sportster
> 0a68-0a6f : sportster
> 0cf8-0cff : PCI conf1
> 0e68-0e6f : sportster
> 1268-126f : sportster
> [...]
>
> could anyone explain this behaviour?
>
> the card is at io=0x268 irq=7
>
> according to sportster.c:get_io_range, this appears to be perfectly
> intentional, request_regioning 64x8 byte from 0x268 in 1024byte-steps.

AFAIK, this is because the hardware is stupid and does decode the higher
address lines. Therefore, the IO ports are mirrored every 1024 bytes and
should be reserved to avoid potential conflicts with other devices.

--Kai





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
