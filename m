Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271791AbRHRHFT>; Sat, 18 Aug 2001 03:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271792AbRHRHFJ>; Sat, 18 Aug 2001 03:05:09 -0400
Received: from relay.germany.net ([151.189.0.100]:52632 "EHLO
	relay.germany.net") by vger.kernel.org with ESMTP
	id <S271791AbRHRHEy>; Sat, 18 Aug 2001 03:04:54 -0400
Date: Fri, 17 Aug 2001 22:05:20 +0200 (MEST)
To: <linux-kernel@vger.kernel.org>
cc: Albrecht Jacobs <albrecht.jacobs@janglednerves.com>
Subject: Q: 2.4.[37]-XFS: /dev/nst0m: cannot allocate memory
Message-ID: <Pine.LNX.4.33.0108172200330.17813-100000@Schnecke.Windsbach.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: 100.179370@germanynet.de (Martin Jacobs)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I cannot read anything from my tape (Tandberg DLT8000, LVD
interface, ID=5) connected to an aic7899 or an sym53c895 using
kernel 2.4.3-XFS or 2.4.7-XFS. (Everything works fine on
2.2.16.) Loading of st.o works. stinit works. mt (status, tape
positioning) works. But when I try to read the amanda header
from the tape (dd if=/dev/nst0m bs=32k count=1) I get the
error

dd: reading `/dev/nst0m': Cannot allocate memory

The syslog says:

Jul 29 17:49:28 depp kernel: sym53c895-0-<5,*>: FAST-10 WIDE SCSI 20.0MB/s (100.0 ns, offset 15)
Jul 29 17:49:28 depp kernel: st0: Block limits 2 - 16777214 bytes.

strace gives something like:

...
open("/dev/nst0m", O_RDONLY|O_LARGEFILE) = 0
...
read(0, 0x8052000, 32768)               = -1 ENOMEM (Cannot
allocate
memory)
...

Nearly the same for tar (with default block size of 512 byte).

BUT: if I use bs=64k it works!!?

TIA

-- 
albrecht jacobs

jangled nerves gmbh
hallstrasse 25
d-70376 stuttgart

fon:   +49 711 550375-44
fax:   +49 711 550375-22

mailto:albrecht.jacobs@janglednerves.com
http://www.janglednerves.com/



