Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129537AbRBVInW>; Thu, 22 Feb 2001 03:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129546AbRBVInC>; Thu, 22 Feb 2001 03:43:02 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:29200 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129537AbRBVIm5>;
	Thu, 22 Feb 2001 03:42:57 -0500
Date: Thu, 22 Feb 2001 09:42:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Catalin BOIE <util@deuroconsult.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via UDMA5 3/4/5 is not functional!
Message-ID: <20010222094247.A9616@suse.cz>
In-Reply-To: <Pine.LNX.4.20.0102221004440.22238-100000@marte.Deuroconsult.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.20.0102221004440.22238-100000@marte.Deuroconsult.com>; from util@deuroconsult.ro on Thu, Feb 22, 2001 at 10:09:29AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 22, 2001 at 10:09:29AM +0200, Catalin BOIE wrote:
> Hi, guys!
> 
> I want to report a problem.
> 
> I have an Athlon 900MHz / 256 MB RAM, chipset: VIA VT82c686B, IBM
> harddrive (IBM-DTLA-307030).
> 
> At first I tried kernel 2.2.16:
> 	- hdparm -u1 -d1 -X69 /dev/hda => I get 36MB/s
> 
> Then I tried kernel 2.4.1. I issued exactly the same hdparm command.
> i got in syslog the message: "ide0: Speed warnings UDMA 3/4/5 is not
> functional"!
> 
> What is the problem?

The 80-wire cable was not detected. Try this driver ...

-- 
Vojtech Pavlik
SuSE Labs

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-timing.h"

#ifndef _IDE_TIMING_H
#define _IDE_TIMING_H

/*
 * $Id: ide-timing.h,v 2.1 2001/02/08 19:32:56 vojtech Exp $
 *
 *  Copyright (c) 1999-2000 Vojtech Pavlik
 *
 *  Sponsored by SuSE
 */

/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 * Should you need to contact me, the author, you can do so either by
 * e-mail - mail your message to <vojtech@suse.cz>, or by paper mail:
 * Vojtech Pavlik, Ucitelska 1576, Prague 8, 182 00 Czech Republic
 */

#include <linux/hdreg.h>
#include <linux/delay.h>

#define XFER_PIO_5		0x0d
#define XFER_UDMA_SLOW		0x4f

struct ide_timing {
	short mode;
	short setup;	/* t1 */
	short act8b;	/* t2 for 8-bit io */
	short rec8b;	/* t2i for 8-bit io */
	short cyc8b;	/* t0 for 8-bit io */
	short active;	/* t2 or tD */
	short recover;	/* t2i or tK */
	short cycle;	/* t0 */
	short udma;	/* t2CYCTYP/2 */
};

/*
 * PIO 0-5, MWDMA 0-2 and UDMA 0-5 timings (in nanoseconds).
 * These were taken from ATA/ATAPI-6 standard, rev 0a, except
 * for PIO 5, which is a nonstandard extension.
 */

static struct ide_timing ide_timing[] = {

	{ XFER_UDMA_5,     0,   0,   0,   0,   0,   0,   0,  20 },
	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0,   0,  30 },
	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0,   0,  45 },

	{ XFER_UDMA_2,     0,   0,   0,   0,   0,   0,   0,  60 },
	{ XFER_UDMA_1,     0,   0,   0,   0,   0,   0,   0,  80 },
	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0,   0, 120 },

	{ XFER_UDMA_SLOW,  0,   0,   0,   0,   0,   0,   0, 150 },
                                          
	{ XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 120,   0 },
	{ XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 150,   0 },
	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 480,   0 },
                                          
	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 240,   0 },
	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 480,   0 },
	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 960,   0 },

	{ XFER_PIO_5,     20,  50,  30, 100,  50,  30, 100,   0 },
	{ XFER_PIO_4,     25,  70,  25, 120,  70,  25, 120,   0 },
	{ XFER_PIO_3,     30,  80,  70, 180,  80,  70, 180,   0 },

	{ XFER_PIO_2,     30, 290,  40, 330, 100,  90, 240,   0 },
	{ XFER_PIO_1,     50, 290,  93, 383, 125, 100, 383,   0 },
	{ XFER_PIO_0,     70, 290, 240, 600, 165, 150, 600,   0 },

	{ XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 960,   0 },

	{ -1 }
};

#define IDE_TIMING_SETUP	0x01
#define IDE_TIMING_ACT8B	0x02
#define IDE_TIMING_REC8B	0x04
#define IDE_TIMING_CYC8B	0x08
#define IDE_TIMING_8BIT		0x0e
#define IDE_TIMING_ACTIVE	0x10
#define IDE_TIMING_RECOVER	0x20
#define IDE_TIMING_CYCLE	0x40
#define IDE_TIMING_UDMA		0x80
#define IDE_TIMING_ALL		0xff

