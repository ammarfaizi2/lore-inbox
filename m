Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTLaPAd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 10:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbTLaPAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 10:00:33 -0500
Received: from rat-6.inet.it ([213.92.5.96]:38052 "EHLO rat-6.inet.it")
	by vger.kernel.org with ESMTP id S262965AbTLaPA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 10:00:28 -0500
From: Paolo Ornati <ornati@lycos.it>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1 [resend]
Date: Wed, 31 Dec 2003 16:00:07 +0100
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org>
MIME-Version: 1.0
Message-Id: <200312311434.17036.ornati@lycos.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3Ru8/iLjvSbjNcl"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_3Ru8/iLjvSbjNcl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

PS = sorry if more than one copy of this message appears on lkml but I'm 
having some problems with my SMTP server....

On Wednesday 31 December 2003 09:36, Linus Torvalds wrote:
> Ok, I've merged a lot of pending patches into 2.6.1-rc1, and will now
> calm down for a while again, to make sure that the final 2.6.1 is ok.
>
> Most of the updates is for stuff that has been in -mm for a long while
> and is stable, along with driver updates (SCSI, network, i2c and USB).
>
> 		Linus
>
> ----

With 2.6.1-rc1 I have noticed a strange IDE performance change.

Results of "hdparm -t /dev/hda" with 2.6.0 kernel:
(readahead = 256):		~26.31 MB/s
(readahead = 128):		~31.82 MB/s

PS = readahead is set to 256 by default on my system, 128 seems to be the 
best value

Results of "hdparm -t /dev/hda" with 2.6.1-rc1 kernel:
(readahead = 256):		~26.41 MB/s
(readahead = 128):		~26.27 MB/s

Setting readahead to 128 doesn't have the same effect with the new kernel...

INFO on my HD:

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 128 (on)
 geometry     = 38792/16/63, sectors = 39102336, start = 0

/dev/hda:

 Model=WDC WD200BB-53AUA1, FwRev=18.20D18, SerialNo=WD-WMA6Y1501425
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39102336
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 *udma4 udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:  1 2 3 4 5


IDE controller:

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 10) (prog-if 8a
[Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at b800 [size=16]
        Capabilities: [c0] Power Management version 2


I don't understand how this happens... the only changes to IDE driver seems 
to be these:

>
> Summary of changes from v2.6.0 to v2.6.1-rc1
> ============================================
> Andrew Morton:
>   o Can't disable IDE DMA
>   o IDE MMIO fix
>   o IDE capability elevation fix
>
> Linus Torvalds:
>   o Make IDE DRQ and READY timeouts longer

For my tests I have used this stupid shell script:

#!/bin/bash

echo "HD test for linux `uname -r`"
echo

ra=8
for i in `seq 12`; do
    echo "READAHEAD = $ra";
    hdparm -a $ra /dev/hda;
    for j in `seq 3`; do
	hdparm -t /dev/hda;
    done;
    ra=$(($ra*2));
done

Results for 2.6.0 && 2.6.1-rc1 are attached.

Bye

-- 
	Paolo Ornati
	Linux v2.6.0







--Boundary-00=_3Ru8/iLjvSbjNcl
Content-Type: application/x-gzip;
  name="2.6.0.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="2.6.0.gz"

H4sICGfA8j8CAzIuNi4wAM2Xz06DQBDG7zzFHPVC9x/L0qSHmpr04sX4AlXAEhWSQo2P70CigWEP
mw5N2gNJp99+zPx2Zyj7HXRF20HZnOCzqs8/oGIbiyh6ftzutnu8wAZcFK3y4nt1zA/rCNqi66r6
HcoWTsUhPxzxAl2DqtF3/GwAHNw19f1k9Uv11S9+PZdlcSpyyKv2Y1jXrgGsgacHqGoAE6cZ3umt
qfMWnaSOdYq/rTB0oZ0jdo5nR7NL/uzG4KQNIocyik5aDjo9TS4xvFqpneLZGWInfOi0CkKHMopO
KwY6S2p1mlXrzM4sa6d86KwJQocyig7vdSk6FQs1Sk7LOE0YtaKdmNplmmcniZ30NqwKm3W9btay
ynHokfyc5ZVLNsOmV9qMMT2VhM27XkfpYYxBz4wbQ9lYS1a5xkztFI/eLDvvwyKRYSOv11F6GLtd
etItuxnW27lChY29QTjrXQwuCdAsW7Fb9PipzNu8woTNvkE4a18McgAm5Mjwpp+RUzvWPxaPnXf6
GZGFjb9BSAH2wSUBLnwC1ZX2Y/KaIbOwCTgIKcA+yAF43aElsyvtx/R1Q7vAITgo5y8dGOUwtNMs
hb0phqRFxL/dL9gU+jUFDwAA

--Boundary-00=_3Ru8/iLjvSbjNcl
Content-Type: application/x-gzip;
  name="2.6.1-rc1.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="2.6.1-rc1.gz"

H4sICGfA8j8CAzIuNi4xLXJjMQDNl7FugzAQhnee4sZ2qIPPxjGRMqRKpSxdqr5AGiBBbUECUvXx
ezBhQyQrNlIZkLj8/rE/3x3xYQ9d3nZQ1A18ldX1F5Apxp+aE4+it5fdfnegG2xBR9Eqy39Wl+y4
iaDNu66szlC00OTH7HihG3Q1qUbPdG0BNDzU1aMx+r387gd/XIsib/IMsrL9HMa1GwAl4fUZygpA
sJjTm051lbXkhJzhmn5bUegeO8l0PLLjggm5kN0YHFdO5Ehmo+PqbnTIZDpGl7A191gr2amxnWJx
4mcnTTvEOXQCndCRzEYn0AddYk6O9mGZtS6ITkkndCSz0dG7PNDZk/NEJ0w7wYOi43q2YNGt1/W6
Scmi9qFnLRfToPR87ey9FXP0MHHrd73OpkcxH3pozk9i2NzTfnY3Zzeml3C3ltfrbHoUC5h7IvlX
lXszlY3KjdGt7Q3CSe1SMGT6Sb8Vc9MuScOm33q2eGPp1vsG4aR8KegD0F5xYIA6rB2fAyjj1K39
DUIbYB8MCVCETZnAdrMfX81Ttw44CG2AfTBkCXvWnP0/MnBCi/njhtCOTXBQTg8dFPVhaB8UMCjD
eKkt+QPi/BC7CQ8AAA==

--Boundary-00=_3Ru8/iLjvSbjNcl--


