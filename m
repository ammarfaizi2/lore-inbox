Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132377AbQLHReo>; Fri, 8 Dec 2000 12:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132431AbQLHRee>; Fri, 8 Dec 2000 12:34:34 -0500
Received: from cassis.axialys.net ([195.115.102.11]:21764 "EHLO
	cassis.axialys.net") by vger.kernel.org with ESMTP
	id <S132373AbQLHReY>; Fri, 8 Dec 2000 12:34:24 -0500
Date: Fri, 8 Dec 2000 18:08:43 +0100
From: Simon Huggins <huggie@earth.li>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@transmeta.com, Pete Zaitcev <zaitcev@metabyte.com>,
        Pavel Roskin <proski@gnu.org>, Jaroslav Kysela <perex@suse.cz>
Subject: Re: 2.4.0-test12-pre7 [ymfpci doesn't survive suspend to disk]
Message-ID: <20001208180843.A428@paranoidfreak.freeserve.co.uk>
Mail-Followup-To: Simon Huggins <huggie@earth.li>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@transmeta.com, Pete Zaitcev <zaitcev@metabyte.com>,
	Pavel Roskin <proski@gnu.org>, Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <Pine.LNX.4.10.10012061618300.2415-100000@penguin.transmeta.com> <Pine.LNX.4.10.10012061728180.2606-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012061728180.2606-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Dec 06, 2000 at 05:29:14PM -0800
Organization: Black Cat Networks, http://www.blackcatnetworks.co.uk/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 06, 2000 at 05:29:14PM -0800, Linus Torvalds wrote:
>  - test7:
>     - Kai Germaschewski: ymfpci cleanups and resource leak fixes
>  - pre5:
>     - Jaroslav Kysela: ymfpci driver

Just tried this out on my laptop and it played and didn't give strange
messages that Pete's driver did when I tried 2.2.18presummat (I can
check if it's interesting to know).

However when I then suspended the machine and resumed it sound no longer
worked.  In fact the mpg123 that I used to test it after the resume is
now just sitting there.

000  1000   387   277   9   0  1576  676 ?      S    tty1       0:00
mpg123 a.mp3

I CTRL-C'd it, it spat out:
[0:00] Decoding of a.mp3 finished.
And it's erm still sitting there.

Is this driver apm aware?

lspci says:
00:09.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio Controller] (rev 02)
        Subsystem: Sony Corporation: Unknown device 8072
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at fedf8000 (32-bit, non-prefetchable) [size=32K]
        I/O ports at fcc0 [size=64]
        I/O ports at fc8c [size=4]
        Capabilities: <available only to root>

It's been assigned interrupt 9 which is also used for the cardbus stuff.
[huggie@langly ~]$ cat /proc/interrupts
           CPU0
  0:     141136          XT-PIC  timer
  1:       3848          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       2988          XT-PIC  pcnet_cs
  9:      27977          XT-PIC  Ricoh Co Ltd RL5c478 (#2), Ricoh Co Ltd RL5c478, ymfpci
 12:       3722          XT-PIC  PS/2 Mouse
 14:       4851          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0
ERR:          0

This was compiled on gcc 2.95.2 (so does that mean this bug report hits
/dev/null?)

-- 
----------( Cows turn themselves inside out all the time. -  )----------
----------(               Officer, South Park                )----------
Simon ----(                                                  )---- Nomis
                             Htag.pl 0.0.17
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
