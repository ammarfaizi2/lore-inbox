Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbRA0OXW>; Sat, 27 Jan 2001 09:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131560AbRA0OXM>; Sat, 27 Jan 2001 09:23:12 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:54029 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130454AbRA0OW4>;
	Sat, 27 Jan 2001 09:22:56 -0500
Message-ID: <3A72D9B5.941526CE@mandrakesoft.com>
Date: Sat, 27 Jan 2001 09:22:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Bustos <bustos@its.caltech.edu>
CC: sailer@ife.ee.ethz.ch, linux-kernel@vger.kernel.org
Subject: Re: es1371 freezes 2.4.0 hard
In-Reply-To: <20010124154457.A491@alex.caltech.edu> <3A70451D.C599794A@mandrakesoft.com> <20010125120729.A516@alex.caltech.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Bustos wrote:
> Quoth Jeff Garzik on Thu, Jan 25, 2001 at 10:24:13AM -0500:
> > What happens if you remove the call to pci_enable_device() in the source
> > code, drivers/sound/es1371.c?
> 
> That seems to do it.

Ok.  For a temporary fix, there ya go.

But removing pci_enable_device is incorrect; it merely avoids what
appears to be a bug with your Via irq routing.  Would it be possible for
you to edit linux/arch/i386/kernel/pci-i386.h, and change the line near
the top from
	#undef DEBUG
to
	#define DEBUG 1
and then send the output of 'dmesg -s 16384' to linux-kernel (and CC
me)?  That will dump your PCI IRQ routing information, among other
details.

Step two, "modprobe es1371" with pci_enable_device -in- the code, and
with debugging enabled as described above.  IIRC it should print out a
few more lines of debugging information that will be helpful.  Since we
are dealing with a hard lock, these last few lines of debugging info
might have to be copied via a serial console, or by hand.

One last question... is this an SMP machine?  If so, let me know if
booting with "noapic" option on the command line fixes things.

Regards,

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
