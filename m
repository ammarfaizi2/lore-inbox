Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263089AbRFNPaX>; Thu, 14 Jun 2001 11:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263217AbRFNPaE>; Thu, 14 Jun 2001 11:30:04 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:42127 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263089AbRFNP3z>;
	Thu, 14 Jun 2001 11:29:55 -0400
Message-ID: <3B28D870.179876B1@mandrakesoft.com>
Date: Thu, 14 Jun 2001 11:29:52 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: Tom Gall <tom_gall@vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <3B273A20.8EE88F8F@vnet.ibm.com>
		<3B28C6C1.3477493F@mandrakesoft.com>
		<15144.51504.8399.395200@pizda.ninka.net>
		<3B28CB1A.E8226801@mandrakesoft.com> <15144.52565.566355.291642@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> Jeff Garzik writes:
>  > Why do you want to make the bus number larger than the PCI bus number
>  > register?
> 
> This isn't it.  What I'm trying to provoke thought on is
> "is there a way to make mindless apps using these syscalls
> work transparently"
> 
> I think the answer is no.  Apps should really fetch info out
> of /proc/bus/pci and use the controller ioctl.
> 
> But someone could surprise me :-)

yeah, those syscalls weren't built with much eye towards the future. 
And I don't think they are present in other OS's either...


>  > It seems like adding 'unsigned int domain_num' makes more sense, and is
>  > more correct.  Maybe that implies fixing up other code to use a
>  > (domain,bus) pair, but that's IMHO a much better change than totally
>  > changing the interpretation of pci_bus::bus_number...
> 
> Correct, I agree.  But I don't even believe we should be sticking
> the domain thing into struct pci_bus.
> 
> It's a platform thing.  Most platforms have a single domain, so why
> clutter up struct pci_bus with this value?  By this reasoning we could
> say that since it's arch-specific, this stuff belongs in sysdata or
> wherever.

Pretty much any arch with a PCI slot can have multiple domains, now that
hotplug controllers are out and about.  So it seems a generic enough
concept to me...


> And this is what is happening right now.  So in essence, the work is
> done :-)  The only "limiting factor" is that x86 doesn't support
> multiple domains as some other platforms do.  So all these hot-plug
> patches just need to use domains properly, and perhaps add domain
> support to X86 when one of these hot-plug capable controllers are
> being used.

point.

Regards,

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
