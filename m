Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293679AbSCFQvC>; Wed, 6 Mar 2002 11:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293678AbSCFQun>; Wed, 6 Mar 2002 11:50:43 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:60138 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S293659AbSCFQu1>; Wed, 6 Mar 2002 11:50:27 -0500
Date: Wed, 6 Mar 2002 10:50:22 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: "James M." <Dart@windeath.2y.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
Message-ID: <20020306105022.B8107@asooo.flowerfire.com>
In-Reply-To: <E16iPsR-00052J-00@the-village.bc.nu> <3C8574C9.E1E4688C@windeath.2y.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C8574C9.E1E4688C@windeath.2y.net>; from Dart@windeath.2y.net on Tue, Mar 05, 2002 at 07:45:45PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wouldn't be surprised if the next RH kernel included O(1) and the
low-latency stuff.  If it doesn't already.  2.4.18+O1+LOWLAT works great
for me in production and seems like the best overall solution while we
wait for 2.4.19+aa, and then possibly 2.x+rmap farther out.

FWIW, I completely agree with Alan.  2.4 will keep moving, but it's a
stable release now and the rate has to be lower and more calculated.
2.4 already made its big improvements over 2.2, and we shouldn't break
further from the concept of releases to increase the rate of 2.4 change.
Entropy is, by definition, not stable, even if it's "good stuff" we're
adding.  All IMHO.

-- 
Ken.
brownfld@irridia.com

On Tue, Mar 05, 2002 at 07:45:45PM -0600, James M. wrote:
| Alan Cox wrote:
| > 
| > >   I won't bring it up again, I'd love to think Rik, Alan and Ingo will
| > > keep working on performance patches for 2.4, but I wouldn't bet on it.
| > 
| > I certainly will work on collating them - over time it will get less and
| > less of a win. A lot of the now very visible ones are really hard to fix in 2.4
| > and will be 2.5 things (like block). And when you fix block you'll find the
| > next one and so on forever
| 
| I'd love to see some performance patches. I've been watching my quake
| "timerefreshes" drop since 2.2. I've been using Ingo's scheduler patches
| on 2.4.17 with vast improvements in "smoothness" with what seems like an
| occasional block on big writes. I also tried 2.4.19-pre2-ac2(with
| scheduler merged), in that case the smoothness wasn't quite so apparent
| even with X niced to -10. There were also a lot of sound skips that
| didn't happen with 2.4.17/sched-K3. I attributed those to the renicing
| of X to smooth out the mouse.
| 
| > 
| > > done in -pre2, might be worth a try. I'm going to build pre2-ac2 and mjc
| > > for some laptop benchmarks, I'll turn on ZIP support and try my old unit
| > > (the original protocol). I'll try to report back on that in the next day
| > > or so.
| > 
| > Im running both 2.4.18/19pre2 on laptops. PLIP still doesnt work but at
| > least I think I now understand why. If you want to hack on plip ping
| > Tim Waugh <twaugh@redhat.com> he's definitely as far from the Al Viro end
| > of polite computing as you can get and can probably tell you what bits you
| > need to tweak
| 
| As I indicated to Bill in a private mail the parport code has *never*
| properly detected my ECP/EPP although my zipdrive(IMM) DOES work. It's
| in compatibility  mode and horribly slow. I've been futzing with probe.c
| with no luck. More info available on request. I believe ECP is supposed
| to work with this thing at around a theoretical 1.2 MB/sec. This is an
| Intel GX chipset with an Award v6.0 bios, Winbond 83977TF 2meg bios
| chip.
| 
| parport info:
| parport0: PC-style at 0x378 (0x778), irq 7<7>0x378: FIFO is 16 bytes
| 0x378: writeIntrThreshold is 16
| 0x378: readIntrThreshold is 16
| 0x378: PWord is 8 bits
| 0x378: Interrupts are ISA-Pulses
| 0x378: ECP port cfgA=0x10 cfgB=0x48
| 0x378: ECP settings irq=7 dma=<none or set by other means>
| , dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
| parport0: device reported incorrect length field (61, should be 62)
| parport0 (addr 0): SCSI adapter, IMG VP1
| imm: Version 2.05 (for Linux 2.4.0)
| imm: Found device at ID 6, Attempting to use EPP 32 bit
| imm: Found device at ID 6, Attempting to use PS/2
| imm: Communication established at 0x378 with ID 6 using PS/2
| scsi1 : Iomega VPI2 (imm) interface
|   Vendor: IOMEGA    Model: ZIP 100           Rev: P.05
|   Type:   Direct-Access                      ANSI SCSI revision: 02
| Attached scsi removable disk sda at scsi1, channel 0, id 6, lun 0
| SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
| sda: Write Protect is off
|  sda: sda4
| invalidate: busy buffer
| invalidate: busy buffer
| 
| Hdparm:
| /dev/sda4:
|  Timing buffer-cache reads:   128 MB in  1.01 seconds =126.73 MB/sec
|  Timing buffered disk reads:  64 MB in 438.02 seconds =149.62 kB/sec
|  
| Bill isn't the only one that does "interesting things with
| computers"....:=)
| 
| BTW Alan I've given up on my "special" epic100(broken/workaround since
| 2.4.4..completely dead at 2.4.10), we've talked about this before. I see
| fixes in the latest -pre patches but I just replaced it a week or two
| ago and am tired of futzing with it right now. I'll try it again
| sometime if anyone is interested. 
| 
| -- 
| James M. aka "Dart"
| 
| "I have studied many philosophers and many cats. 
|  The wisdom of cats is infinitely superior." -- Hippolyte Taine
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