#define MIN(a,b)	((a)<(b)?(a):(b))
#define MAX(a,b)	((a)>(b)?(a):(b))
#define FIT(v,min,max)	MAX(MIN(v,max),min)
#define ENOUGH(v,unit)	(((v)-1)/(unit)+1)
#define EZ(v,unit)	((v)?ENOUGH(v,unit):0)

#define XFER_MODE	0xf0
#define XFER_UDMA_100	0x44
#define XFER_UDMA_66	0x42
#define XFER_UDMA	0x40
#define XFER_MWDMA	0x20
#define XFER_SWDMA	0x10
#define XFER_EPIO	0x01
#define XFER_PIO	0x00

static short ide_find_best_mode(ide_drive_t *drive, int map)
{
	struct hd_driveid *id = drive->id;
	short best = 0;

	if (!id)
		return XFER_PIO_SLOW;

	if ((map & XFER_UDMA) && (id->field_valid & 4)) {	/* Want UDMA and UDMA bitmap valid */

		if ((map & XFER_UDMA_100) == XFER_UDMA_100)
			if ((best = (id->dma_ultra & 0x0020) ? XFER_UDMA_5 : 0)) return best;

		if ((map & XFER_UDMA_66) == XFER_UDMA_66)
			if ((best = (id->dma_ultra & 0x0010) ? XFER_UDMA_4 :
                	    	    (id->dma_ultra & 0x0008) ? XFER_UDMA_3 : 0)) return best;

                if ((best = (id->dma_ultra & 0x0004) ? XFER_UDMA_2 :
                	    (id->dma_ultra & 0x0002) ? XFER_UDMA_1 :
                	    (id->dma_ultra & 0x0001) ? XFER_UDMA_0 : 0)) return best;
	}

	if ((map & XFER_MWDMA) && (id->field_valid & 2)) {	/* Want MWDMA and drive has EIDE fields */

		if ((best = (id->dma_mword & 0x0004) ? XFER_MW_DMA_2 :
                	    (id->dma_mword & 0x0002) ? XFER_MW_DMA_1 :
                	    (id->dma_mword & 0x0001) ? XFER_MW_DMA_0 : 0)) return best;
	}

	if (map & XFER_SWDMA) {					/* Want SWDMA */

 		if (id->field_valid & 2) {			/* EIDE SWDMA */

			if ((best = (id->dma_1word & 0x0004) ? XFER_SW_DMA_2 :
      				    (id->dma_1word & 0x0002) ? XFER_SW_DMA_1 :
				    (id->dma_1word & 0x0001) ? XFER_SW_DMA_0 : 0)) return best;
		}

		if (id->capability & 1) {			/* Pre-EIDE style SWDMA */

			if ((best = (id->tDMA == 2) ? XFER_SW_DMA_2 :
				    (id->tDMA == 1) ? XFER_SW_DMA_1 :
				    (id->tDMA == 0) ? XFER_SW_DMA_0 : 0)) return best;
		}
	}


	if ((map & XFER_EPIO) && (id->field_valid & 2)) {	/* EIDE PIO modes */

		if ((best = (drive->id->eide_pio_modes & 4) ? XFER_PIO_5 :
			    (drive->id->eide_pio_modes & 2) ? XFER_PIO_4 :
			    (drive->id->eide_pio_modes & 1) ? XFER_PIO_3 : 0)) return best;
	}
	
	return  (drive->id->tPIO == 2) ? XFER_PIO_2 :
		(drive->id->tPIO == 1) ? XFER_PIO_1 :
		(drive->id->tPIO == 0) ? XFER_PIO_0 : XFER_PIO_SLOW;
}

static void ide_timing_quantize(struct ide_timing *t, struct ide_timing *q, int T, int UT)
{
	q->setup   = EZ(t->setup,   T);
	q->act8b   = EZ(t->act8b,   T);
	q->rec8b   = EZ(t->rec8b,   T);
	q->cyc8b   = EZ(t->cyc8b,   T);
	q->active  = EZ(t->active,  T);
	q->recover = EZ(t->recover, T);
	q->cycle   = EZ(t->cycle,   T);
	q->udma    = EZ(t->udma,   UT);
}

