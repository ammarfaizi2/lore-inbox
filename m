Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144866AbRA2Cgv>; Sun, 28 Jan 2001 21:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144874AbRA2Cgl>; Sun, 28 Jan 2001 21:36:41 -0500
Received: from platan.vc.cvut.cz ([147.32.240.81]:11016 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S144866AbRA2CgV>; Sun, 28 Jan 2001 21:36:21 -0500
Date: Mon, 29 Jan 2001 03:35:23 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: PDC20265, disk corruption and NMI watchdog...
Message-ID: <20010129033523.C16593@platan.vc.cvut.cz>
In-Reply-To: <20010129032315.K1085@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010129032315.K1085@ppc.vc.cvut.cz>; from vandrove@vc.cvut.cz on Mon, Jan 29, 2001 at 03:23:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2001 at 17:36 Andre Hedrick wrote:
> 
> Everything but a kernel version :-(

Sorry. Corruption happens since I have this motherboard just before
christmas - something about 2.4.0-test13-pre2. It was not so massive
as today - with 2.4.0-ac10 (before it just died, today it damaged
hdh in addition). I got corruption/lockup with other versions (test13-pre3,
test13-pre7, 2.4.0, 2.4.0-ac3, 2.4.0-ac8, 2.4.0-ac9) too,
but as this one (ac10) does NMI watchdog on UP, I finally found
what's wrong instead of silent death - it is why I finally wrote
this letter - so you can either __sti() or mdelay() in ide_delay_50ms.
So others will not suffer from silent death instead of IDE reset...

Then I can test whether promise recovers from this - I doubt, as it
looks like that some data for /dev/hde landed on /dev/hdh (impossible,
I know...).

> On Mon, 29 Jan 2001, Petr Vandrovec wrote:
> 
> >   why on Earth ide_delay_50ms uses jiffies instead of mdelay(50) ?!
> > It is invoked with interrupts disabled, causing NMI watchdog detected
> > on my system, leading to complete crash of system.

For now I said that both disks should use PIO4 and it looks stable...
But there is visible difference in speed between PIO4 and UDMA5 ;-)

I have no idea whether TOSHIBA can do UDMA CRCs, but it works fine
at work, where I connected it to i440BX, and since November I
connect it to VIA694X/686A. Both in UDMA2 mode without troubles.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz
	
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
