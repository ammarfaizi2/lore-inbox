Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290709AbSAROnH>; Fri, 18 Jan 2002 09:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290707AbSAROm5>; Fri, 18 Jan 2002 09:42:57 -0500
Received: from pollux.et6.tu-harburg.de ([134.28.85.242]:49158 "HELO
	mail.et6.tu-harburg.de") by vger.kernel.org with SMTP
	id <S290709AbSAROmm>; Fri, 18 Jan 2002 09:42:42 -0500
Message-ID: <3C483460.70100@tu-harburg.de>
Date: Fri, 18 Jan 2002 15:42:40 +0100
From: Sebastian Zimmermann <S.Zimmermann@tu-harburg.de>
Organization: Technische =?ISO-8859-15?Q?Universit=E4t?= Hamburg-Harburg
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011213
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: I2O kernel oops with Promise SuperTrak SX6000
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since Promise did not answer, I am asking here for help again.

We have a strange problem with the Promise SuperTrak SX6000 that leads 
to a kernel oops:

When the system is powered up, the SuperTrak BIOS is initializing the 
adapter. If we manually *abort* the initialization, Linux will boot 
without problems and we can use the hardware raid.

However, if we let the controller initialze the adapter (that is the 
default), the kernel will always Oops when I2O is loaded:

Oops: 0000
Call Trace: 
[<c01f7fd6>][<c0107d6d>][<c0107ed6>][<c0105150>][<c0105150>][<c0109d48>][<c0105150>][<c0105150>][<c0105173>][<c01051d9>][<c0105000>][<c0105027>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c01f7fd6 <i2o_pci_interrupt+a/14>
Trace; c0107d6c <handle_IRQ_event+30/5c>
Trace; c0107ed6 <do_IRQ+6a/a8>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0109d48 <call_do_IRQ+6/e>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0105172 <default_idle+22/28>
Trace; c01051d8 <cpu_idle+40/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105026 <rest_init+26/28>

This error is reproducable with all current kernels (2.4.9, 2.4.14, 2.4.17).

There are no other Promise controllers in the system. Changing PCI slots 
or reassigning IRQs doesn't help either.

My guess is that the i2o module tries to initialize the board. When it 
already was initialized by the BIOS, the system crashes.

Sebastian

