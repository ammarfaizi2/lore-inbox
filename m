Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132616AbRDGI6V>; Sat, 7 Apr 2001 04:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132618AbRDGI6M>; Sat, 7 Apr 2001 04:58:12 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:23465 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132616AbRDGI5z>;
	Sat, 7 Apr 2001 04:57:55 -0400
Message-ID: <3ACED679.7E334234@mandrakesoft.com>
Date: Sat, 07 Apr 2001 04:57:29 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Reinelt <reinelt@eunet.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <3ACECA8F.FEC9439@eunet.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Reinelt wrote:
> I've got a problem with my communication card: It's a PCI card with a
> NetMos chip, and it provides two serial and one parallel port. It's not
> officially supported by the linux kernel, so I wrote my own patch and
> sent it to the parallel, serial and pci maintainer. The patch itself is
> basically an extension of the pci id tables; and I hope it's in the
> queue for the official kernel.

Where is this patch available?  I haven't heard of an extension to the
pci id tables, so I wonder if it's really in the queue for the official
kernel.


> The card shows up on the PCI bus as one device. For the card provides
> both serial and parallel ports, it will be driven by two subsystems, the
> serial and the parallel driver.
[...]
> pci_announce_device() will be called only if there's no other driver
> claiming the device. This explains why either the parallel or the serial
> port will be detected: The first driver loaded will see the device, the
> next drivers won't.
> 
> I'm afraid this is not a bug, but a design issue, and will be hard to
> solve. Maybe we need a flag for such devices which allows it to be
> claimed ba more thean one driver?

Not so hard.

There is no need to register more than one driver per PCI device -- just
create a PCI driver whose probe routine registers serial and parallel,
and whose remove routine unregisters same.

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
