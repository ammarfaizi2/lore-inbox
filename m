Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSKRNhA>; Mon, 18 Nov 2002 08:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262371AbSKRNhA>; Mon, 18 Nov 2002 08:37:00 -0500
Received: from mail.medav.de ([213.95.12.190]:32010 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S262322AbSKRNg7> convert rfc822-to-8bit;
	Mon, 18 Nov 2002 08:36:59 -0500
From: "Daniela Engert" <dani@ngrt.de>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "L P" <plm@iname.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Date: Mon, 18 Nov 2002 14:44:11 +0100 (CET)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <1037626779.7503.12.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: Problems Hot-Swapping IDE ATA drives
Message-Id: <20021118143956.26A6169A2@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Nov 2002 13:39:39 +0000, Alan Cox wrote:

>>Please, help me with the following: I have the PCMCIA adapter which
>>converts the ATA compatible PCMCIA cassettes into "True IDE hard disk".
>>My RedHat 7.3 linux works fine, when it was booted with the cassette
>>inserted. I can mount/read/write/unmount the device without any error.
>>Next, I unmount the device and extract the cassette - usually (not
>>always)I receive the "spurious interrupt" message. Then, when I insert 
>>the cassette and try to mount it back, I receive the following errors:

>PCMCIA IDE works for all the devices I have. Really I'd need to see the
>dmesg for the setup from boot through the mounts and fails

There is a problem with PCMCIA<->ATA adapters and "True IDE mode":

A CompactFlash unit enters "True IDE mode" when the /OE pin is held low
at device power on. This is fine when your system is powered on with
the CF card inserted. But if you insert a CF card into an already
powered on system, the /OE pin is not connected to the socket and thus
held high by an device-internal pull up at device power on. This is
because the power pins are longer than the other pins and connected
before the others! So the CF card enters "memory mapped mode" instead
of "True ATA mode" and is no longer accessible from the ATA host.

Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 32-34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


