Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSDLJRY>; Fri, 12 Apr 2002 05:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313479AbSDLJRX>; Fri, 12 Apr 2002 05:17:23 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:18701
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313477AbSDLJRX>; Fri, 12 Apr 2002 05:17:23 -0400
Date: Fri, 12 Apr 2002 02:15:28 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Re: VIA, 32bit PIO and 2.5.x kernel
In-Reply-To: <20020412084150.GE824@suse.de>
Message-ID: <Pine.LNX.4.10.10204120154480.489-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2002, Jens Axboe wrote:

> On Fri, Apr 12 2002, Petr Vandrovec wrote:
> > I believe that there must be some reason for doing that... And 
> > do not ask me why it worked in 2.4.x, as it cleared io_32bit
> > in task_out_intr too.
> 
> Because 2.4 doesn't use that path for fs requests. And be glad that it
> doesn't otherwise _everybody_ would have much worse problems than you
> are currently seeing.

Maybe if everyone ever bothered to look at the code base and not assume
they know everything ... and enjoying feable attempts to cast me as a
fool.  Better yet maybe understand the hardware ...

ata_input_data

        io_32bit = drive->io_32bit;

        if (io_32bit)
		insl(IDE_DATA_REG, buffer, wcount);
	else
                insw(IDE_DATA_REG, buffer, wcount<<1);

or 

ata_output_data

        io_32bit = drive->io_32bit;

        if (io_32bit)
                outsl(IDE_DATA_REG, buffer, wcount);
        else
                outsw(IDE_DATA_REG, buffer, wcount<<1);


WHOA is it not obvious it is the total number of calls to the same damn
DATA-TASKFILE-REGISTER-PORT

Which is only SIXTEEN BITS WIDE!

So please contine to write 32 bits to a 16 bit wide address...
Legacy or not the physical layer to the device, so please go look there.
Why do I even bother, all of you are so much smarter than me.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


