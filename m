Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265802AbRF2Jem>; Fri, 29 Jun 2001 05:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265803AbRF2Jec>; Fri, 29 Jun 2001 05:34:32 -0400
Received: from penguin.eunet.cz ([193.86.255.66]:28422 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S265802AbRF2JeS>; Fri, 29 Jun 2001 05:34:18 -0400
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Fri, 29 Jun 2001 11:34:07 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx kernel driver; ATTN Mr. Justin T. Gibbs
Message-ID: <20010629113407.C1100@informatics.muni.cz>
In-Reply-To: <3B38C4D2.EB2A8944@mycompany.com> <E15Ewis-0003ul-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15Ewis-0003ul-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jun 26, 2001 at 06:33:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
: Except for an obscure bug under very high memory load I'm not aware of any 
: outstanding bugs in the AIC7xxx driver, certainly not like you describe. There
: is however always a first time for any bug 8)

	Well, AIC7xxx crashes on me with stock 2.4.5 kernel
(Athlon TB 850, ASUS A7V). I run 2.4.3 + zerocopy patches, and when I tried
to upgrade to 2.4.5, it crashes during boot while initializing the AIC7xxx
driver. I have written down the Oops numbers by hand, but I had to
reboot the server back to 2.4.3+zerocopy.

	Here are relevant parts of dmesg on 2.4.3 (just to identify the
hardware):

SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
PCI: Found IRQ 12 for device 00:0a.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: SEAGATE   Model: ST118273W         Rev: 5698
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
scsi0:0:0:0: Tagged Queuing enabled.  Depth 8
SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
 sda: sda1 sda2

Now the Oops tracing:

EIP was ahc_match_scb + 0x19

Call trace:

ahc_search_qinfifo + 0x187
ahc_abort_scbs + 0x6a
__udelay + 0x27
ahc_reset_current_channel + 0x27c
ahc_pci_config + 0x4e2
pci_read_config_byte + 0x1c
...

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
It is a very bad idea to feed negative numbers to memcpy.         --Alan Cox
