Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311247AbSCWUYg>; Sat, 23 Mar 2002 15:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311252AbSCWUY0>; Sat, 23 Mar 2002 15:24:26 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:15021 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S311247AbSCWUYO>;
	Sat, 23 Mar 2002 15:24:14 -0500
Date: Sat, 23 Mar 2002 21:23:41 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: John Langford <jcl@cs.cmu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, ahaas@neosoft.com, dave@zarzycki.org,
        ben.de.rydt@pandora.be
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
Message-ID: <20020323212341.A5721@ucw.cz>
In-Reply-To: <200203221956.g2MJuhK32671@gs176.sp.cs.cmu.edu> <3C9C7EF9.8020307@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2002 at 02:11:21PM +0100, Martin Dalecki wrote:
> John Langford wrote:
> > I went nuts with printk statements and managed to isolate the hang to
> > one particular line of code.  The final printk in this code fragment
> > never gets executed.  
> > 
> >                 } else if (m5229_revision >= 0xC3) {
> > 		        /*
> >                          * 1553/1535 (m1533, 0x79, bit 1)
> >                          */
> >                         printk("ata66_ali15x3           } else if (m5229_revisi\on >= 0xC3) {\n");
> >                         pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
> 
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> pci_write_config to isa_dev???? This looks at least suspicious.
> You may very well check whatever isa_dev is trully a PCI device
> handle or just some random IO base for ISA bus!

You may wanted to check yourself:

isa_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);

so the command is valid.

> >                 printk("ata66_ali15x3 endif\n");
> > 
> > Art, Dave, and Ben may or may not have the same problem.  It would be
> > interesting to know if they get a hang here.
> > 
> > Any ideas for fixing?
> 
> See above :-)

-- 
Vojtech Pavlik
SuSE Labs
