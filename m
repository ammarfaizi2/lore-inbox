Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262878AbSJ1F07>; Mon, 28 Oct 2002 00:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262879AbSJ1F07>; Mon, 28 Oct 2002 00:26:59 -0500
Received: from inspired.net.au ([203.58.81.130]:28425 "EHLO inspired.net.au")
	by vger.kernel.org with ESMTP id <S262878AbSJ1F06>;
	Mon, 28 Oct 2002 00:26:58 -0500
Message-Id: <200210280532.QAA25547@thucydides.inspired.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Oct 2002 16:29:40 +1100
To: linux-kernel@vger.kernel.org
Subject: Accessing PCI expansion ROMs
X-Mailer: VM 7.07 under Emacs 21.2.2
From: "Martin Schwenke" <martin@meltin.net>
Reply-To: "Martin Schwenke" <martin@meltin.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to extract VPD (Vital Product Data) from the expansion ROMs on
PCI 2.0/2.1 devices.  The PCI specification tells me all I need to
know once I can actually access the ROM I'm after.

On ppc I can use xmon (or write a dedicated utility) to get to
expansion ROMs and extract the required part.  On i386, expansion ROMs
don't have addresses assigned and the PCI initialisation code seems to
explicitly disable and unassign them (and this seems to be recommended
by the PCI specification).

So, it looks like there might be a few options...

* Userspace.  Is there a reliable way of accessing the ROMs from
  userspace?  Does it work the same way on different architectures?

  I know I can assign an address and enable a ROM via PCI
  configuration space, but I don't know if either of these things can
  be done safely from userspace.

* Kernel.  Write some kernel code to dynamically retrieve the contents
  of expansion ROMs.

  This might involve assigning an address, enabling the ROM, reading
  data, disabling the ROM and then possibly unassigning it again.

* Kernel.  Write some kernel code that hooks into the PCI
  initialisation/hotplug to grab the contents of expansion ROMs before
  they are unassigned and disabled.  Copy the data and put it into
  /proc or /devices - yep, a bit gross, but the amount of data tends
  to be small.

Any ideas?  I'd really like it to be architecture independent,
preferably userspace.  However, it can't be done there, it'll have to
be done in the kernel...  and then possibly architecture by
architecture...

Please copy me on replies, since I'm not subscribed to linux-kernel.

Thanks...

peace & happiness,
martin