static void ide_timing_merge(struct ide_timing *a, struct ide_timing *b, struct ide_timing *m, unsigned int what)
{
	if (what & IDE_TIMING_SETUP  ) m->setup   = MAX(a->setup,   b->setup);
	if (what & IDE_TIMING_ACT8B  ) m->act8b   = MAX(a->act8b,   b->act8b);
	if (what & IDE_TIMING_REC8B  ) m->rec8b   = MAX(a->rec8b,   b->rec8b);
	if (what & IDE_TIMING_CYC8B  ) m->cyc8b   = MAX(a->cyc8b,   b->cyc8b);
	if (what & IDE_TIMING_ACTIVE ) m->active  = MAX(a->active,  b->active);
	if (what & IDE_TIMING_RECOVER) m->recover = MAX(a->recover, b->recover);
	if (what & IDE_TIMING_CYCLE  ) m->cycle   = MAX(a->cycle,   b->cycle);
	if (what & IDE_TIMING_UDMA   ) m->udma    = MAX(a->udma,    b->udma);
}

static struct ide_timing* ide_timing_find_mode(short speed)
{
	struct ide_timing *t;

	for (t = ide_timing; t->mode != speed; t++)
		if (t->mode < 0)
			return NULL;
	return t; 
}

static int ide_timing_compute(ide_drive_t *drive, short speed, struct ide_timing *t, int T, int UT)
{
	struct hd_driveid *id = drive->id;
	struct ide_timing *s, p;

/*
 * Find the mode.
 */

	if (!(s = ide_timing_find_mode(speed)))
		return -EINVAL;

/*
 * If the drive is an EIDE drive, it can tell us it needs extended
 * PIO/MWDMA cycle timing.
 */

	if (id && id->field_valid & 2) {	/* EIDE drive */

		memset(&p, 0, sizeof(p));

		switch (speed & XFER_MODE) {

			case XFER_PIO:
				if (speed <= XFER_PIO_2) p.cycle = p.cyc8b = id->eide_pio;
						    else p.cycle = p.cyc8b = id->eide_pio_iordy;
				break;

			case XFER_MWDMA:
				p.cycle = id->eide_dma_min;
				break;
		}

		ide_timing_merge(&p, t, t, IDE_TIMING_CYCLE | IDE_TIMING_CYC8B);
	}

/*
 * Convert the timing to bus clock counts.
 */

	ide_timing_quantize(s, t, T, UT);

/*
 * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, S.M.A.R.T
 * and some other commands. We have to ensure that the DMA cycle timing is
 * slower/equal than the fastest PIO timing.
 */

	if ((speed & XFER_MODE) != XFER_PIO) {
		ide_timing_compute(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO), &p, T, UT);
		ide_timing_merge(&p, t, t, IDE_TIMING_ALL);
	}

/*
 * Lenghten active & recovery time so that cycle time is correct.
 */

	if (t->act8b + t->rec8b < t->cyc8b) {
		t->act8b += (t->cyc8b - (t->act8b + t->rec8b)) / 2;
		t->rec8b = t->cyc8b - t->act8b;
	}

	if (t->active + t->recover < t->cycle) {
		t->active += (t->cycle - (t->active + t->recover)) / 2;
		t->recover = t->cycle - t->active;
	}

	return 0;
}

#ifdef __i386__
#ifdef CONFIG_X86_TSC
#define GET_TIME(x)     __asm__ __volatile__ ( "rdtsc" : "=a" (x) : : "dx" )
#define DELTA(x,y)      ((y)-(x))
#define TIME_NAME "TSC"
#else
#define GET_TIME(x)     do { outb(0, 0x43); x = inb(0x40); x |= inb(0x40) << 8; } while (0)
#define DELTA(x,y)      ((x)-(y)+((x)<(y)?1193180L/HZ:0))
#define TIME_NAME "PIT"
#endif
#elif __alpha__
#define GET_TIME(x)     __asm__ __volatile__ ( "rpcc %0" : "=r" (x) )
#define DELTA(x,y)      ((y)-(x))
#define TIME_NAME "PCC"
#endif

static unsigned int ide_timing_calibrate_timer(void)
{
        unsigned int t1, t2;
        unsigned long flags;

        __save_flags(flags);
        __cli();
        GET_TIME(t1);
        udelay(1000);
        GET_TIME(t2);
        __restore_flags(flags);

        return DELTA(t1, t2);
}

