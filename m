Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbTAONBS>; Wed, 15 Jan 2003 08:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbTAONBS>; Wed, 15 Jan 2003 08:01:18 -0500
Received: from holomorphy.com ([66.224.33.161]:4747 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266308AbTAONBR>;
	Wed, 15 Jan 2003 08:01:17 -0500
Date: Wed, 15 Jan 2003 05:10:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 48GB NUMA-Q boots, with major IO-APIC hassles
Message-ID: <20030115131005.GJ919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
References: <20030115105802.GQ940@holomorphy.com> <20030115112412.GA5062@krispykreme> <20030115115525.GI919@holomorphy.com> <20030115123209.GA6588@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115123209.GA6588@krispykreme>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> PCI config cycles must be qualified by segment here just to get the
>> right address, so there's definitely a requirement for stuff. One
>> "advantage" of NUMA-Q (if it can be called that) is that firmware/BIOS
>> and hardware pushes a bus number mangling scheme that is more or less
>> mandatory, so things can at largely implicitly taken care of with the
>> bus number and the firmware's mapping of the mangled bus numbers to the
>> cross-quad portio area. But this scheme does not have cooperation from
>> PCI-PCI bridges, where NUMA-Q mangling scheme -noncompliant physical
>> bus ID's are kept in the bus number registers.

On Wed, Jan 15, 2003 at 11:32:09PM +1100, Anton Blanchard wrote:
> Can you store the segment in pci_bus->sysdata and then use that in
> your config read/write macros? What do you mean by the mangling?
> Does each host bridge have a separate segment identifier? If so why
> would the PCI-PCI bridges below it need to have incorrect IDs?

That is precisely what I tried when I attempted to liberate the code
from the BIOS-imposed bus number mangling, but it ended up being
brutally invasive into arch/i386/ and even worse, I couldn't get it to
work. I'm not actually sure what the host bridges have in their bus
number registers; it's possible we get away with it because of either
advance knowledge of the bus numbers divined from the MP config table
or otherwise the ability to decode its bus numbers ourselves. The only
real limit wrt.  how much we can second-guess the firmware is (of course)
the code impact and chances of destabilization, which both look large
for removing the bus number mangling scheme the BIOS hands to us.


At some point in the past, I wrote:
>> I have no idea what to do about these; I just sort of hope and pray the
>> backward-compatibility constraints won't hurt me. At the level of things
>> exported to userspace my main concern is largely that things like disk
>> arrays will actually be accessible as raw devices or mountable as fs's,
>> cooperation with userspace drivers and accurate reporting is kind of
>> secondary to me aside from satisfying backward-compatibility concerns
>> from Pee Cee -centric sides of things.

On Wed, Jan 15, 2003 at 11:32:09PM +1100, Anton Blanchard wrote:
> Its possible customers will run X on their server, thats when getting
> things like /proc/bus/pci/* right becomes important :) In fact on
> sparc64 and ppc64 X should work with domains fairly easily because
> they are already use /proc/bus/pci/* to mmap PCI BARs.
> I think X should always use this method, reading PCI BARs and mmap'ing
> /dev/mem is just awful.

It was relatively atypical for these particular boxen to ship with VGA
except as a method of satisfying NT's requirement for a graphics adapter.
I suspect it's very unlikely there will ever be demand for this on NUMA-Q,
though the backward-compatibility bits are more or less requirements for
other reasons (Pee Cee backward compatibility etc.).


Bill
