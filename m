Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRDGSoc>; Sat, 7 Apr 2001 14:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbRDGSob>; Sat, 7 Apr 2001 14:44:31 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:49584 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129381AbRDGSoR>;
	Sat, 7 Apr 2001 14:44:17 -0400
Message-ID: <3ACF5FFE.24ECA0CA@mandrakesoft.com>
Date: Sat, 07 Apr 2001 14:44:14 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Reinelt <reinelt@eunet.at>
Cc: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@club-internet.fr>,
        Tim Waugh <twaugh@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <Pine.LNX.4.10.10104071507230.1561-100000@linux.local> <3ACF5E15.2A6E4F3C@eunet.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Reinelt wrote:
> But what I want to know before I spend time (and not-earning-money :-)
> into this, I want to know: Is this the right way (TM)? How do other
> multiport cards deal with this issue?
> 
> This is a specific question to the serial and parallel maintainers: are
> there cards supported by _both_ the serial and parallel subsystem? Do
> they work with 2.4.3? Will they work in the future? (I'm too lazy to
> compare the PCI tables from serial and parallel ;-)

FWIW Tim (in this thread) is the parallel maintainer, tytso is the
serial maintainer.  WRT serial, there exists serial_cs driver, and the
serial_cb driver -used- to exist.  The entire purpose of these "shim"
drivers was to probe their [pcmcia, CardBus] busses for the necessary
information, and then call the existing serial layer to register ports
using the probe information already discovered.  I think the pcmcia-cs
package has a similar plug-n-play shim driver for parallel ports.

To answer your question, if there are such multifunctions cards working
in 2.4.3, then their drivers are either (a) ignoring one or more
functions in favor of a primary function, or (b) lucky enough to have
hardware which export multiple PCI bus entries, one for each logical
function, making it easy to modify the subsystem driver itself to probe
for the hardware.


> Another (design) question: How will such a driver/module deal with
> autodetection and/or devfs? I don't like to specify 'alias /dev/tts/4
> netmos', because thats pure junk to me. What about pci hotplugging?

pci hotplugging happens pretty much transparently.  When a new device is
plugged in, your pci_driver::probe routine is called.  When a new device
is removed, your pci_driver::remove routine is called.

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