static int ide_timing_measure_xfer(ide_drive_t *drive)
{
	unsigned long timeout, flags;
	__u32 buf[SECTOR_WORDS * 4];
	unsigned int start, end;

	if (IDE_CONTROL_REG)
		OUT_BYTE(drive->ctl, IDE_CONTROL_REG);

	ide_delay_50ms();

	if (drive->media != ide_disk) {
		OUT_BYTE(0, IDE_FEATURE_REG); 
		OUT_BYTE(WIN_PIDENTIFY, IDE_COMMAND_REG);
	} else
		OUT_BYTE(WIN_IDENTIFY, IDE_COMMAND_REG);

	timeout = jiffies + WAIT_WORSTCASE;
	do {
		if (0 < (signed long)(jiffies - timeout))
			return -1;
		ide_delay_50ms();
	} while (IN_BYTE(IDE_ALTSTATUS_REG) & BUSY_STAT);

	ide_delay_50ms();

	if (!OK_STAT(GET_STAT(), DRQ_STAT, BAD_R_STAT))
		return -1;

	__save_flags(flags);
	__cli();
	GET_TIME(start);	
	ide_input_data(drive, buf, SECTOR_WORDS);
	GET_TIME(end);
	GET_STAT();
	__restore_flags(flags);	

	ide_delay_50ms();

	return DELTA(start, end);
}

#endif

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via82cxxx.c"

/*
 * $Id: via82cxxx.c,v 4.3 2001/02/21 08:10:60 vojtech Exp $
 *
 *  Copyright (c) 2000-2001 Vojtech Pavlik
 *
 *  Based on the work of:
 *	Michel Aubry
 *	Jeff Garzik
 *	Andre Hedrick
 *
 *  Sponsored by SuSE
 */

/*
 * VIA IDE driver for Linux. Supports
 *
 *   vt82c586, vt82c586a, vt82c586b, vt82c596a, vt82c596b,
 *   vt82c686, vt82c686a, vt82c686b, vt8231, vt8233
 *
 * southbridges, which can be found in
 *
 *  VIA Apollo VP, VPX, VPX/97, VP2, VP2/97, VP3, MVP3, MVP4, P6, Pro,
 *  Pro Plus, Pro 133, Pro 133A, ProMedia PM601, ProSavage PM133, PLE133,
 *  Pro 266, KX133, KT133, ProSavage KM133, KT133A, KT266
 *  PC-Chips VXPro, VXPro+, TXPro-III, TXPro-AGP, ViaGra, BXToo, BXTel
 *  AMD 640, 640 AGP, 750 IronGate
 *  ETEQ 6618, 6628, 6638
 *  Micron Samurai
 *
 * chipsets. Supports
 *
 *   PIO 0-5, MWDMA 0-2, SWDMA 0-2 and UDMA 0-5
 *
 * (this includes UDMA33, 66 and 100) modes. UDMA66 and higher modes are
 * autoenabled only in case the BIOS has detected a 80 wire cable. To ignore
 * the BIOS data and assume the cable is present, use 'ide0=ata66' or
 * 'ide1=ata66' on the kernel command line.
 */

/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 * Should you need to contact me, the author, you can do so either by
 * e-mail - mail your message to <vojtech@suse.cz>, or by paper mail:
 * Vojtech Pavlik, Ucitelska 1576, Prague 8, 182 00 Czech Republic
 */

#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/ioport.h>
#include <linux/blkdev.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/ide.h>
#include <asm/io.h>

#include "ide-timing.h"

#define VIA_IDE_ENABLE		0x40
#define VIA_IDE_CONFIG		0x41
#define VIA_FIFO_CONFIG		0x43
#define VIA_MISC_1		0x44
#define VIA_MISC_2		0x45
#define VIA_MISC_3		0x46
#define VIA_DRIVE_TIMING	0x48
#define VIA_8BIT_TIMING		0x4e
#define VIA_ADDRESS_SETUP	0x4c
#define VIA_UDMA_TIMING		0x50

#define VIA_UDMA		0x07
#define VIA_UDMA_NONE		0x00
#define VIA_UDMA_33		0x01
#define VIA_UDMA_66		0x02
#define VIA_UDMA_100		0x03
#define VIA_BAD_PREQ		0x10	/* Crashes if PREQ# till DDACK# set */
#define VIA_BAD_CLK66		0x20	/* 66 MHz clock doesn't work correctly */
#define VIA_SET_FIFO		0x40	/* Needs to have FIFO split set */
#define VIA_SET_THRESH		0x80	/* Needs to have FIFO thresholds set */
#define VIA_BAD_PIO		0x80	/* Always uses 25 PCICLK/xfer regardles of PIO mode */

/*
 * VIA SouthBridge chips.
 */

