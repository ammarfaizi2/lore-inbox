Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129875AbQKQRXM>; Fri, 17 Nov 2000 12:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129931AbQKQRXC>; Fri, 17 Nov 2000 12:23:02 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:54537 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129875AbQKQRWr>;
	Fri, 17 Nov 2000 12:22:47 -0500
Message-ID: <3A15623E.5F21E230@mandrakesoft.com>
Date: Fri, 17 Nov 2000 11:52:14 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, mj@suse.cz
Subject: Re: VGA PCI IO port reservations
In-Reply-To: <200011171646.QAA01224@raistlin.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Jeff Garzik writes:
> > > For example, S3 cards typically use:
> > >
> > >  0x0102,  0x42e8,  0x46e8,  0x4ae8,  0x8180 - 0x8200,  0x82e8,  0x86e8,
> > >  0x8ae8,  0x8ee8,  0x92e8,  0x96e8,  0x9ae8,  0x9ee8,  0xa2e8,  0xa6e8,
> > >  0xaae8,  0xaee8,  0xb2e8,  0xb6e8,  0xbae8,  0xbee8,  0xe2e8,
> > >  0xff00 - 0xff44
>       ^^^^ PCI IO addresses

Oops, you're right :)


> If the driver isn't loaded, the port is still used by the hardware.  Therefore,
> it should be reserved independent of whether we have the driver loaded/in kernel
> or not.

That logic doesn't work.  If you believe that, then the core kernel
needs to be doing 100% of the request_region calls, right at bootup...

If XFree86 not fbdev is using the hardware, you can always have a stub
driver that does nothing but reserve the ports.  Remember, too, that the
ports claimed depend on register settings in the video card and PCI
config space..

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
