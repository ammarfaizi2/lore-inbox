Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSGNPfc>; Sun, 14 Jul 2002 11:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSGNPfb>; Sun, 14 Jul 2002 11:35:31 -0400
Received: from pl1527.nas911.n-yokohama.nttpc.ne.jp ([210.139.44.247]:46019
	"EHLO standard.erephon") by vger.kernel.org with ESMTP
	id <S316897AbSGNPf3>; Sun, 14 Jul 2002 11:35:29 -0400
Message-ID: <3D319AEA.10F6611D@yk.rim.or.jp>
Date: Mon, 15 Jul 2002 00:38:18 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Q: boot time memory region recognition and clearing.
References: <3D303700.5030002@yk.rim.or.jp> <m14rf2ra95.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:

> Note.  The hardware ECC support in memtest86 3.0
> is limited, so I would check to make certain your chipset
> is supported..
> 

Well,  I read controller.c source file, and
found that amd751 is supported according to the info
in AMD751 documentation.
(This is the same documentatin I used when I hacked
early ecc.c source file.)

I ran memtest v3 on the motherboard, and
it didn't find any errors when I ran it overnight.

> Your objective is misguided.  Even with a bios that
> is slightly buggy in initializing the ECC bits, what you want is
> scrubbing.  Then if the error disappears after 5 minutes of uptime
> you can ignore it.  

I see. Then the problem would boil down whether
AMD751 supports scrubbingat the hardware level.
It reports that it saw correctable single bit error,
and I take it to mean that the chip itself
has fixed the single bit error.
Am I too optimistic to expect this?

The problem, though, is this.
According to the AMD751 documentation, we
can clear the memory error info in the chip register,
by writing to a certain location of the PCI space.
However, when one error get reported on my motherboard,
it would NOT go away and I think there is something amiss
about this.
I am not sure if the AMD doc is correct about this now.
from controller.c of memtest86.

                /* Clear the error status */
                pci_conf_write(ctrl.bus, ctrl.dev, ctrl.fn, 0x58, 2, 0);

>From locally hacked ecc.c:
             /*
                 * clear error flag bits that were set by writing 0 to
them
                 * we hope the error was a fluke or something :)
                 */
                /* int value = eccstat & 0xFCFF; */
                /* pci_write_config_word(bridge, 0x58, value); */
                pci_write_config_byte(bridge, 0x58, 0x0);
                pci_write_config_byte(bridge, 0x59, 0x0);


BTW, I tried both the byte and word write to 0x58, but
it never seemd to clear the error status.
(It is possible that the error is real, but again
the error is reported always in the first bank even if
I rotate the memry sticks...)

> And if it comes back you know you really have
> something to worry about.  At least for single bit errors this should
> fix the whole problem with something that is useful for other
> purposes.
> 
> Eric

Thank you for your feedback. I noticed that you 
contributed to linuxBIOS and memtest86.
Please keep the good work going!

Chiaki

PS: I am wondering when we can have a reasonably good
ECC support on desktop PC...
(A la Sun pizza boxes, that is.)