static struct via_isa_bridge {
	char *name;
	unsigned short id;
	unsigned char rev_min;
	unsigned char rev_max;
	unsigned char flags;
} via_isa_bridges[] = {
#ifdef VIA_NEW_BRIDGES_TESTED
	{ "vt8233",	PCI_DEVICE_ID_VIA_8233_0,   0x00, 0x2f, VIA_UDMA_100 },
	{ "vt8231",	PCI_DEVICE_ID_VIA_8231,     0x00, 0x2f, VIA_UDMA_66 },
#endif
	{ "vt82c686b",	PCI_DEVICE_ID_VIA_82C686,   0x40, 0x4f, VIA_UDMA_100 | VIA_BAD_PIO },
	{ "vt82c686a",	PCI_DEVICE_ID_VIA_82C686,   0x10, 0x2f, VIA_UDMA_66 },
	{ "vt82c686",	PCI_DEVICE_ID_VIA_82C686,   0x00, 0x0f, VIA_UDMA_33 | VIA_BAD_CLK66 },
	{ "vt82c596b",	PCI_DEVICE_ID_VIA_82C596,   0x12, 0x2f, VIA_UDMA_66 },
	{ "vt82c596a",	PCI_DEVICE_ID_VIA_82C596,   0x00, 0x0f, VIA_UDMA_33 | VIA_BAD_CLK66 },
	{ "vt82c586b",	PCI_DEVICE_ID_VIA_82C586_0, 0x40, 0x4f, VIA_UDMA_33 | VIA_SET_FIFO | VIA_BAD_PREQ },
	{ "vt82c586b",	PCI_DEVICE_ID_VIA_82C586_0, 0x30, 0x3f, VIA_UDMA_33 | VIA_SET_FIFO },
	{ "vt82c586a",	PCI_DEVICE_ID_VIA_82C586_0, 0x20, 0x2f, VIA_UDMA_33 | VIA_SET_FIFO },
	{ "vt82c586",	PCI_DEVICE_ID_VIA_82C586_0, 0x00, 0x0f, VIA_UDMA_NONE | VIA_SET_FIFO },
	{ NULL }
};

static struct via_isa_bridge *via_config;
static unsigned char via_enabled;
static unsigned int via_80w;
static unsigned int via_clock;

/*
 * VIA /proc entry.
 */

#ifdef CONFIG_PROC_FS

#include <linux/stat.h>
#include <linux/proc_fs.h>

int via_proc, via_base;
static struct pci_dev *bmide_dev, *isa_dev;
extern int (*via_display_info)(char *, char **, off_t, int); /* ide-proc.c */

static char *via_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100" };
static char *via_control3[] = { "No limit", "64", "128", "192" };

