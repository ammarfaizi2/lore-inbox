Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbTAUItq>; Tue, 21 Jan 2003 03:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266676AbTAUItp>; Tue, 21 Jan 2003 03:49:45 -0500
Received: from mail.bmlv.gv.at ([193.171.152.34]:16356 "HELO mail.bmlv.gv.at")
	by vger.kernel.org with SMTP id <S266540AbTAUIto> convert rfc822-to-8bit;
	Tue, 21 Jan 2003 03:49:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: linux-kernel@vger.kernel.org
Subject: printk() without KERN_ prefixes? (in 2.5.59) and Q: small kernel image doc
Date: Tue, 21 Jan 2003 09:58:43 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301210930.14551.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

until now I believed that all printk()'s should have a KERN_ prefix - but to 
my surprise it ain't so:
	grep printk -r . | grep -v "KERN_" | wc -l
	  29932
	grep printk -r . | grep -v "KERN_" | cut -d: -f1 | uniq | wc -l
	   2636
so there are ~ 30 000 printk() lines in 2600 files which don't have such a 
specifier.

Should they be fixed to KERN_INFO or some such? I'm willing to contribute a 
patch (which will be done by script, of course). Or am I missing something 
and they shall stay as they are?

I'm looking at this part as I'm trying to get a smaller kernel image, as my 
boot media (1.44 MB disk :-( is getting full (yes I know that there's a lot I 
can do about userspace too :-) and so I'm thinking about dropping all 
KERN_DEBUG, maybe KERN_INFO and possible KERN_NOTICE to save some space. I 
remember having read some ideas (and possibly a web reference) on lkml in 
mid-2002 but couldn't find them yet.


Anyway, are there some other resources on the web for building small kernel's? 
(that is, small kernel images, not for use in small machines). I already 
searched a bit and found some sites (mulinux, superant/smalllinux, 
linuxrouter, linux embedding, small unix, ...)

I know that I could use an older kernel (2.0 or 2.2) but because of driver 
maturity (ie. workarounds for bugs in recent hardware) and performance I'd 
like to use current kernels.



Regards,

Phil



PS: Highlights are below (more than 100 occurances)

    102 ./drivers/scsi/qlogicfc.c
    103 ./drivers/block/floppy.c
    104 ./drivers/atm/idt77252.c
    104 ./drivers/cdrom/sjcd.c
    106 ./drivers/char/rio/rioinit.c
    107 ./net/atm/mpc.c
    109 ./drivers/message/i2o/i2o_core.c
    110 ./drivers/char/stallion.c
    114 ./drivers/sbus/char/aurora.c
    114 ./drivers/cdrom/aztcd.c
    116 ./drivers/char/pcmcia/synclink_cs.c
    117 ./drivers/char/serial167.c
    122 ./drivers/scsi/AM53C974.c
    130 ./drivers/message/fusion/mptbase.c
    136 ./drivers/char/synclinkmp.c
    142 ./drivers/char/synclink.c
    144 ./drivers/message/fusion/mptscsih.c
    145 ./drivers/scsi/ncr53c8xx.c
    147 ./arch/ia64/kernel/perfmon.c
    149 ./drivers/scsi/sym53c8xx.c
    154 ./drivers/net/hp100.c
    164 ./sound/oss/cs46xx.c
    166 ./drivers/atm/iphase.c
    180 ./drivers/scsi/aha152x.c
    184 ./drivers/char/cyclades.c
    184 ./drivers/char/rio/rioctrl.c
    204 ./drivers/scsi/53c7xx.c
    206 ./drivers/scsi/osst.c
    208 ./drivers/scsi/53c7,8xx.c
    217 ./drivers/scsi/qla1280.c
    221 ./drivers/scsi/cpqfcTSworker.c
    229 ./fs/jffs/intrep.c
    230 ./drivers/scsi/aic7xxx_old.c
    253 ./crypto/tcrypt.c


