Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267157AbTAFVpp>; Mon, 6 Jan 2003 16:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbTAFVpo>; Mon, 6 Jan 2003 16:45:44 -0500
Received: from palrel11.hp.com ([156.153.255.246]:41644 "HELO palrel11.hp.com")
	by vger.kernel.org with SMTP id <S267157AbTAFVo5>;
	Mon, 6 Jan 2003 16:44:57 -0500
Date: Mon, 6 Jan 2003 13:52:10 -0800
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@transmeta.com>, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
Message-ID: <20030106215210.GE26790@cup.hp.com>
References: <20030105153735.A8532@jurassic.park.msu.ru> <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com> <20030106183328.B677@localhost.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030106183328.B677@localhost.park.msu.ru>
User-Agent: Mutt/1.4i
From: grundler@cup.hp.com (Grant Grundler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 06:33:28PM +0300, Ivan Kokshaysky wrote:
> For now I'd start with following:
> phase #1. pci_do_scan_bus() - build the bus/device tree, read in
>           dev/vendor IDs, header type and class code; call
> 	  "PCI_FIXUP_EARLY" fixups.

you meant pci_scan_bus() for #1?

(pci_do_scan_bus() is the implementation, but I thought arch code
is supposed to call pci_scan_bus().)

> phase #2. pci_probe_resources(bus) - walk the bus tree again,
> 	  probe the BARs, maybe call pci_read_bridge_bases for
> 	  bridges; fill in the rest of PCI header; call "PCI_FIXUP_HEADER"
> 	  fixups.
> (Also there are phases #3 and #4 - assign resources and assign unassigned
> resources, but it's another story)
...
> Hmm, this looks good - now we can do early bus-specific fixups
> without introducing "pcibios_init_bus" thing (suggested by Grant and
> myself quite a while ago).

I agree - it looks better. But I fail to see how it fixes the problem
of knowing when we can or cannot disable a device in order to size
the BAR. I'm under the impression some i386 specific code needs to be added
to identify/fixup the broken configurations (memory disabled when
a PCI Bridge is disabled).

I'm thinking the same logic needed by PCI hotplug to allow safe removal
of a bridge device would be useful to determine if a PCI Bridge could
be safely (temporarily) disabled (I'm thinking 4-port 100BT card).
Ie a "no subordinate drivers active" and "not in use" checking.

thanks,
grant