#define via_print(format, arg...) p += sprintf(p, format "\n" , ## arg)
#define via_print_drive(name, format, arg...)\
	p += sprintf(p, name); for (i = 0; i < 4; i++) p += sprintf(p, format, ## arg); p += sprintf(p, "\n");

static int via_get_info(char *buffer, char **addr, off_t offset, int count)
{
	short speed[4], cycle[4], setup[4], active[4], recover[4], den[4],
		 uen[4], udma[4], umul[4], active8b[4], recover8b[4];
	struct pci_dev *dev = bmide_dev;
	unsigned int v, u, i;
	unsigned short c, w;
	unsigned char t, x;
	char *p = buffer;

	via_print("----------VIA BusMastering IDE Configuration----------------");

	via_print("Driver Version:                     4.3");
	via_print("South Bridge:                       VIA %s", via_config->name);

	pci_read_config_byte(isa_dev, PCI_REVISION_ID, &t);
	pci_read_config_byte(dev, PCI_REVISION_ID, &x);
	via_print("Revision:                           ISA %#x IDE %#x", t, x);
	via_print("Highest DMA rate:                   %s", via_dma[via_config->flags & VIA_UDMA]);

	via_print("BM-DMA base:                        %#x", via_base);
	via_print("PCI clock:                          %dMHz", via_clock);

	pci_read_config_byte(dev, VIA_MISC_1, &t);
	via_print("Master Read  Cycle IRDY:            %dws", (t & 64) >> 6);
	via_print("Master Write Cycle IRDY:            %dws", (t & 32) >> 5);
	via_print("BM IDE Status Register Read Retry:  %s", (t & 8) ? "yes" : "no");

	pci_read_config_byte(dev, VIA_MISC_3, &t);
	via_print("Max DRDY Pulse Width:               %s%s", via_control3[(t & 0x03)], (t & 0x03) ? " PCI clocks" : "");

	via_print("-----------------------Primary IDE-------Secondary IDE------");
	via_print("Read DMA FIFO flush:   %10s%20s", (t & 0x80) ? "yes" : "no", (t & 0x40) ? "yes" : "no");
	via_print("End Sector FIFO flush: %10s%20s", (t & 0x20) ? "yes" : "no", (t & 0x10) ? "yes" : "no");

	pci_read_config_byte(dev, VIA_IDE_CONFIG, &t);
	via_print("Prefetch Buffer:       %10s%20s", (t & 0x80) ? "yes" : "no", (t & 0x20) ? "yes" : "no");
	via_print("Post Write Buffer:     %10s%20s", (t & 0x40) ? "yes" : "no", (t & 0x10) ? "yes" : "no");

	pci_read_config_byte(dev, VIA_IDE_ENABLE, &t);
	via_print("Enabled:               %10s%20s", (t & 0x02) ? "yes" : "no", (t & 0x01) ? "yes" : "no");

	c = inb(via_base + 0x02) | (inb(via_base + 0x0a) << 8);
	via_print("Simplex only:          %10s%20s", (c & 0x80) ? "yes" : "no", (c & 0x8000) ? "yes" : "no");

	via_print("Cable Type:            %10s%20s", (via_80w & 1) ? "80w" : "40w", (via_80w & 2) ? "80w" : "40w");

	if (!via_clock)
		return p - buffer;

	via_print("-------------------drive0----drive1----drive2----drive3-----");

	pci_read_config_byte(dev, VIA_ADDRESS_SETUP, &t);
	pci_read_config_dword(dev, VIA_DRIVE_TIMING, &v);
	pci_read_config_word(dev, VIA_8BIT_TIMING, &w);

	if (via_config->flags & VIA_UDMA)
		pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
	else u = 0;

	for (i = 0; i < 4; i++) {

		setup[i]     = ((t >> ((3 - i) << 1)) & 0x3) + 1;
		recover8b[i] = ((w >> ((1 - (i >> 1)) << 3)) & 0xf) + 1;
		active8b[i]  = ((w >> (((1 - (i >> 1)) << 3) + 4)) & 0xf) + 1;
		active[i]    = ((v >> (((3 - i) << 3) + 4)) & 0xf) + 1;
		recover[i]   = ((v >> ((3 - i) << 3)) & 0xf) + 1;
		udma[i]      = ((u >> ((3 - i) << 3)) & 0x7) + 2;
		umul[i]      = ((u >> (((3 - i) & 2) << 3)) & 0x8) ? 1 : 2;
		uen[i]       = ((u >> ((3 - i) << 3)) & 0x20);
		den[i]       = (c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2));

		speed[i] = 20 * via_clock / (active[i] + recover[i]);
		cycle[i] = 1000 / via_clock * (active[i] + recover[i]);

		if (!uen[i] || !den[i])
			continue;

		switch (via_config->flags & VIA_UDMA) {
			
			case VIA_UDMA_100:
				speed[i] = 2000 / udma[i];
				cycle[i] = 10 * udma[i];
				break;

			case VIA_UDMA_66:
				speed[i] = 40 * via_clock / (udma[i] * umul[i]);
				cycle[i] = 500 / via_clock * (udma[i] * umul[i]);
				break;

			case VIA_UDMA_33:
				speed[i] = 20 * via_clock / udma[i];
				cycle[i] = 1000 / via_clock * udma[i];
				break;
		}
	}

	via_print_drive("Transfer Mode: ", "%10s", den[i] ? (uen[i] ? "UDMA" : "DMA") : "PIO");

	via_print_drive("Address Setup: ", "%8dns", (1000 / via_clock) * setup[i]);
	via_print_drive("Cmd Active:    ", "%8dns", (1000 / via_clock) * active8b[i]);
	via_print_drive("Cmd Recovery:  ", "%8dns", (1000 / via_clock) * recover8b[i]);
	via_print_drive("Data Active:   ", "%8dns", (1000 / via_clock) * active[i]);
	via_print_drive("Data Recovery: ", "%8dns", (1000 / via_clock) * recover[i]);
	via_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
	via_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 10, speed[i] % 10);

	return p - buffer;	/* hoping it is less than 4K... */
}

#endif

/*
 * via_set_speed() writes timing values to the chipset registers
 */

static void via_set_speed(struct pci_dev *dev, unsigned char dn, struct ide_timing *timing)
{
	unsigned char t;

	pci_read_config_byte(dev, VIA_ADDRESS_SETUP, &t);
	t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
	pci_write_config_byte(dev, VIA_ADDRESS_SETUP, t);

	pci_write_config_byte(dev, VIA_8BIT_TIMING + (1 - (dn >> 1)),
		((FIT(timing->act8b, 1, 16) - 1) << 4) | (FIT(timing->rec8b, 1, 16) - 1));

	pci_write_config_byte(dev, VIA_DRIVE_TIMING + (3 - dn),
		((FIT(timing->active, 1, 16) - 1) << 4) | (FIT(timing->recover, 1, 16) - 1));

	switch (via_config->flags & VIA_UDMA) {
		case VIA_UDMA_33:  t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
		case VIA_UDMA_66:  t = timing->udma ? (0xe8 | (FIT(timing->udma, 2, 9) - 2)) : 0x0f; break;
		case VIA_UDMA_100: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 9) - 2)) : 0x07; break;
		default: return;
	}

	pci_write_config_byte(dev, VIA_UDMA_TIMING + (3 - dn), t);
}

