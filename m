Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129659AbQLLVOt>; Tue, 12 Dec 2000 16:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129761AbQLLVOj>; Tue, 12 Dec 2000 16:14:39 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:9746 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129659AbQLLVO1>;
	Tue, 12 Dec 2000 16:14:27 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: " Paul C. Nendick " <pauly@enteract.com>
Date: Tue, 12 Dec 2000 21:43:26 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.2.16 SMP: mtrr errors
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <F7C565F7C41@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Dec 00 at 14:00,  Paul C. Nendick wrote:

> -Matrox g450 32MB RAM dual-heal AGP video card w/ hand compiled X driver
>  from matrox

Make sure you do not use either matroxfb or XFree's driver... Same chip
ID, but different ramdac :-(
 
> and immediately after starting X:
> 
> kernel: mtrr: base(0xd4000000) is not aligned on a size(0x1800000) boundary
> last message repeated 2 times

For some strange reason X thinks that you have 24MB of memory on the G450.
You can either create 32MB write-combining region at 0xd4000000, or
teach X that your device occupies 32MB and not 24 (you should do it anyway,
region size can be only power of two)...

> and finally:
> 
> %cat /proc/mtrr 
> reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
> reg01: base=0xd0000000 (3328MB), size=  64MB: write-combining, count=1
> reg02: base=0xd5800000 (3416MB), size=   8MB: write-combining, count=1
+ reg03: base=0xd4000000 (????MB), size=  32MB: write-combining, count=1

                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
