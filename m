Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261896AbTCGXaD>; Fri, 7 Mar 2003 18:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261892AbTCGXaC>; Fri, 7 Mar 2003 18:30:02 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:40976
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S261885AbTCGX35>; Fri, 7 Mar 2003 18:29:57 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DD4@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Bryan Whitehead'" <driver@jpl.nasa.gov>
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org,
       marekm@amelek.gda.pl
Subject: RE: devfs + PCI serial card = no extra serial ports
Date: Fri, 7 Mar 2003 15:40:31 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, go ahead and try the second patch that adds the Netmos cards to the
serial driver's device tables. It is for a somewhat newer rev, but you might
just get offsets with no failed hunks. It's worth a try.

The serial driver will only detect cards that are in the table. It does not
mean that there is anything wrong with the card.

Good luck,
Ed

-----Original Message-----
From: Bryan Whitehead [mailto:driver@jpl.nasa.gov]
Sent: Friday, March 07, 2003 3:28 PM
To: Bryan Whitehead
Cc: linux-kernel@vger.kernel.org; linux-newbie@vger.kernel.org;
marekm@amelek.gda.pl
Subject: Re: devfs + PCI serial card = no extra serial ports


I just found this:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0212.2/0845.html

Has this patch been accepted into the new kernel series? Or should I 
just toss this card (the NetMos PCI I/O card)?

Bryan Whitehead wrote:
> It seems devfsd has an annoying "feature". I bought a PCI card to get a 
> couple (2) more serial ports. The kernel doesn't seem to set up the 
> serial ports at boot, so devfs never creates an entry. However, post 
> boot, since there is no entries, I cannot configure the serial ports 
> with setserial. So basically devfsd = no PCI based serial add on?
> 
> 03:05.0 Serial controller: NetMos Technology 222N-2 I/O Card (2S+1P) 
> (rev 01) (prog-if 02 [16550])
>     Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device 
> 0002
>     Flags: medium devsel, IRQ 17
>     I/O ports at ecf8 [size=8]
>     I/O ports at ece8 [size=8]
>     I/O ports at ecd8 [size=8]
>     I/O ports at ecc8 [size=8]
>     I/O ports at ecb8 [size=8]
>     I/O ports at eca0 [size=16]
> 
> 
> mknod ttyS2 c 4 66
> mknod ttyS3 c 4 67
> setserial ttyS2 port 0xecf8 UART 16550A irq 17 Baud_base 9600
> setserial ttyS3 port 0xece8 UART 16550A irq 17 Baud_base 9600
> 
> I hoped after "setting up" the serial ports with setserial some magic 
> would happen and they would apear in /dev/tts... but I was wrong.
> 
> gets me working serial ports... but it's not in /dev... :O
> 
> Am I just screwed?
> 
> If so, what would be a good add on PCI based solution for more serial 
> ports that WORKS with devfsd? (I don't want to disable devfs as this 
> opens up a different set of problems)
> 
> Thanks for any replay!
> 


-- 
Bryan Whitehead
SysAdmin - JPL - Interferometry Systems and Technology
Phone: 818 354 2903
driver@jpl.nasa.gov

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
