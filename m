Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131980AbRCYDiE>; Sat, 24 Mar 2001 22:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131983AbRCYDhx>; Sat, 24 Mar 2001 22:37:53 -0500
Received: from johnson.mail.mindspring.net ([207.69.200.177]:14087 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S131980AbRCYDhl>; Sat, 24 Mar 2001 22:37:41 -0500
Message-ID: <001701c0b4dc$de099a70$08080808@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Alessandro Suardi" <alessandro.suardi@oracle.com>
Cc: <linux-kernel@vger.kernel.org>, "Jeff Garzik" <jgarzik@mandrakesoft.com>
In-Reply-To: <012301c0b357$3d29cc50$1601a8c0@zeusinc.com> <3ABBD639.12BE1035@oracle.com> <001e01c0b41d$1665de80$1601a8c0@zeusinc.com> <3ABD2C2A.7333D132@oracle.com>
Subject: Re: [PATCH] Fix for serial.c to work with Xircom Cardbus Ethernet+Modem
Date: Sat, 24 Mar 2001 22:37:06 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It seems something changed in 2.4.3-pre7 (against which I applied your
>>  patch) so that it doesn't make a difference. On startup I now get this,
>>  which I am CC:ing as per printk to serial-pci-info@lists.sourceforge.net
>>
>> Mar 24 23:59:05 princess cardmgr[374]: initializing socket 1
>> Mar 24 23:59:05 princess kernel:   got res[10c04000:10c07fff] for
resource 6 of PCI device 115d:0103
>> Mar 24 23:59:05 princess cardmgr[374]: socket 1: Xircom CBEM56G-100
CardBus 10/100 Ethernet + 56K Modem
>> Mar 24 23:59:05 princess kernel: PCI: Enabling device 05:00.1 (0000 ->
0003)
>> Mar 24 23:59:05 princess kernel: Redundant entry in serial pci_table.
Please send the output of
>> Mar 24 23:59:05 princess kernel: lspci -vv, this message
(4445,259,4445,4481)
>> Mar 24 23:59:05 princess kernel: and the manufacturer and name of serial
board or modem board
>> Mar 24 23:59:05 princess kernel: to
serial-pci-info@lists.sourceforge.net.
>> Mar 24 23:59:05 princess kernel: register_serial(): autoconfig failed
>>
>> The card is a Xircom RBEM56G-100, despite what the card advertises.
>>
>> (in case you wonder, cardmgr is from pcmcia_cs-3.1.25).

> OK, I'll take a look at it.  I made the patch against -ac21 which I think
> was only synced up to 2.4.3-pre6, I should have mentioned that.  Perhaps
> someone added the proper Xircom stuff already or some other change made my
> patch irrelavent.  BTW, are you building serial.c as a module, or built
in?
> I have mine as a module so it doesn't load until after the card is
> initialized.  Just curious.

I tested 2.4.3-pre7 and it still fails without my patch.  With my patch I
get the above message about 'Redundant entry in serial pci_table' but it
still manages to setup my serial device as /dev/ttyS4 (the same patch
applied to 2.4.2-ac21 sets the device to /dev/ttyS1).  However it only works
if I load serial.c as a module AFTER the card is inserted, if serial.c is
already loaded it doesn't register correctly with a messages similar to
above.  Perhaps I need to check my hotplug setup.

Could your try serial.c as a module and see if it works for you like that?
That way I'd know I'm on the right track and haven't just found some strange
way to make it work on my system alone.

Later,
Tom


