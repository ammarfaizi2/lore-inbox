Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310303AbSCLBl0>; Mon, 11 Mar 2002 20:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310309AbSCLBlR>; Mon, 11 Mar 2002 20:41:17 -0500
Received: from mail18.messagelabs.com ([202.153.127.245]:20750 "HELO
	mail18.messagelabs.com") by vger.kernel.org with SMTP
	id <S310303AbSCLBlH>; Mon, 11 Mar 2002 20:41:07 -0500
X-VirusChecked: Checked
Message-ID: <001401c1c966$f17a8430$4983a8c0@takeow2kn2>
From: "Takeo Saito" <kernel@tranda.com.tw>
To: "Eyal Lebedinsky" <eyal@eyal.emu.id.au>,
        "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "lkml" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva> <3C8D3BF5.67A497C8@eyal.emu.id.au>
Subject: Re: Linux 2.4.19-pre3
Date: Tue, 12 Mar 2002 09:40:48 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think lost patch bellow:

--- linux-2.4.18-pre8/include/linux/if_pppox.h	Thu Nov 22 14:47:14 2001
+++ linux/include/linux/if_pppox.h	Fri Jan 25 07:39:15 2002
@@ -126,13 +126,14 @@
 extern int pppox_channel_ioctl(struct ppp_channel *pc, unsigned int cmd,
 			       unsigned long arg);

-/* PPPoE socket states */
+/* PPPoX socket states */
 enum {
     PPPOX_NONE		= 0,  /* initial state */
     PPPOX_CONNECTED	= 1,  /* connection established ==TCP_ESTABLISHED */
     PPPOX_BOUND		= 2,  /* bound to ppp device */
     PPPOX_RELAY		= 4,  /* forwarding is enabled */
-    PPPOX_DEAD		= 8
+    PPPOX_ZOMBIE	= 8,  /* dead, but still bound to ppp device */
+    PPPOX_DEAD		= 16  /* dead, useless, please clean me up!*/
 };

 extern struct ppp_channel_ops pppoe_chan_ops;


Best Regrads,
Takeo Tung
Diyixian.Com Litmited Taiwan branch

----- Original Message -----
From: "Eyal Lebedinsky" <eyal@eyal.emu.id.au>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "lkml" <linux-kernel@vger.kernel.org>
Sent: Tuesday, March 12, 2002 7:21 AM
Subject: Re: Linux 2.4.19-pre3


> Marcelo Tosatti wrote:
> >
> > Hi,
> >
> > Here goes -pre3, with the new IDE code. It has been stable enough time
in
> > the -ac tree, in my and Alan's opinion.
>
> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
> /data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h
> -DKBUILD_BASENAME=pppoe  -c -o pppoe.o pppoe.c
> pppoe.c: In function `pppoe_flush_dev':
> pppoe.c:282: `PPPOX_ZOMBIE' undeclared (first use in this function)
> pppoe.c:282: (Each undeclared identifier is reported only once
> pppoe.c:282: for each function it appears in.)
> pppoe.c: In function `pppoe_disc_rcv':
> pppoe.c:446: `PPPOX_ZOMBIE' undeclared (first use in this function)
> pppoe.c: In function `pppoe_ioctl':
> pppoe.c:730: `PPPOX_ZOMBIE' undeclared (first use in this function)
> make[2]: *** [pppoe.o] Error 1
> make[2]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre/drivers/net'
>
> For me this makes it the third strike, so pre3 is out :-) Got to go
> to work now.
>
> --
> Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


________________________________________________________________________
This email has been scanned for all viruses by the MessageLabs SkyScan
service. For more information on a proactive anti-virus service working
around the clock, around the globe, visit http://www.messagelabs.com
________________________________________________________________________
