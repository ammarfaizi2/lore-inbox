Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130523AbRCIOiw>; Fri, 9 Mar 2001 09:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130532AbRCIOim>; Fri, 9 Mar 2001 09:38:42 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:19718 "HELO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S130523AbRCIOid>; Fri, 9 Mar 2001 09:38:33 -0500
Message-ID: <879158D1D558D4118DBD0008C7CF32A9015834A7@tayexc07.tay.cpqcorp.net>
From: "Hicks, Jamey" <Jamey.Hicks@compaq.com>
To: "'linux-usb-devel@lists.sourceforge.net'" 
	<linux-usb-devel@lists.sourceforge.net>,
        David Brownell <david-b@pacbell.net>
Cc: Manfred Spraul <manfred@colorfullife.com>, zaitcev@redhat.com,
        linux-kernel@vger.kernel.org
Subject: RE: [linux-usb-devel] Re: SLAB vs. pci_alloc_xxx in usb-uhci patc
	h
Date: Fri, 9 Mar 2001 09:27:53 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are there any large-memory machines that need pci_alloc_consistent() in the
USB controller driver?  If not, then let's just set up an uncached mapping
of all of DRAM and use a modified version of virt_to_bus and bus_to_virt.
It gets around all the issues of having a better allocator of uncached
memory.  Even with a slab allocator for uncached memory, modified versions
of virt_to_bus and bus_to_virt would have to be used.

The other choice is cache invalidation and flushing around all the code that
touches ED's and TD's.  This might not be too bad if it is encapsulated in
_read and _write macros.  How performance critical is the ED and TD code?

The latest ARM -NP patches work on SA1110 with the SA1111 controller (which
is OHCI-like).  With minimal tweaks they work on SA110/Footbridge with an
OHCI controller.  We will be submitting these patches as tweaks.  It's not
beautiful, but it doesn't change the mainstream (x86) code significantly.

Jamey
