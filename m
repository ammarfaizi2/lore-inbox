Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312643AbSDAW0D>; Mon, 1 Apr 2002 17:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312661AbSDAWZz>; Mon, 1 Apr 2002 17:25:55 -0500
Received: from erasure.jasnik.net ([207.148.204.33]:10688 "HELO
	erasure.jasnik.net") by vger.kernel.org with SMTP
	id <S312643AbSDAWZq>; Mon, 1 Apr 2002 17:25:46 -0500
Subject: Re: ECC memory and SMP lockups on Gateway 6400 server
From: Jason Czerak <Jason-Czerak@Jasnik.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CA82C0B.98CD7275@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 01 Apr 2002 17:25:45 -0500
Message-Id: <1017699945.19498.244.camel@neworder>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-01 at 04:44, Manfred Spraul wrote:
> > Recently got the goahead to upgrade the Gateway Win2K server to a linux
> > box to replace out old webserver. It's a 6400 server. 2 PIII-733's, 704
> > megs ECC registered ram.. NT ran fine on this box. not a hitch.
> > 
> Could you check /proc/interrupts? Is one number extremely high?
> 
> And try to boot with "mem=690M". My sis boards become extremely slow if
> I don't limit the memory. I guess the e820 map is wrong, and one of the
> pages are actually power managmenet registes/NVS.
> 

The OEM 128 and 64 meg sitck of ECC that came with the machine works
fine. I got an aftermarket ECC stick that NT likes but linux doesn't.


Standard boot with no extra kerenl switches
and it's very slow and CPU load is 1.0

Moby:/proc # cat interrupts
           CPU0       CPU1       
  0:      17736      20742    IO-APIC-edge  timer
  1:         62         70    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          2    IO-APIC-edge  rtc
 20:        434        453   IO-APIC-level  eth0
 24:         15         15   IO-APIC-level  sym53c8xx
 25:       1073       1108   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:      38293      38388 
ERR:          0
MIS:          0




Booted with "kernel-2.4.18 mem=704M" at lilo prompt and it's still slow

Kernel command line: auto BOOT_IMAGE=Linux-2.4.18 ro root=802
BOOT_FILE=/boot/kernel-2.4.18 mem=704M

is what dmesg cought.

Moby:/proc # cat interrupts
           CPU0       CPU1       
  0:      15540      18511    IO-APIC-edge  timer
  1:         16         24    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          1    IO-APIC-edge  rtc
 20:        151        162   IO-APIC-level  eth0
 24:         15         15   IO-APIC-level  sym53c8xx
 25:       3647       3656   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:      33966      33907 
ERR:          0
MIS:          0



I finally got the machine stable with SMP enabled in the kernel (had to
be a heat issue and the mobo shutting things down)

I'm about to compile and use  http://www.anime.net/~goemon/linux-ecc/ 
to see if I can figure out what exactly is happening.



