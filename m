Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130889AbQKQRaw>; Fri, 17 Nov 2000 12:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130890AbQKQRam>; Fri, 17 Nov 2000 12:30:42 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:62985 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130889AbQKQRae>;
	Fri, 17 Nov 2000 12:30:34 -0500
Message-ID: <3A156422.7D1D3DBD@mandrakesoft.com>
Date: Fri, 17 Nov 2000 12:00:18 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org,
        mj@suse.cz
Subject: Re: VGA PCI IO port reservations
In-Reply-To: <200011171656.QAA01320@raistlin.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Brian Gerst writes:
> > This is an artifact from the ISA 10-bit IO bus.  Many ISA cards do not
> > decode all 16 address bits so you get aliases of the 0x100-0x3ff region
> > throughout IO space.  PCI cards should only use the first 256 ports of
> > any 1k block to avoid aliases unless they claim the base alias.  For
> > example, all the xxe8 addresses for the S3 are aliases of 0x02e8 to an
> > ISA card.  Video cards are an exception to the general rule because they
> > have to support all the legacy VGA crap.
> 
> No.  All xxe8 addresses access specific registers.  For example:
> 
>   0x9ea8 is the drawing command
>   0xa2e8 is the background colour register
>   0xa6e8 is the foreground colour register
> 
> So, as you see they aren't aliases.

Oh yeah, if you are writing for S3 specifically, you can do 100% MMIO,
and simply turn off all I/O decoding.  Check out Keith Packard's
kdrive/s3trio in the XFree86 tree...

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
