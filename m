Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262805AbSI2Qje>; Sun, 29 Sep 2002 12:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbSI2Qje>; Sun, 29 Sep 2002 12:39:34 -0400
Received: from transport.cksoft.de ([62.111.66.27]:19986 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S262805AbSI2Qjc>; Sun, 29 Sep 2002 12:39:32 -0400
Date: Sun, 29 Sep 2002 18:42:46 +0200 (CEST)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       <andre@master.linux-ide.org>
Subject: Re: v2.6 vs v3.0
In-Reply-To: <20020929153817.GC1014@suse.de>
Message-ID: <Pine.BSF.4.44.0209291805170.427-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, Jens Axboe wrote:

Hi,

> On Sun, Sep 29 2002, Alan Cox wrote:
> > On Sun, 2002-09-29 at 10:12, Jens Axboe wrote:
> > > 2.5 is definitely desktop stable, so please test it if you can. Until
> > > recently there was a personal show stopper for me, the tasklist
> > > deadlock. Now 2.5 is happily running on my desktop as well.
> >
> > Its very hard to make that assessment when the audio layer still doesnt
> > work, most scsi drivers havent been ported, most other drivers are full
> > of 2.4 fixed problems and so on.
>
> I can only talk for myself, 2.5 works fine here on my boxes. Dunno what
> you mean about audio layer, emu10k works for me.
>
> SCSI drivers can be a real problem. Not the porting of them, most of
[snip]

simply replying to one of you all ...

Most important problem I currently see is that one of two kernels
do not boot on my MP machine I use as a workstation.

Apart from that and after early 2.5.3x probs were sorted out
I already had 2.5-bk-kernels running and did the following on that
MP machine:

- compiled linux-2.5-bks
- compiled X (runs with multi head)
- listend to music (emu10k)
- watched TV (bttv)
- burned CDs (SCSI)
- ran amanda: dumped multiple input streams from network to IDE disks
  before writing to SCSI tape
- ran vmware (after patchwork to compile ;-)
- started looking at sym53c416 cli() removal and had the scanner
  doing his work (started to debug some pnp things there too, results
  to be posted)
- changed to devfs
- printing and serial are fine too
- the new input stuff now behaves properly too

often did multiple things in parallel (watching tv while compiling
a new kernel, ...)

had really few crashes (~4-6 since 2.5.34)
had some compilation probs with modules and MP but they got either
fixed too fast or patches went into bk within 1-2 days :-)

Going to check JFS (and XFS) in the near future...

So I think I am either one almost happy person with a lotta luck or
you all (did) do a very excellent job!!! ... but please get those
MP (boot) probs sorted out ;-)

Before you start asking what probs: this time it's around ACPI init.

--- snipp ---
PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20020918
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:......................................................................................................
Table [DSDT] - 309 Objects with 22 Devices 102 Methods 19 Regions
ACPI Namespace successfully loaded at root c03a741c
--- dead end where no keyboard or serial console sysreqs are answered ---


so it must be around ... and I assume it's mp_config_ioapic_for_sci()
but still have to trace ...

--- drivers/acpi/bus.c:606 ---
        /*
         * Get a separate copy of the FADT for use by other drivers.
         */
        status = acpi_get_table(ACPI_TABLE_FADT, 1, &buffer);
        if (ACPI_FAILURE(status)) {
                printk(KERN_ERR PREFIX "Unable to get the FADT\n");
                goto error1;
        }

#ifdef CONFIG_X86
        /* Ensure the SCI is set to level-triggered, active-low */
        if (acpi_ioapic)
                mp_config_ioapic_for_sci(acpi_fadt.sci_int);
        else
                eisa_set_level_irq(acpi_fadt.sci_int);
#endif

        status = acpi_enable_subsystem(ACPI_FULL_INITIALIZATION);
        if (ACPI_FAILURE(status)) {
                printk(KERN_ERR PREFIX "Unable to start the ACPI Interpreter\n");
                goto error1;
        }
--- end ---

-- 
Greetings

Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

