Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130447AbRCCLCC>; Sat, 3 Mar 2001 06:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130448AbRCCLBx>; Sat, 3 Mar 2001 06:01:53 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:8136 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S130447AbRCCLBi>;
	Sat, 3 Mar 2001 06:01:38 -0500
Message-ID: <3AA0CF0D.CB9D544C@mandrakesoft.com>
Date: Sat, 03 Mar 2001 06:01:33 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "David S. Miller" <davem@redhat.com>, linuxppc-dev@lists.linuxppc.org,
        linux-kernel@vger.kernel.org
Subject: Re: The IO problem on multiple PCI busses
In-Reply-To: <15008.17278.154154.210086@pizda.ninka.net> <19350125195650.22439@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> 
> >No, don't do this, it is evil.  Use mappings, specify the device
> >related info somehow when creating the mapping (in the userspace
> >variant you do this by openning a specific device to mmap, in the
> >kernel variant you can encode the bus/dev/etc. info in the device's
> >resource and decode this at ioremap() time, see?).
> 
> Well, except that drivers doing IOs don't ioremap...
> 
> Maybe we could define an ioremap-like function for IOs, but the more

I/O is not supposed to be fast, that's what MMIO is for. :)  Just do

void outb (u8 val, u16 addr)
{
	void *addr = ioremap (ISA_IO_BASE + addr);
	if (addr) {
		writeb (val, addr);
		iounmap (addr);
	}
}

You can map and unmap for each call :)  Ugly and slow, but hey, it's
I/O...

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
