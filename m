Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSEHUbj>; Wed, 8 May 2002 16:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSEHUbi>; Wed, 8 May 2002 16:31:38 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:26382
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315119AbSEHUbh>; Wed, 8 May 2002 16:31:37 -0400
Date: Wed, 8 May 2002 13:29:09 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Bjorn Wesen <bjorn.wesen@axis.com>, Paul Mackerras <paulus@samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
In-Reply-To: <E175Y6N-0002Jj-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10205081319400.30697-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan, we talked about this and the driver/hardware has a flaw.
If you count the total number of single IO operations to check
status/error et al., it is out right fugly.  Preprocessing will kill us
like today.


On Wed, 8 May 2002, Alan Cox wrote:

> > ata_channel (or ata_drive, but I doubt that would be really
> > necessary) a set of 4 access functions: taskfile_in/out for
> > access to taskfile registers (8 bits), and data_in/out for
> > steaming datas in/out of the data reg (16 bits).
> 
> Please push it higher level than that. Load the taskfile as a set in
> each method. Remember its 1 potentially paired instruction to do an MMIO
> write, its a whole mess of synchronziation and stalls to do a function 
> pointer.
> 
> > address at all (that is kill the array of port addresses) but
> > just pass the taskfile_in/out functions the register number
> > (cyl_hi, cyl_lo, select, ....) as a nice symbolic constant,
> > and let the channel specific implementation figure it out.
> 
> Pass  dev->taskfile_load() a struct at least for the common paths. Make the
> PIO block transfers also single callbacks for each block not word.
> 
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group


