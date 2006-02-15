Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945959AbWBOPHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945959AbWBOPHP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945962AbWBOPHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:07:14 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:40165 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1945959AbWBOPHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:07:12 -0500
Date: Wed, 15 Feb 2006 16:07:10 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Charles-Edouard Ruault <ce@ruault.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
Message-ID: <20060215150710.GN30182@vanheusden.com>
References: <43EF8388.10202@ruault.com> <20060214114102.GC20975@vanheusden.com>
	<1139934749.11659.97.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139934749.11659.97.camel@mindpipe>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Thu Feb 16 09:55:03 CET 2006
X-Message-Flag: www.unixexpert.nl
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've got the same soft lockups, not while cdrom access but when sa-learn
> > runs (from spamassassin):
> Why is DMA disabled for your IDE disks?

root@muur:/var/www/htdocs# hdparm -i /dev/hda

/dev/hda:

 Model=QUANTUM FIREBALLP AS20.5, FwRev=A2R.0600, SerialNo=692124031358
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1902kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=40132503
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:

 * signifies the current active mode

On the other hand:
root@muur:/var/www/htdocs# hdparm -d /dev/hda

/dev/hda:
 using_dma    =  0 (off)

That is puzzling me as I explicitly swith that on in the startupscripts:
0 root@muur:/var/www/htdocs# grep hdparm /etc/rc.d/*
/etc/rc.d/rc.local:/usr/sbin/hdparm -c 3 -d 1 -X 69 -u 1 /dev/hda &

So it seems it switches back to pio somewhere in time.

But on the other hand: shouldn't pio run ok as well without softlockup
errors?


Folkert van Heusden

-- 
www.biglumber.com <- site where one can exchange PGP key signatures 
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
