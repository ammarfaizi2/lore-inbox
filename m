Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbTCKXFk>; Tue, 11 Mar 2003 18:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261672AbTCKXFk>; Tue, 11 Mar 2003 18:05:40 -0500
Received: from m14.nyc.untd.com ([64.136.22.77]:47044 "HELO m14.nyc.untd.com")
	by vger.kernel.org with SMTP id <S261667AbTCKXFh>;
	Tue, 11 Mar 2003 18:05:37 -0500
To: driver@jpl.nasa.gov
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org
Date: Tue, 11 Mar 2003 18:12:14 -0500 (EST)
Subject: Re: devfs + PCI serial card = no extra serial ports
Message-ID: <20030311.181500.8.1.whitnl73@juno.com>
In-Reply-To: <3E692281.10906@jpl.nasa.gov>
X-Mailer: Juno 2.0.11
X-Juno-Att: 0
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: whitnl73@juno.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003, Bryan Whitehead wrote:

> It seems devfsd has an annoying "feature". I bought a PCI card to get a
> couple (2) more serial ports. The kernel doesn't seem to set up the
> serial ports at boot, so devfs never creates an entry. However, post
> boot, since there is no entries, I cannot configure the serial ports
> with setserial. So basically devfsd = no PCI based serial add on?
>
> 03:05.0 Serial controller: NetMos Technology 222N-2 I/O Card (2S+1P)
> (rev 01) (prog-if 02 [16550])
> 	Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device 0002
> 	Flags: medium devsel, IRQ 17
> 	I/O ports at ecf8 [size=8]
> 	I/O ports at ece8 [size=8]
> 	I/O ports at ecd8 [size=8]
> 	I/O ports at ecc8 [size=8]
> 	I/O ports at ecb8 [size=8]
> 	I/O ports at eca0 [size=16]
>
>
> mknod ttyS2 c 4 66
> mknod ttyS3 c 4 67
> setserial ttyS2 port 0xecf8 UART 16550A irq 17 Baud_base 9600
> setserial ttyS3 port 0xece8 UART 16550A irq 17 Baud_base 9600

Why are you messing with baud_base?  Don't, unless you really know what
you are doing.  A normal 16550a with baud_base set to 9600 will run at
115200 when an app tries to run it at 9600.  baud_base is just the
quotient the serial driver uses to calculate the divisor needed to
run the UART at a given speed.
>
> I hoped after "setting up" the serial ports with setserial some magic
> would happen and they would apear in /dev/tts... but I was wrong.
>
> gets me working serial ports... but it's not in /dev... :O
>
can you not make them?  As in:

#mknod /dev/tts/5 c 4 69
...

> Am I just screwed?
>
> If so, what would be a good add on PCI based solution for more serial
> ports that WORKS with devfsd? (I don't want to disable devfs as this
> opens up a different set of problems)
>
> Thanks for any replay!
>
>
Lawson
--
---oops---


