Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291399AbSBXVi2>; Sun, 24 Feb 2002 16:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291397AbSBXViI>; Sun, 24 Feb 2002 16:38:08 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:47364 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S290184AbSBXViB>; Sun, 24 Feb 2002 16:38:01 -0500
Date: Sun, 24 Feb 2002 22:37:59 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224223759.C1814@ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org> <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com> <20020224013038.G10251@altus.drgw.net> <3C78DA19.4020401@evision-ventures.com> <20020224142902.C1682@altus.drgw.net> <20020224215422.B1706@ucw.cz> <20020224151923.E1682@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020224151923.E1682@altus.drgw.net>; from hozer@drgw.net on Sun, Feb 24, 2002 at 03:19:23PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 03:19:23PM -0600, Troy Benjegerdes wrote:
> On Sun, Feb 24, 2002 at 09:54:22PM +0100, Vojtech Pavlik wrote:
> > On Sun, Feb 24, 2002 at 02:29:03PM -0600, Troy Benjegerdes wrote:
> > 
> > > On Sun, Feb 24, 2002 at 01:18:33PM +0100, Martin Dalecki wrote:
> > > > > Ummm, how does this work if I have two PCI ide cards, one on a 66mhz PCI 
> > > > > bus, and one on a 33mhz PCI bus?
> > > > > 
> > > > > Or am I missing something?
> > > > 
> > > > You are missing the fact that it didn't work before.
> > > 
> > > What hardware, chipsets, situations, etc did the previous code not work
> > > on?
> > >
> > > There is no avoiding the fact you need some kind of per-IDE controller
> > > data for the clock for that particular PCI device.
> > 
> > No. You don't need it. The base clock and multiplier are enough and you
> > have the multiplier from PCI config.
> > 
> > > I believe there are systems with 33mhz pci and 50mhz pci. Trying to find a
> > > 'common' base clock just seems to be an excercise in confusion. The only
> > > thing that really makes sense is 'how fast is said PCI device clocked'.
> > 
> > Show me one.
> 
> There is one on my desk, using a gt64260 PowerPC bridge chip. It's got 
> dual PCI busses, and each can be clocked independently.
> 
> Table 2-6. System Clock Selection
> CPU &
> Memory Bus Fast/3V PCI     Slow/5V PCI 
> Speed      Bus Speed       Bus Speed SW7 Settings
> 133 MHz    66 MHz          33 MHz    0100 0010 
> 100 MHz    66 MHz          33 MHz    1111 1010
> 100 MHz    33 MHz          33 MHz    1010 1000
> 66 MHz     66 MHz          33 MHz    0101 0101
> 66 MHz     33 MHz          33 MHz    0000 0001

All of these pose no problem, because we know if the PCI is running at
double the nominal speed.

> 83 MHz     55 MHz          41 MHz    0111 1101

This one is a problem, because 41*2 != 55. However, this is also illegal
according to the PCI spec.

> These is just a partial list of potential clock rates.

But yes, you convinced me that we may want to keep the clock speed per
bus (perhaps in the pci_bus struct ...), to be able to work with all the
(maybe spec noncompliant, or just weird) hardware.

Thanks.

-- 
Vojtech Pavlik
SuSE Labs
