Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313805AbSDPSJY>; Tue, 16 Apr 2002 14:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313806AbSDPSJX>; Tue, 16 Apr 2002 14:09:23 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:61148 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S313805AbSDPSI5>;
	Tue, 16 Apr 2002 14:08:57 -0400
Message-ID: <3CBC6839.10DA4779@hp.com>
Date: Tue, 16 Apr 2002 12:06:49 -0600
From: Khalid Aziz <khalid_aziz@hp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: OK, who broke the serial driver in 2.4.19-pre7?
In-Reply-To: <E16xXCg-0000T7-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> >   Hi, all. 2.4.19-pre7 has broken the serial driver. With 2.4.19-pre6
> > and before, my first serial port was ttyS0 (4, 64), and I got these
> > kernel messages:
> > Was this broken by the HCDP serial ports changes?
> 
> Yes. Someone put the HCDP below not above the basic x86 ports. Tweak
> include/asm-i386/serial.h and that should be well.
> 
> Alan
> 

Sorry, that was my fault. Here is a patch to fix it.

-- 
Khalid


--- linux-2.4.18-hcdpold/include/asm-i386/serial.h      Tue Apr 16
12:05:27 2002
+++ linux-2.4.18-hcdp/include/asm-i386/serial.h Tue Apr 16 12:02:54 2002
@@ -140,8 +140,8 @@
 #endif
 
 #define SERIAL_PORT_DFNS               \
-       HCDP_SERIAL_PORT_DEFNS          \
        STD_SERIAL_PORT_DEFNS           \
+       HCDP_SERIAL_PORT_DEFNS          \
        EXTRA_SERIAL_PORT_DEFNS         \
        HUB6_SERIAL_PORT_DFNS           \
        MCA_SERIAL_PORT_DFNS


====================================================================
Khalid Aziz                              Linux Systems Operation R&D
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
