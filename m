Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbTAOM16>; Wed, 15 Jan 2003 07:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbTAOM16>; Wed, 15 Jan 2003 07:27:58 -0500
Received: from dp.samba.org ([66.70.73.150]:9197 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266286AbTAOM15>;
	Wed, 15 Jan 2003 07:27:57 -0500
Date: Wed, 15 Jan 2003 23:32:09 +1100
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 48GB NUMA-Q boots, with major IO-APIC hassles
Message-ID: <20030115123209.GA6588@krispykreme>
References: <20030115105802.GQ940@holomorphy.com> <20030115112412.GA5062@krispykreme> <20030115115525.GI919@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115115525.GI919@holomorphy.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> PCI config cycles must be qualified by segment here just to get the
> right address, so there's definitely a requirement for stuff. One
> "advantage" of NUMA-Q (if it can be called that) is that firmware/BIOS
> and hardware pushes a bus number mangling scheme that is more or less
> mandatory, so things can at largely implicitly taken care of with the
> bus number and the firmware's mapping of the mangled bus numbers to the
> cross-quad portio area. But this scheme does not have cooperation from
> PCI-PCI bridges, where NUMA-Q mangling scheme -noncompliant physical
> bus ID's are kept in the bus number registers.

Can you store the segment in pci_bus->sysdata and then use that in
your config read/write macros? What do you mean by the mangling?
Does each host bridge have a separate segment identifier? If so why
would the PCI-PCI bridges below it need to have incorrect IDs?

> I have no idea what to do about these; I just sort of hope and pray the
> backward-compatibility constraints won't hurt me. At the level of things
> exported to userspace my main concern is largely that things like disk
> arrays will actually be accessible as raw devices or mountable as fs's,
> cooperation with userspace drivers and accurate reporting is kind of
> secondary to me aside from satisfying backward-compatibility concerns
> from Pee Cee -centric sides of things.

Its possible customers will run X on their server, thats when getting
things like /proc/bus/pci/* right becomes important :) In fact on
sparc64 and ppc64 X should work with domains fairly easily because
they are already use /proc/bus/pci/* to mmap PCI BARs.

I think X should always use this method, reading PCI BARs and mmap'ing
/dev/mem is just awful.

Anton