/*
 * via_calibrate_pci_clock() calibrates the PCI clock using IDENTIFY transfers
 * in PIO mode.  It does this by measuring the time it takes to transfer the sector
 * at PIO_SLOW speed.
 */

static int via_calibrate_pci_clock(ide_drive_t *drive)
{
	struct ide_timing t;
	int time, clock, speed;
	
	printk(KERN_INFO "VP_IDE: Calibrating PCI clock ...");

	clock = ide_timing_calibrate_timer();
	ide_timing_compute(drive, XFER_PIO_SLOW, &t, 20, 10);		/* Assume 50 MHz PCI max */

	via_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);
	if ((time = ide_timing_measure_xfer(drive)) <= 0) {		/* Measurement failed */
		printk(" failed.\n");
		return system_bus_clock();
	}

	speed = clock * 256 / time *					/* 256 words, 32 PCI clocks per word */
		(via_config->flags & VIA_BAD_PIO ? 26 : 32);		/* PIO programming doesn't work */

	printk(" %d.%02d MHz\n", speed / 1000, speed % 1000 / 10);

	return (speed + 500) / 1000;
}	

/*
 * via_set_drive() computes timing values configures the drive and
 * the chipset to a desired transfer mode. It also can be called
 * by upper layers.
 */

static int via_set_drive(ide_drive_t *drive, unsigned char speed)
{
	ide_drive_t *peer = HWIF(drive)->drives + (~drive->dn & 1);
	struct ide_timing t, p;
	int T, UT;

	if (!via_clock)
		via_clock = via_calibrate_pci_clock(drive);

	if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
		if (ide_config_drive_speed(drive, speed))
			printk(KERN_WARNING "ide%d: Drive %d didn't accept speed setting. Oh, well.\n",
				drive->dn >> 1, drive->dn & 1);

	T = 1000 / via_clock;

	switch (via_config->flags & VIA_UDMA) {
		case VIA_UDMA_33:   UT = T;   break;
		case VIA_UDMA_66:   UT = T/2; break;
		case VIA_UDMA_100:  UT = 10;  break;
		default:	    UT = T;   break;
	}

	ide_timing_compute(drive, speed, &t, T, UT);

	if (peer->present) {
		ide_timing_compute(peer, peer->current_speed, &p, T, UT);
		ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
	}

	via_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);

	if (!drive->init_speed)
		drive->init_speed = speed;
	drive->current_speed = speed;

	return 0;
}

/*
 * via82cxxx_tune_drive() is a callback from upper layers for
 * PIO-only tuning.
 */

static void via82cxxx_tune_drive(ide_drive_t *drive, unsigned char pio)
{
	if (!((via_enabled >> HWIF(drive)->channel) & 1))
		return;

	if (pio == 255) {
		via_set_drive(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO));
		return;
	}

	via_set_drive(drive, XFER_PIO_0 + MIN(pio, 5));
}

#ifdef CONFIG_BLK_DEV_IDEDMA

/*
 * via82cxxx_dmaproc() is a callback from upper layers that can do
 * a lot, but we use it for DMA/PIO tuning only, delegating everything
 * else to the default ide_dmaproc().
 */

int via82cxxx_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
{

	if (func == ide_dma_check) {

		short w80 = HWIF(drive)->udma_four;

		short speed = ide_find_best_mode(drive,
			XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA |
			(via_config->flags & VIA_UDMA ? XFER_UDMA : 0) |
			(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_66 ? XFER_UDMA_66 : 0) |
			(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_100 ? XFER_UDMA_100 : 0));

		via_set_drive(drive, speed);

		func = (HWIF(drive)->autodma && (speed & XFER_MODE) != XFER_PIO)
			? ide_dma_on : ide_dma_off_quietly;
	}

	return ide_dmaproc(func, drive);
}

#endif /* CONFIG_BLK_DEV_IDEDMA */

/*
 * The initialization callback. Here we determine the IDE chip type
 * and initialize its drive independent registers.
 */

