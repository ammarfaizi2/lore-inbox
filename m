Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280940AbRKCLMr>; Sat, 3 Nov 2001 06:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280941AbRKCLMi>; Sat, 3 Nov 2001 06:12:38 -0500
Received: from host213-121-105-27.in-addr.btopenworld.com ([213.121.105.27]:15569
	"HELO mail.dark.lan") by vger.kernel.org with SMTP
	id <S280940AbRKCLMd>; Sat, 3 Nov 2001 06:12:33 -0500
Subject: Re: [OT] Intel chipset development documents
From: Greg Sheard <greg@ecsc.co.uk>
To: Martin Mares <mj@ucw.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011103120455.B676@ucw.cz>
In-Reply-To: <1004721050.20610.7.camel@lemsip>
	<20011102183829.A31651@atrey.karlin.mff.cuni.cz>
	<1004735023.21120.12.camel@lemsip>  <20011103120455.B676@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.02.08.57 (Preview Release)
Date: 03 Nov 2001 11:12:04 +0000
Message-Id: <1004785924.23134.8.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-11-03 at 11:04, Martin Mares wrote:
> Hello!
> 
> > I already have the configuration type down (it's 1), but the 430VX and
> > also the VIA 585 seem only to report host bridges. I'm unable to spot
> > the piece of code which does different PCI-related things for these
> > chipsets in the kernel. Does anybody know if a workaround is applied?
> 
> It's quite strange -- can you send me 'lspci -vvx -MH1' output, please?
> 

Well I would, but with the assistance of Martin Bligh from IBM I've
found my bug. Major thinko - there seems to be something funky in the
440BX chipset that allowed me to do something like:

  outl(PCI_CONF1_ADDRESS(bus, 0, dev, fn), 0xCF8);

but still returned the correct PCI information! The problem was that I'd
done my own inline for the addressing and, since I wasn't using reg, I'd
left it out. Somehow I'd managed to shift the important stuff around...

Thanks to everyone who's offered suggestions and documents, it's much
appreciated.

Cheers,
Greg.

