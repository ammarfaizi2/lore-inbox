Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132568AbQKWGdk>; Thu, 23 Nov 2000 01:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132607AbQKWGda>; Thu, 23 Nov 2000 01:33:30 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:51729 "HELO
        note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
        id <S132568AbQKWGdN>; Thu, 23 Nov 2000 01:33:13 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Mohammad A. Haque" <mhaque@haque.net>
Date: Thu, 23 Nov 2000 17:03:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14876.45844.670274.366687@notabene.cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Tigran Aivazian <tigran@veritas.com>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: message from Mohammad A. Haque on Thursday November 23
In-Reply-To: <3A1CB07C.CEE01F1F@haque.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
        LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
        8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 23, mhaque@haque.net wrote:
> I just got these while doing many compiles on my box ....
> 
> Nov 23 00:40:06 viper kernel: EXT2-fs warning (device ide0(3,3)):
> ext2_unlink: Deleting nonexistent file (622295), 0
> Nov 23 00:40:06 viper kernel: = 1
> Nov 23 00:40:06 viper kernel: EXT2-fs error (device ide0(3,3)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 540028982,
> count = 1
> Nov 23 00:40:06 viper kernel: EXT2-fs error (device ide0(3,3)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 540024880,
> count = 1
> Nov 23 00:40:06 viper kernel: EXT2-fs error (device ide0(3,3)):
> ext2_free_blocks: Freeing blocks not in datazone - block = 170926128,
> count = 1

Oh, good.  It's not just me and Tigran then.  I was at first blaming
my raid5 code for this, but if you get it and Tigran gets it (reported 
  http://boudicca.tux.org/hypermail/linux-kernel/2000week48/0257.html
) then it's probably not me.

And interesting data point:
 my raid5 reports when it get a read or write request on a block that
 it currently has an outstanding read or write request.  This report
 gets triggered just after a spate of "Freeing blocks not in ...zone"
 messages - there appear to be multiple write requests for the same
 block.
 This seems to suggest that something in the buffer cache is getting
 corrupted.

Now if only we had a reliable way to reproduce it, we could start a
binary search for the offending patch... but I can only reproduce it
on a patched kernel after several hours of performance testing.

NeilBrown


> 
> 
> What else should I provide?
> 
> [mhaque@viper mhaque]$ uname -a
> Linux viper.haque.net 2.4.0-test11 #6 Sun Nov 19 22:17:33 EST 2000 i686
> unknown
> 
> Nov 16 19:03:15 viper kernel: Uniform Multi-Platform E-IDE driver
> Revision: 6.31
> Nov 16 19:03:15 viper kernel: ide: Assuming 33MHz system bus speed for
> PIO modes; override with idebus=xx 
> Nov 16 19:03:15 viper kernel: PIIX4: IDE controller on PCI bus 00 dev 39 
> Nov 16 19:03:15 viper kernel: PIIX4: chipset revision 1 
> Nov 16 19:03:15 viper kernel: PIIX4: not 100%% native mode: will probe
> irqs later 
> Nov 16 19:03:15 viper kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS
> settings: hda:DMA, hdb:DMA 
> Nov 16 19:03:15 viper kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS
> settings: hdc:DMA, hdd:DMA 
> 
> Nov 16 19:03:15 viper kernel: hda: IBM-DJNA-371350, ATA DISK drive 
> Nov 16 19:03:15 viper kernel: hdb: CREATIVEDVD-ROM DVD2240E 12/24/97,
> ATAPI CDROM drive 
> Nov 16 19:03:15 viper kernel: hdc: Maxtor 82160D2, ATA DISK drive 
> Nov 16 19:03:15 viper kernel: hdd: IBM-DTLA-307045, ATA DISK drive 
> 
> -- 
> 
> =====================================================================
> Mohammad A. Haque                              http://www.haque.net/ 
>                                                mhaque@haque.net
> 
>   "Alcohol and calculus don't mix.             Project Lead
>    Don't drink and derive." --Unknown          http://wm.themes.org/
>                                                batmanppc@themes.org
> =====================================================================
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
