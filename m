Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130753AbQL3TpW>; Sat, 30 Dec 2000 14:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131178AbQL3TpN>; Sat, 30 Dec 2000 14:45:13 -0500
Received: from cd168990-a.ctjams1.mb.wave.home.com ([24.108.112.42]:52493 "EHLO
	cd168990-a.ctjams1.mb.wave.home.com") by vger.kernel.org with ESMTP
	id <S130753AbQL3TpA>; Sat, 30 Dec 2000 14:45:00 -0500
Date: Sat, 30 Dec 2000 13:19:30 -0600
From: Evan Thompson <evaner@bigfoot.com>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA IDE controller strangeness (2.4.0-test12/test13-pre5)
Message-ID: <20001230131930.A3657@evaner.penguinpowered.com>
Reply-To: evaner@bigfoot.com
Mail-Followup-To: Evan Thompson <evaner@bigfoot.com>,
	Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001229185923.A477@evaner.penguinpowered.com> <20001230183414.C1950@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001230183414.C1950@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Sat, Dec 30, 2000 at 06:34:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--(CC replies please)--

On Sat, Dec 30, 2000 at 06:34:14PM +0100, Matthias Andree wrote:
> Could you report the chip set type and revision? Quote the corresponding
> parts from the "lspci -v" output, please. I've been using PC Chips main
> boards with VIA chip sets without IDE difficulties ever since I bought
> one of those in fall 1998. (VIA Apollo MVP3 AGP, VT82C598 + VT82C586
> north+south bridges), both PC Chips M577 and Tyan Trinity S1590S.

Alrighty then (this is output from lspci -v running under 2.2.18pre21):

-- BEGIN OUTPUT --
...

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA
 [Apollo VP] (rev 41)
        Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
 (prog-if 8f [Master SecP SecO PriP PriO])
        Flags: bus master, medium devsel, latency 32, IRQ 14
        I/O ports at 01f0
        I/O ports at 03f4
        I/O ports at 0170
        I/O ports at 0374
        I/O ports at ffa0

...

-- END OUTPUT --

Now...one thing I noticed is that Linux is trying to find this IDE
interface through PCI and it reports it on 00:07.1 during -test12 and
-test13-pre5 boot up (I can't get a dmesg output for you 'cause it never
boots...just keeps complaining about hdb: lost interrupt), but the IDE
controller seems to be an ISA device (unless I've read this wrong).
In case I'm configuring something wrong, I've pasted the IDE .config
portions here:

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
ONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

Hope this stuff helps you guys out.
If somebody wants to tell me a better way to get nvi to wrap lines at 75
chars (other than hitting enter when I think it has to be hit), you could
e-mail me (don't bother sending it to the list).

CC replies please.  I don't subscribe to linux-kernel.  Sorry.
-- 
| Evan A. Thompson                     | He's more fun than trying to skinny  | 
| evaner@bigfoot.com                   | dip in the beach in winter...        |
| http://evaner.penguinpowered.com     |    ...in Winnipeg.                   |
| ICQ: 2233067 / AIM + MSN: Evaner517  |  (GnuPG key avaiable upon request.)  |

...hmmm...Now I'm going to have to adjust my .signature to fit in 75
chars instead of 79.  Darn.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
