Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287478AbSAHAb3>; Mon, 7 Jan 2002 19:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287471AbSAHAbV>; Mon, 7 Jan 2002 19:31:21 -0500
Received: from 65.34.21.74.rrcentralflorida-ubr-a.cfl.rr.com ([65.34.21.74]:55562
	"HELO rich-paul.net") by vger.kernel.org with SMTP
	id <S287508AbSAHAbJ>; Mon, 7 Jan 2002 19:31:09 -0500
Date: Mon, 7 Jan 2002 19:31:00 -0500
From: linguist-linux@rich-paul.net
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 oops:  cdrecord, ide-scsi
Message-ID: <20020107193100.A10173@monster.rich-paul.net>
In-Reply-To: <20020107081559.B7156@monster.rich-paul.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20020107081559.B7156@monster.rich-paul.net>; from linguist-linux@rich-paul.net on Mon, Jan 07, 2002 at 08:15:59AM -0500
X-Operating-System: Linux monster 2.2.18-crypt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I was wrong.  It appears that I can write cdroms with dma
off.

On Mon, Jan 07, 2002 at 08:15:59AM -0500, linguist-linux@rich-paul.net wrote:
> This file is availiable at:  http://www.rich-paul.net/oops,
> ksymoops output at end, /--ksymoops--/
> 
>    I have a repeatable oops when using cdrecord with my TEAC ide
>    cd-writer and ide-scsi. It happens at the beginning of writing a
>    cdrom, and causes a hard freeze of the system, from which nothing
>    except the kiss of a prince or a touch of the reset button will wake
>    it. Being no prince, I choose the later.
>    
>    I'm a coder, and willing to help as much as I can in tracking this
>    down, but my job limits my time. I know nothing of the kernel, except
>    that it is subtle and quick to anger.
>    
>    The oops seems very similar to one that was reported on the list
>    against 2.5.something, but I have not yet tried against that kernel,
>    with or without the prescribed patches. I will, but I suspect we
>    should fix the stable tree as well. The code has changed alot between
>    the two versions, and I could not backport the patches. Somebody who
>    knew their way around the kernel probably could.
>    
>    The simplest way to repeat the problem seems to be:
>         using a kernel with a Serial console, boot with init=/bin/bash
>         execute the following commands:
> 
>                 |# Mount filesystems
>                 |mount /proc
>                 |mount /dev/fs
>                 |mount -oro /archive
>                 |mount -oro /usr
>                 |mount -oro /opt
>                 |mount -oro /boot
>                 |
>                 |# Set up shell
>                 |HOME=/root exec bash --login
>                 |
>                 |# Load modules
>                 |insmod ide-mod
>                 |insmod ide-probe-mod
>                 |modprobe ide-scsi
>                 |
>                 |# Prepare for oops report
>                 |rm -fr /oops
>                 |mkdir /oops
>                 |cp /proc/ksyms /oops
>                 |cp /proc/modules /oops
>                 |cp -ar /lib/modules/2.4.14/ /oops/kdir
>                 |cp /boot/2.4.14/System.map /oops
>                 |cp /boot/2.4.14/config /oops
>                 |
>                 |# avoid viewing e2fsch yet again
>                 |mount -oremount,ro /
>                 |
>                 |# do the dirty deed
>                 |cdrecord -dev2,0,0 /archive/masterlink.iso -v
> 
>    Here are files that may be relevant to tracking this down:
>     1. [1]Oops report, interpreted by ksymoops
>     2. [2]Shell script to execute commands above
>     3. [3]All console output produced, from boot to freeze
>     4. [4]Configuration of my kernel
>     5. [5]cat /proc/pci
>     6. [6]The part of the cap that was fed to ksymoops
>     7. [7]cat /proc/modules
>     8. [8]System.map
>     9. [9]My modules directory, in all it's glory
>    10. [10]My kernel as it was that fateful day
>        
>    Other observations:
>     1. The oops occurs in (at least) kernels 2.2.19 2.4.5 2.4.14 2.4.17
>     2. There was a config at one time under which I could burn cds
>        without burning the system. This config is lost in the mists of
>        time, and try as I might, I cannot find on that works now.
>     3. I have tried turning off dma with hdparm to no avail, but am not
>        even sure if hdparm will have any effect on a device that is an
>        IDE claiming to be a SCSI. Is there something I should try along
>        these lines? Of course, it doesn't fix the oops, but it would get
>        me burnin'.
>     4. I have tried removing all other IDE devices from my system,
>        compiling with and without the various ide modules, etc, etc. No
>        joy.
>     5. If I run cdrecord on a normally running system, rather than a
>        clean boot, the oops usually shows itself as being from dnetc.
> 
> References
> 
>    1. http://www.rich-paul.net/oops/oops.interp
>    2. http://www.rich-paul.net/oops/oops.sh
>    3. http://www.rich-paul.net/oops/oops.cap
>    4. http://www.rich-paul.net/oops/config
>    5. http://www.rich-paul.net/oops/pci
>    6. http://www.rich-paul.net/oops/oops.trim
>    7. http://www.rich-paul.net/oops/modules
>    8. http://www.rich-paul.net/oops/System.map
>    9. http://www.rich-paul.net/oops/kdir
>   10. http://www.rich-paul.net/oops/vmlinuz
>   
> --ksymoops--
> 	
> ksymoops 2.4.3 on i686 2.4.14.  Options used
>      -V (default)
>      -k ksyms (specified)
>      -l modules (specified)
>      -o kdir/ (specified)
>      -m System.map (specified)
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000017c
> fa8222a1
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<fa8222a1>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010002
> eax: 00000000   ebx: f7e8e2c0   ecx: 00000000   edx: f7e8e2c0
> esi: fa81b760   edi: 00000080   ebp: f79f8000   esp: c027deb0
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c027d000)
> Stack: f7e8e2c0 fa81b760 00000080 fa81b720 00000080 00000000 f7e8e2c0 f7e6c340 
>        fa81b760 fa80f422 00000000 f7eead80 fa81b760 f7eead80 fa8224c0 00000080 
>        fa810060 fa81b760 fa817f42 00000080 f7eead80 fa80fec0 00000000 c02e4d40 
> Call Trace: [<fa81b760>] [<fa81b720>] [<fa81b760>] [<fa80f422>] [<fa81b760>] 
>    [<fa8224c0>] [<fa810060>] [<fa81b760>] [<fa817f42>] [<fa80fec0>] [<c011faa5>] 
>    [<c011bebc>] [<c011bd8d>] [<c011bb0f>] [<c0108b1b>] [<c01053f0>] [<c01053f0>] 
>    [<c010ac88>] [<c01053f0>] [<c01053f0>] [<c010541c>] [<c0105492>] [<c0105000>] 
>    [<c0105043>] 
> Code: c7 80 7c 01 00 00 00 00 07 00 83 7c 24 14 00 0f 84 97 01 00 
> 
> >>EIP; fa8222a0 <[ide-scsi]idescsi_end_request+70/290>   <=====
> Trace; fa81b760 <[ide-mod]ide_hwifs+40/1ec8>
> Trace; fa81b720 <[ide-mod]ide_hwifs+0/1ec8>
> Trace; fa81b760 <[ide-mod]ide_hwifs+40/1ec8>
> Trace; fa80f422 <[ide-mod]ide_error+122/170>
> Trace; fa81b760 <[ide-mod]ide_hwifs+40/1ec8>
> Trace; fa8224c0 <[ide-scsi]idescsi_pc_intr+0/240>
> Trace; fa810060 <[ide-mod]ide_timer_expiry+1a0/200>
> Trace; fa81b760 <[ide-mod]ide_hwifs+40/1ec8>
> Trace; fa817f42 <[ide-mod]ide_hwif_to_major+5a0/257c>
> Trace; fa80fec0 <[ide-mod]ide_timer_expiry+0/200>
> Trace; c011faa4 <timer_bh+264/2c0>
> Trace; c011bebc <bh_action+4c/90>
> Trace; c011bd8c <tasklet_hi_action+5c/90>
> Trace; c011bb0e <do_softirq+6e/d0>
> Trace; c0108b1a <do_IRQ+da/f0>
> Trace; c01053f0 <default_idle+0/40>
> Trace; c01053f0 <default_idle+0/40>
> Trace; c010ac88 <call_do_IRQ+6/e>
> Trace; c01053f0 <default_idle+0/40>
> Trace; c01053f0 <default_idle+0/40>
> Trace; c010541c <default_idle+2c/40>
> Trace; c0105492 <cpu_idle+42/60>
> Trace; c0105000 <_stext+0/0>
> Trace; c0105042 <rest_init+42/50>
> Code;  fa8222a0 <[ide-scsi]idescsi_end_request+70/290>
> 0000000000000000 <_EIP>:
> Code;  fa8222a0 <[ide-scsi]idescsi_end_request+70/290>   <=====
>    0:   c7 80 7c 01 00 00 00      movl   $0x70000,0x17c(%eax)   <=====
> Code;  fa8222a6 <[ide-scsi]idescsi_end_request+76/290>
>    7:   00 07 00 
> Code;  fa8222aa <[ide-scsi]idescsi_end_request+7a/290>
>    a:   83 7c 24 14 00            cmpl   $0x0,0x14(%esp,1)
> Code;  fa8222ae <[ide-scsi]idescsi_end_request+7e/290>
>    f:   0f 84 97 01 00 00         je     1ac <_EIP+0x1ac> fa82244c <[ide-scsi]idescsi_end_request+21c/290>
> 
>  <0>Kernel panic: Aiee, killing interrupt handler!
> cpu: 0, clocks: 2654982, slice: 884994
> cpu: 1, clocks: 2654982, slice: 884994
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
> Unable to handle kernel NULL pointer dereference at virtual address 0000017c
> fa8222a1
> *pde = 00000000
> Oops: 0002
> CPU:    1
> EIP:    0010:[<fa8222a1>]    Not tainted
> EFLAGS: 00010002
> eax: 00000000   ebx: f7ade540   ecx: 00000000   edx: f7ade540
> esi: fa81b760   edi: 00000080   ebp: f7a00000   esp: c2019e98
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c2019000)
> Stack: f7ade540 fa81b760 00000080 fa81b720 00000080 00000000 f7ade540 f7eb93c0 
>        fa81b760 fa80f422 00000000 f7e875c0 fa81b760 f7e875c0 fa8224c0 00000080 
>        fa810060 fa81b760 fa817f42 00000080 f7e875c0 fa80fec0 00000000 c02e4d40 
> Call Trace: [<fa81b760>] [<fa81b720>] [<fa81b760>] [<fa80f422>] [<fa81b760>] 
>    [<fa8224c0>] [<fa810060>] [<fa81b760>] [<fa817f42>] [<fa80fec0>] [<c011faa5>] 
>    [<c011bebc>] [<c011bd8d>] [<c011bb0f>] [<c0108b1b>] [<c01053f0>] [<c01053f0>] 
>    [<c010ac88>] [<c01053f0>] [<c01053f0>] [<c010541c>] [<c0105492>] [<c0117b6f>] 
>    [<c0117a7e>] 
> Code: c7 80 7c 01 00 00 00 00 07 00 83 7c 24 14 00 0f 84 97 01 00 
> 
> >>EIP; fa8222a0 <[ide-scsi]idescsi_end_request+70/290>   <=====
> Trace; fa81b760 <[ide-mod]ide_hwifs+40/1ec8>
> Trace; fa81b720 <[ide-mod]ide_hwifs+0/1ec8>
> Trace; fa81b760 <[ide-mod]ide_hwifs+40/1ec8>
> Trace; fa80f422 <[ide-mod]ide_error+122/170>
> Trace; fa81b760 <[ide-mod]ide_hwifs+40/1ec8>
> Trace; fa8224c0 <[ide-scsi]idescsi_pc_intr+0/240>
> Trace; fa810060 <[ide-mod]ide_timer_expiry+1a0/200>
> Trace; fa81b760 <[ide-mod]ide_hwifs+40/1ec8>
> Trace; fa817f42 <[ide-mod]ide_hwif_to_major+5a0/257c>
> Trace; fa80fec0 <[ide-mod]ide_timer_expiry+0/200>
> Trace; c011faa4 <timer_bh+264/2c0>
> Trace; c011bebc <bh_action+4c/90>
> Trace; c011bd8c <tasklet_hi_action+5c/90>
> Trace; c011bb0e <do_softirq+6e/d0>
> Trace; c0108b1a <do_IRQ+da/f0>
> Trace; c01053f0 <default_idle+0/40>
> Trace; c01053f0 <default_idle+0/40>
> Trace; c010ac88 <call_do_IRQ+6/e>
> Trace; c01053f0 <default_idle+0/40>
> Trace; c01053f0 <default_idle+0/40>
> Trace; c010541c <default_idle+2c/40>
> Trace; c0105492 <cpu_idle+42/60>
> Trace; c0117b6e <release_console_sem+8e/a0>
> Trace; c0117a7e <printk+11e/140>
> Code;  fa8222a0 <[ide-scsi]idescsi_end_request+70/290>
> 0000000000000000 <_EIP>:
> Code;  fa8222a0 <[ide-scsi]idescsi_end_request+70/290>   <=====
>    0:   c7 80 7c 01 00 00 00      movl   $0x70000,0x17c(%eax)   <=====
> Code;  fa8222a6 <[ide-scsi]idescsi_end_request+76/290>
>    7:   00 07 00 
> Code;  fa8222aa <[ide-scsi]idescsi_end_request+7a/290>
>    a:   83 7c 24 14 00            cmpl   $0x0,0x14(%esp,1)
> Code;  fa8222ae <[ide-scsi]idescsi_end_request+7e/290>
>    f:   0f 84 97 01 00 00         je     1ac <_EIP+0x1ac> fa82244c <[ide-scsi]idescsi_end_request+21c/290>
> 
>  <0>Kernel panic: Aiee, killing interrupt handler!
> -- 
> Got freedom?  Vote Libertarian:  http://www.lp.org

-- 
Got freedom?  Vote Libertarian:  http://www.lp.org