unsigned int __init pci_init_via82cxxx(struct pci_dev *dev, const char *name)
{
	struct pci_dev *isa = NULL;
	unsigned char t, v;
	unsigned int u;
	int i;

/*
 * Find the ISA bridge to see how good the IDE is.
 */

	for (via_config = via_isa_bridges; via_config->id; via_config++)
		if ((isa = pci_find_device(PCI_VENDOR_ID_VIA, via_config->id, NULL))) {
			pci_read_config_byte(isa, PCI_REVISION_ID, &t);
			if (t >= via_config->rev_min && t <= via_config->rev_max)
				break;
		}

	if (!via_config->id) {
		printk(KERN_WARNING "VP_IDE: Unknown VIA SouthBridge, contact Vojtech Pavlik <vojtech@suse.cz>\n");
		return -ENODEV;
	}

/*
 * Check 80-wire cable presence and setup Clk66.
 */

	switch (via_config->flags & VIA_UDMA) {

		case VIA_UDMA_100:

			pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
			for (i = 24; i >= 0; i -= 8)
				if (((u >> i) & 0x10) || (((u >> i) & 0x20) && (((u >> i) & 7) < 3)))
					via_80w |= (1 << (1 - (i >> 4)));	/* BIOS 80-wire bit or UDMA w/ < 50ns/cycle */
			break;

		case VIA_UDMA_66:

			pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);	/* Enable Clk66 */
			pci_write_config_dword(dev, VIA_UDMA_TIMING, u | 0x80008);
			for (i = 24; i >= 0; i -= 8)
				if (((u >> (i & 16)) & 8) && ((u >> i) & 0x20) && (((u >> i) & 7) < 2))
					via_80w |= (1 << (1 - (i >> 4)));	/* 2x PCI clock and UDMA w/ < 3T/cycle */
			break;
	}

	if (via_config->flags & VIA_BAD_CLK66) {				/* Disable Clk66 */
		pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);		/* Would cause CRC errors */
		pci_write_config_dword(dev, VIA_UDMA_TIMING, u & ~0x80008);
	}

/*
 * Check whether interfaces are enabled.
 */

	pci_read_config_byte(dev, VIA_IDE_ENABLE, &v);
	via_enabled = ((v & 1) ? 2 : 0) | ((v & 2) ? 1 : 0);

/*
 * Set up FIFO sizes and thresholds.
 */

	pci_read_config_byte(dev, VIA_FIFO_CONFIG, &t);

	if (via_config->flags & VIA_BAD_PREQ)				/* Disable PREQ# till DDACK# */
		t &= 0x7f;						/* Would crash */

	if (via_config->flags & VIA_SET_FIFO) {				/* Fix FIFO split between channels */
		t &= (t & 0x9f);
		switch (via_enabled) {
			case 1: t |= 0x00; break;			/* 16 on primary */
			case 2: t |= 0x60; break;			/* 16 on secondary */
			case 3: t |= 0x20; break;			/* 8 pri 8 sec */
		}
	}

	if (via_config->flags & VIA_SET_THRESH)				/* 1/2 FIFO full to trigger xmit */
		t = (t & 0xf0) | 0x0a;

	pci_write_config_byte(dev, VIA_FIFO_CONFIG, t);

/*
 * Print the boot message.
 */

	pci_read_config_byte(isa, PCI_REVISION_ID, &t);
	printk(KERN_INFO "VP_IDE: VIA %s (rev %02x) IDE %s controller on pci%s\n",
			via_config->name, t, via_dma[via_config->flags & VIA_UDMA], dev->slot_name);

/*
 * Setup /proc/ide/via entry.
 */

#ifdef CONFIG_PROC_FS
	if (!via_proc) {
		via_base = pci_resource_start(dev, 4);
		bmide_dev = dev;
		isa_dev = isa;
		via_display_info = &via_get_info;
		via_proc = 1;
	}
#endif

	return 0;
}

unsigned int __init ata66_via82cxxx(ide_hwif_t *hwif)
{
	return ((via_enabled & via_80w) >> hwif->channel) & 1;
}

void __init ide_init_via82cxxx(ide_hwif_t *hwif)
{
	int i;

	hwif->tuneproc = &via82cxxx_tune_drive;
	hwif->speedproc = &via_set_drive;
	hwif->autodma = 0;

	for (i = 0; i < 2; i++) {
		hwif->drives[i].io_32bit = 1;
		hwif->drives[i].unmask = 1;
		hwif->drives[i].autotune = 1;
		hwif->drives[i].dn = hwif->channel * 2 + i;
	}

#ifdef CONFIG_BLK_DEV_IDEDMA
	if (hwif->dma_base) {
		hwif->dmaproc = &via82cxxx_dmaproc;
#ifdef CONFIG_IDEDMA_AUTO
		hwif->autodma = 1;
#endif
	}
#endif /* CONFIG_BLK_DEV_IDEDMA */
}

/*
 * We allow the BM-DMA driver to only work on enabled interfaces.
 */

void __init ide_dmacapable_via82cxxx(ide_hwif_t *hwif, unsigned long dmabase)
{
	if ((via_enabled >> hwif->channel) & 1)
		ide_setup_dma(hwif, dmabase, 8);
}

--OgqxwSJOaUobr8KG--
