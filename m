Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272209AbRHWHsA>; Thu, 23 Aug 2001 03:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272211AbRHWHru>; Thu, 23 Aug 2001 03:47:50 -0400
Received: from [194.30.80.67] ([194.30.80.67]:61454 "EHLO
	serv_correo.ingecom.net") by vger.kernel.org with ESMTP
	id <S272209AbRHWHrj>; Thu, 23 Aug 2001 03:47:39 -0400
Message-ID: <004501c12ba8$42f04ff0$66011ec0@frank>
From: "Frank Torres" <frank@ingecom.net>
To: "Stephen Torri" <storri@ameritech.net>
Cc: "Linux-Kernel \(Lista Correo\)" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108221201210.8546-100000@base.torri.linux>
Subject: Re: 2.4.8-ac7: all serial ports not setup
Date: Thu, 23 Aug 2001 09:50:16 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.3018.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Stephen Torri" <storri@ameritech.net>
> I am using 2.4.8-ac7 on a Dual P3@450Mhz. The machine has two serial
> ports. ttyS0 & ttyS2 are covered by the first with ttyS1 & ttyS3 covered
> by the second. Now typically in /proc/interrupts only one serial port is
> configured. The IRQs 3 & 4 are shared by the two ports. Its not consistent
> which one gets which IRQ. Sometimes the first has 3 and the second 4.
> Today the situation is reversed. This ofcourse is wreaking havoc on
> setting my pilot for synchronization.
>

Usually, IRQs are assigned when de device is used. So the serial port you
see in /proc/interrupts is the one you're using. If sometimes it takes an
IRQ and sometimes the other it means that the system is using another
device/process which takes one of the two serial ports IRQs.

ttyS0 and ttyS2 usually take IRQ3 and ttyS1 and ttyS3 most of the times take
the IRQ4. You can "force" the serial port to use one IRQ but that's not
recommended because the dinamyc IRQ assignment is one of the advantages of
the modules and drivers. That way one device doesn't own the IRQ if it is
not using it so the other devices can use that IRQ. (I don't know if I make
myself understand, but it's that way). And if you have a device using that
IRQ and tell Linux to assing -only- that IRQ to your serial device (the
"pilot" perhaps?) you could have a conflict between the devices -or- the
system could show you a message telling you the IRQ is being used. I don't
really know exactly.

Any way, to force the serial port to use one IRQ, do it using setserial (man
setserial) or using the serial port config. files (rc.serial and
serial.conf -check inside /etc/rc.d/rc.sysinit where to copy those files-)
but the script rc.serial have errors in some kernel versions so it's better
the first option.

frank
fcnatra@yahoo.com
frank@ingecom.net


