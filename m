Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129110AbRBNReP>; Wed, 14 Feb 2001 12:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129149AbRBNRdz>; Wed, 14 Feb 2001 12:33:55 -0500
Received: from smtp3.xs4all.nl ([194.109.127.132]:2052 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129127AbRBNRdp>;
	Wed, 14 Feb 2001 12:33:45 -0500
Date: Wed, 14 Feb 2001 17:30:57 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ingo Molnar <mingo@chiara.elte.hu>, Andrew Morton <andrewm@uow.edu.au>,
        Manfred Spraul <manfred@colorfullife.com>,
        Frank de Lange <frank@unternet.org>,
        Martin Josefsson <gandalf@wlug.westbo.se>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.1, 2.4.2-pre3: APIC lockups
Message-ID: <20010214173057.A824@grobbebol.xs4all.nl>
In-Reply-To: <Pine.GSO.3.96.1010213203553.1931A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.3.96.1010213203553.1931A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Feb 13, 2001 at 09:13:10PM +0100
X-OS: Linux grobbebol 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2001 at 09:13:10PM +0100, Maciej W. Rozycki wrote:
>  Please test it extensively, as much as you can, before I submit it for
> inclusion.  If you ever get "Aieee!!!  Remote IRR still set after unlock!" 
> message, please report it to me immediately -- it means the code failed. 


ok, so far so good.

> There is also an additional debugging/statistics counter provided in
> /proc/cpuinfo that counts interrupts which got delivered with its trigger
> mode mismatched.  Check it out to find if you get any misdelivered
> interrupts at all.

currently attacking the box with a flood ping. I used a pristine 2.4.1.
to be sure I didn't leave stuff and applied the patch.

observations -- system doesn't crash; usually I had to use disable focus
processor -- else it fails.

other observations -- approx 6000 ints from the ne2k card/sec.
MIS shows approx 1% that goes wrong with a ping flood.

           CPU0       CPU1
  0:      35345      36195    IO-APIC-edge  timer
  1:       1632       1534    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:        826        832    IO-APIC-edge  serial
  4:          4          4    IO-APIC-edge  serial
  5:      12213      12201    IO-APIC-edge  soundblaster
  8:          0          1    IO-APIC-edge  rtc
 14:       3079       2906    IO-APIC-edge  ide0
 15:          3          3    IO-APIC-edge  ide1
 18:         69         85   IO-APIC-level  BusLogic BT-930
 19:    1758280    1758266   IO-APIC-level  eth0
NMI:      71480      71480
LOC:      71459      71456
ERR:          3
MIS:      15814


good work !




-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
