Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSIDSmx>; Wed, 4 Sep 2002 14:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSIDSmx>; Wed, 4 Sep 2002 14:42:53 -0400
Received: from [208.34.239.110] ([208.34.239.110]:41345 "EHLO
	babylon5.babcom.com") by vger.kernel.org with ESMTP
	id <S314278AbSIDSmw>; Wed, 4 Sep 2002 14:42:52 -0400
Date: Wed, 4 Sep 2002 14:48:54 -0400
From: Phil Stracchino <alaric@babcom.com>
To: linux-kernel@vger.kernel.org
Cc: alaric@babcom.com
Subject: FOLLOWUP:  Kernel 2.4.19 does not export _mmx_memcpy when compiled with gcc-3.2 and Athlon optimizations
Message-ID: <20020904184854.GA9141@babylon5.babcom.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020904181952.GA1158@babylon5.babcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020904181952.GA1158@babylon5.babcom.com>
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 2105 C6FC 945D 2A7A 0738  9BB8 D037 CE8E EFA1 3249
X-PGP-Key-FTP-URL: ftp://ftp.babcom.com/pub/pgpkeys/alaric.asc
X-PGP-Key-HTTP-URL: http://www.babcom.com/alaric/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FOLLOWUP:
I built a K6-optimized kernel and manually turned on CONFIG_X86_USE_3DNOW
before beginning compilation, installed the kernel, and ran depmod -a.  
The result:

babylon5:root:/usr/src/linux-2.4.19:65 # depmod -a
depmod: *** Unresolved symbols in /lib/modules/2.4.19/kernel/drivers/block/rd.o
depmod: *** Unresolved symbols in /lib/modules/2.4.19/kernel/drivers/cdrom/cdrom.o
depmod: *** Unresolved symbols in /lib/modules/2.4.19/kernel/drivers/char/serial.o
depmod: *** Unresolved symbols in /lib/modules/2.4.19/kernel/drivers/ide/ide-cd.o
...
...
... well, you get the idea.  A total of 40 modules fail, all with the
same error.  The following is the list of failed modules:

drivers/block/rd.o
drivers/cdrom/cdrom.o
drivers/char/serial.o
drivers/ide/ide-cd.o
drivers/md/lvm-mod.o
drivers/md/raid5.o
drivers/net/ppp_async.o
drivers/net/ppp_deflate.o
drivers/net/ppp_generic.o
drivers/net/slhc.o
drivers/net/slip.o
drivers/parport/parport.o
drivers/parport/parport_pc.o
drivers/pcmcia/pcmcia_core.o
drivers/scsi/aic7xxx/aic7xxx.o
drivers/scsi/ide-scsi.o
drivers/scsi/sg.o
drivers/scsi/sr_mod.o
drivers/scsi/st.o
drivers/usb/hid.o
drivers/usb/storage/usb-storage.o
drivers/usb/usb-uhci.o
drivers/usb/usbcore.o
fs/fat/fat.o
fs/inflate_fs/inflate_fs.o
fs/intermezzo/intermezzo.o
fs/isofs/isofs.o
fs/lockd/lockd.o
fs/minix/minix.o
fs/nfs/nfs.o
fs/nfsd/nfsd.o
fs/reiserfs/reiserfs.o
fs/smbfs/smbfs.o
fs/udf/udf.o
fs/ufs/ufs.o
fs/vfat/vfat.o
net/ipv4/netfilter/ip_tables.o
net/ipv4/netfilter/ipt_REJECT.o
net/ipv4/netfilter/iptable_nat.o
net/sunrpc/sunrpc.o


So it definitely looks like something is unhappy with CONFIG_X86_USE_3DNOW,
possibly only when compiled with gcc-3.2, possibly not.  Why it's not
being exported, I have no idea; as far as I can tell, it should be.

I haven't tried building an Athlon-optimized kernel *without* using
CONFIG_X86_USE_3DNOW.



-- 
  *********  Fight Back!  It may not be just YOUR life at risk.  *********
  phil stracchino   ::   alaric@babcom.com   ::   halmayne@sourceforge.net
    unix ronin     ::::   renaissance man   ::::   mystic zen biker geek
     2000 CBR929RR, 1991 VFR750F3 (foully murdered), 1986 VF500F (sold)
       Linux Now! ...because friends don't let friends use Microsoft.
