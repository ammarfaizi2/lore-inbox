Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285358AbRLGBJI>; Thu, 6 Dec 2001 20:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285379AbRLGBIL>; Thu, 6 Dec 2001 20:08:11 -0500
Received: from air-1.osdl.org ([65.201.151.5]:53765 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S285358AbRLGBHg>;
	Thu, 6 Dec 2001 20:07:36 -0500
Date: Thu, 6 Dec 2001 17:03:35 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Cory Bell" <cory.bell@usa.net>
Cc: john@deater.net, linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-Id: <20011206170335.03856f7b.rddunlap@osdl.org>
In-Reply-To: <1007685691.6675.1.camel@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0112060938340.32381-100000@pianoman.cluster.toy>
	<1007685691.6675.1.camel@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Dec 2001 16:41:29 -0800
"Cory Bell" <cory.bell@usa.net> wrote:

| On Thu, 2001-12-06 at 07:11, John Clemens wrote:
| > You are absolutely correct :) I did the same thing a few weeks ago (when i
| > was really working on it), and traced the lspci -vvxxx output and
| > interpreted everything linux was saying about it.  I was looking at it
| > from the acpect of maybe just changing the PCI router in config space as
| > well as the PCI irq from user space without requiring kernel changes at
| > all.  The reason why I didn't try that was because i chickened out and
| > didn't know wether changing the PIRQ table woudl a) work or b) permanently
| > screw up my machine.  This may still be the "correct way" however...
| 
| Well, the *actual* PIRQ table is supposed to be static, according to the
| spec. I don't see the $PIR signature anywhere in the ROM, so it may be
| generated on boot. As for changing the IRQ router PCI config space, the
| last patch is doing that already - r->set is just calling pirq_ali_set,
| which fiddles the bit in question.
| 
...
| 
| > Actually, i think the BIOS might "adjust" the pIRQ table at boot to match
| > it's view of the world.  I don't know.
| 
| I looked in the ROM file came with my latest BIOS update. I don't see
| the $PIR signature in there anywhere, so it may be generated, but
| static.

Hi-

Did your search for "$PIR" or "RIP$" ?
It is suppsed to be the latter (little-endian).

~Randy

| > I would really appreciate comments from someone who'se had more experience
| > than us with pIRQ problems...
| 
| That makes two of us.
| 
| > I guess the question is where to we proceed from here.  Our "best option"
| > may be to, at DMI scan time, recognise our laptops and change both PCI
| > config space and the routing table to point to irq 11.  And then we just
| > have to be brave enough to try it.  PCI config spae I don't mind mucking
| > with... internal chipset registers on the ISA bridge, that scares me
| > without proper documentation.  Maybe we should ask ALi for it?
| 
| Possibilities:
| 1) pirq_ali_get nastiness (above)
| 2) previous patch nastiness
| 3) DMI & 1
| 4) DMI & 2
| 5) ?
| 
| What do you think? Option 1 & 3 bother me a little, given that I find it
| conceptually dirty to write to registers from a function intended to
| read from registers. Still, is IS more separated from the generic code,
| and it's all in one place.
|  
| WRT DMI: Would we just create an is_broken_hp_pavilion_bios variable,
| similar to the is_sony_vaio_laptop variable? Declare it extern in
| dmi_scan.c and declare it int pci-irq.c or the other way around? Would
| it have to be a global variable?
| 
| I'm not really a C coder (I don't even play one on TV), I just code by
| example...and I learn fairly quickly.
| 
| I'll call ALi USA tomorrow morning. I used their "tech support page",
| but got no response. Supposedly, Darlene Brown (in the San Jose, USA)
| office is the one to speak to (I spoke to a secretary today). The
| secretary told me they don't generally release datasheets to
| individuals, but maybe I can get ahold of one, who knows. I also emailed
| Dan Hollis, who posted looking for a datasheet a while ago, but he said
| he never got one.
