Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSG2K4E>; Mon, 29 Jul 2002 06:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSG2K4E>; Mon, 29 Jul 2002 06:56:04 -0400
Received: from bru-cse-369.cisco.com ([144.254.12.31]:58604 "EHLO
	bru-cse-369.cisco.com") by vger.kernel.org with ESMTP
	id <S314829AbSG2Kzw>; Mon, 29 Jul 2002 06:55:52 -0400
Date: Mon, 29 Jul 2002 12:58:34 +0200
From: Marc Duponcheel <mduponch@cisco.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Justin Guyett <justin@soze.net>
Subject: Re: 2.4.19-rc2 -> 2.4.19-rc3 : no more eth (fwd)
Message-ID: <20020729105833.GA9055@cisco.com>
Reply-To: Marc Duponcheel <mduponch@cisco.com>
References: <Pine.LNX.4.44.0207232309370.30729-100000@freak.distro.conectiva> <3D3E1FB8.20CB0F@zip.com.au> <20020725170131.GA22527@cisco.com> <3D404F41.77537E67@zip.com.au> <20020726133851.GC22527@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020726133851.GC22527@cisco.com>
User-Agent: Mutt/1.4i
Organization: Cisco Systems
X-uname: SunOS 5.8 sun4u
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Dear kernel crew,

I have recompiled 2.4.19-rc3 on 3 machines with gcc 3.1.1 and
basically there is no better news. Two machines still work fine and
one still does not recognise any PCI card (indeed, the PCI SCSI
interface module (which currently has nothing attached) is, just like
the 2 PCI eth interfaces, also stuck in 'initialising').

I have saved both 'dmesg' outputs just after reboot.

here is the output of
 diff dmesg-2.4.18 dmesg-2.4.19-rc3

I wonder, could there be some miscalculation of memory?  Is the
missing 'machine check' of any relevance?

I personally don't see any other potential significant issue in the
diff but maybe someone else does...

Thanks for your time

=============================================================================
1c1
< Linux version 2.4.18 (root@server) (gcc version 3.1) #1 Sun Jun 9 15:18:29 CEST 2002
---
> Linux version 2.4.19-rc3 (root@server) (gcc version 3.1.1) #1 Sat Jul 27 15:49:04 CEST 2002
10a11
> 255MB LOWMEM available.
14a16
> Kernel command line: BOOT_IMAGE=2.4.19-rc3 root=301 devfs=mount
17d18
< Kernel command line: auto BOOT_IMAGE=2.4.18 root=301 devfs=mount
19c20
< Detected 804.041 MHz processor.
---
> Detected 804.044 MHz processor.
22,24c23,25
< Memory: 256156k/262060k available (972k kernel code, 5516k reserved, 232k data, 232k init, 0k highmem)
< Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
< Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
---
> Memory: 257120k/262060k available (1005k kernel code, 4552k reserved, 378k data, 108k init, 0k highmem)
> Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
> Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
33,34d33
< Intel machine check architecture supported.
< Intel machine check reporting enabled on CPU#0.
47,50c46,49
< ..... CPU clock speed is 804.0473 MHz.
< ..... host bus clock speed is 134.0078 MHz.
< cpu: 0, clocks: 1340078, slice: 670039
< CPU0<T0:1340064,T1:670016,D:9,S:670039,C:1340078>
---
> ..... CPU clock speed is 804.0347 MHz.
> ..... host bus clock speed is 134.0057 MHz.
> cpu: 0, clocks: 1340057, slice: 670028
> CPU0<T0:1340048,T1:670016,D:4,S:670028,C:1340057>
64c63
< devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
---
> devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
79d77
< block: 128 slots per queue, batch=32
82,84c80,82
< PIIX4: IDE controller on PCI bus 00 dev f9
< PIIX4: chipset revision 2
< PIIX4: not 100% native mode: will probe irqs later
---
> ICH2: IDE controller on PCI bus 00 dev f9
> ICH2: chipset revision 2
> ICH2: not 100% native mode: will probe irqs later
101c99
< Freeing unused kernel memory: 232k freed
---
> Freeing unused kernel memory: 108k freed
105c103
< usb-uhci.c: $Revision: 1.275 $ time 15:26:28 Jun  9 2002
---
> usb-uhci.c: $Revision: 1.275 $ time 15:56:00 Jul 27 2002
128,129c126,127
< pcwd: v1.10 (06/05/99) Ken Hollis (kenji@bitgate.com)
< pcwd: No card detected, or port not available.
---
> pcwd: v1.13 (03/06/2002) Ken Hollis (kenji@bitgate.com)
> pcwd: No card detected, or port not available
135c133
< hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
---
> hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
138,156c136,177
< eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
< eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
< PCI: Found IRQ 10 for device 02:0b.0
< PCI: Sharing IRQ 10 with 00:1f.4
< eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:02:B3:28:5B:7E, IRQ 10.
<   Board assembly 752438-006, Physical connectors present: RJ45
<   Primary interface chip i82555 PHY #1.
<     Secondary interface chip i82555.
<   General self-test: passed.
<   Serial sub-system self-test: passed.
<   Internal registers self-test: passed.
<   ROM checksum self-test: passed (0x3258698e).
< PCI: Found IRQ 11 for device 02:0c.0
< 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
< 02:0c.0: 3Com PCI 3c900 Cyclone 10Mbps TPO at 0xd000. Vers LK1.1.16
< CSLIP: code copyright 1989 Regents of the University of California
< PPP generic driver version 2.4.1
< iplog uses obsolete (PF_INET,SOCK_PACKET)
< device eth0 entered promiscuous mode
---
> Unable to handle kernel paging request at virtual address d0ca6620
>  printing eip:
> c01a1ef7
> *pde = 0ff12067
> *pte = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c01a1ef7>]    Not tainted
> EFLAGS: 00010292
> eax: d0ca6620   ebx: ffffffea   ecx: c102c01c   edx: c0227cc4
> esi: d0cb5d40   edi: 00000000   ebp: d0cb1000   esp: cf633ef8
> ds: 0018   es: 0018   ss: 0018
> Process modprobe (pid: 357, stackpage=cf633000)
> Stack: c0227cb0 c102c01c ffffffea 00000000 00000000 d0cb4342 d0cb5d40 00000000 
>        ffffffea c011d78b d0cb1060 08083f38 00004d30 00000000 08088744 0000486c 
>        00000060 00000060 00000008 cfc79ea0 cf5df000 cf5b0000 00000060 d0cae000 
> Call Trace:    [<d0cb4342>] [<d0cb5d40>] [<c011d78b>] [<d0cb1060>] [<d0cb1060>]
>   [<c010900b>]
> 
> Code: 89 30 8b 1d c8 26 23 c0 89 35 d4 26 23 c0 89 46 04 81 fb c8 
>  <1>Unable to handle kernel paging request at virtual address d0ca6620
>  printing eip:
> c01a1ef7
> *pde = 0ff12067
> *pte = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c01a1ef7>]    Not tainted
> EFLAGS: 00010292
> eax: d0ca6620   ebx: ffffffea   ecx: c102c01c   edx: c0227cd0
> esi: d0cbdc00   edi: 00000000   ebp: d0cb7000   esp: cf633ef8
> ds: 0018   es: 0018   ss: 0018
> Process modprobe (pid: 382, stackpage=cf633000)
> Stack: c0227cb0 c102c01c ffffffea 00000000 00000000 d0cbb579 d0cbdc00 ffffffea 
>        00000000 c011d78b d0cb7060 08086c70 00006c08 00000000 0808cf70 00006360 
>        00000060 00000060 00000005 cfc79ee0 cf588000 cf589000 00000060 d0cb1000 
> Call Trace:    [<d0cbb579>] [<d0cbdc00>] [<c011d78b>] [<d0cb7060>] [<d0cb7060>]
>   [<c010900b>]
> 
> Code: 89 30 8b 1d c8 26 23 c0 89 35 d4 26 23 c0 89 46 04 81 fb c8 
>  <6>CSLIP: code copyright 1989 Regents of the University of California
> PPP generic driver version 2.4.2
159d179
< lp0: compatibility mode
161d180
< ip_conntrack (2047 buckets, 16376 max)
162a182
> ip_conntrack (2047 buckets, 16376 max)
164,167c184,202
< PCI: Found IRQ 5 for device 02:0a.0
< scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
<         <Adaptec 2930CU SCSI adapter>
<         aic7860: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs
---
> Unable to handle kernel paging request at virtual address d0ca6620
>  printing eip:
> c01a1ef7
> *pde = 0ff12067
> *pte = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c01a1ef7>]    Not tainted
> EFLAGS: 00010296
> eax: d0ca6620   ebx: 00000202   ecx: c102c01c   edx: c0227ce8
> esi: d0d705c0   edi: 00000000   ebp: d0d704c0   esp: cd219e9c
> ds: 0018   es: 0018   ss: 0018
> Process modprobe (pid: 1378, stackpage=cd219000)
> Stack: c0227cb0 c0227e30 00000202 00000000 d0d704c0 d0d58423 d0d705c0 00000202 
>        d0d53962 d0d704c0 00001000 00000202 00000000 00000001 d0d4571c d0d704c0 
>        c0227cb0 c0227e14 000001ff 00000203 00000000 c100001c c123b04c c0227cb0 
> Call Trace:    [<d0d704c0>] [<d0d58423>] [<d0d705c0>] [<d0d53962>] [<d0d704c0>]
>   [<d0d4571c>] [<d0d704c0>] [<d0d57181>] [<d0d704c0>] [<d0d704c0>] [<c011d78b>]
>   [<d0d53060>] [<d0d6ff28>] [<d0d53060>] [<c010900b>]
169c204,205
< loop: loaded (max 8 devices)
---
> Code: 89 30 8b 1d c8 26 23 c0 89 35 d4 26 23 c0 89 46 04 81 fb c8 
>  <6>loop: loaded (max 8 devices)
172,174d207
< eth0: no IPv6 routers present
< eth1: no IPv6 routers present
< Universal TUN/TAP device driver 1.4 (C)1999-2001 Maxim Krasnyansky
176,177c209,213
< printer.c: v0.8:USB Printer Device Class driver
< NET4: AppleTalk 0.18a for Linux NET4.0
---
> printer.c: v0.11: USB Printer Device Class driver
> usb-uhci.c: interrupt, status 3, frame# 524
> usb.c: USB disconnect on device 2
> hub.c: USB new device connect on bus1/1, assigned device number 3
> input0:  USB Mouse STD.   on usb1:3.0
=============================================================================


On Fri, Jul 26, 2002 at 03:38:51PM +0200, Marc Duponcheel wrote:
>    Justin Guyett <justin@soze.net>
> Subject: Re: 2.4.19-rc2 -> 2.4.19-rc3 : no more eth (fwd)
> 
> I apologise for the delay, I have a lot of work recently ...
> 
> Regarding the idea to troubleshoot the 2.4.19-rc2 -> 2.4.19-rc3
> changes step by step : Of course that should reveal the culprit but,
> unfortunately, the only (1 out of 3) host on which I see the issue
> happens to be my main headless server in the wiring closet which I
> cannot reboot so often.
> 
> It runs 2.4.18 again now.
> 
> Someone else thought this might be bacause of changes in hotplug so I
> can try to turn off CONFIG_HOTPLUG (but I do need CONFIG_HOTPLUG).
> 
> Still, I will do my best to investigate further, and, when 2.4.19 new
> versions come out (rc or not) I will always test again.
> 
> PS: I see gcc 3.1.1 is on the cygnus ftp server so next time I might
> try that compiler as well.
> 
> Have a great weekend and thanks all
> 
> On Thu, Jul 25, 2002 at 12:19:29PM -0700, Andrew Morton wrote:
> > Marc Duponcheel wrote:
> > > 
> > > On Tue, Jul 23, 2002 at 08:32:08PM -0700, Andrew Morton wrote:
> > > > Marcelo Tosatti wrote:
> > > ...
> > > > > Warning (compare_Version): Version mismatch.  3c59x says 2.4.18, System.map says 2.4.19.  Expect lots of address mismatches.
> > > >
> > > > This is a worry.  Are we sure it was a clean build?
> > > > Please do a `make mrproper' and retest?
> > > 
> > >  Recall,
> > > 
> > > This is about ethernet interfaces not initialising (and hence not working)
> > > with 2.4.19-rc3 (they do initialise and work with 2.4.19-rc2).
> > > 
> > > As suggested, I have, for all certainty, repatched linux-2.4.18.tar.gz with patch-2.4.19-rc3.gz
> > > and rebuilt from a 'mrproper' /usr/src/linux, but the issue remains.
> > > 
> > > This time I ran ksymoops on the 2.4.19-rc3 system so no more mismatches
> > > 
> > > When doing 'lsmod' one sees the modules eepro100 and 3c59x as 'initialising'
> > > and one cannot 'rmmod' them because they are 'busy'.
> > > 
> > 
> > Odd.  There's not a lot of difference between -rc2 and -rc3.
> > The entire diff is below.  You didn't switch compilers or
> > something?
> > 
> >  Makefile                               |    2 
> >  arch/i386/kernel/apm.c                 |    4 -
> >  arch/i386/kernel/pci-irq.c             |    4 +
> >  arch/i386/kernel/traps.c               |   11 ++--
> >  drivers/char/agp/agp.h                 |    3 +
> >  drivers/char/agp/agpgart_be.c          |   12 ++++
> >  drivers/ide/ide-features.c             |    6 ++
> >  drivers/ide/ide-pci.c                  |    2 
> >  drivers/media/radio/radio-zoltrix.c    |    3 -
> >  drivers/net/wireless/orinoco_plx.c     |    2 
> >  drivers/pci/names.c                    |   10 +--
> >  drivers/pci/quirks.c                   |   16 ++++++
> >  drivers/scsi/aha152x.c                 |    6 ++
> >  drivers/scsi/atp870u.c                 |   23 ++++++--
> >  drivers/scsi/megaraid.c                |    8 +--
> >  drivers/scsi/scsi_scan.c               |    9 +++
> >  drivers/sound/cs4232.c                 |   38 ++++++++++++++
> >  drivers/sound/maestro.c                |   10 +++
> >  drivers/usb/rtl8150.c                  |    2 
> >  include/linux/agp_backend.h            |    1 
> >  include/linux/pci_ids.h                |    8 +--
> >  include/linux/personality.h            |    3 -
> >  mm/shmem.c                             |    1 
> >  net/ipv4/netfilter/ip_conntrack_core.c |    8 +--
> >  net/rose/af_rose.c                     |    6 +-
> >  scripts/kernel-doc                     |   86 +++++++++++++++++++++++++--------
> >  26 files changed, 226 insertions, 58 deletions
> > 
> > Could you please back out the changes until the problem
> > goes away?
> > 
> > This script which someone wrote will break the diff into
> > standalone chunks.   Suggest you start with the patch
> > against drivers/pci/names.c.
> > 
> > #!/usr/bin/perl -w
> > $out = "";
> > while (<>) {
> > 	next if (/^Only/);
> > 	next if (/^Binary/);
> > 	if (/^diff/ || /^Index/) {
> > 		if ($out) {
> > 			close OUT;
> > 		}
> > 		(@out) = split(' ', $_);
> > 		shift(@out) if (/^diff/);
> > 		$out = pop(@out);
> > 		$out =~ s:/*usr/:/:;
> > 		$out =~ s:/*src/:/:;
> > 		$out =~ s:^/*linux[^/]*::;
> > 		$out =~ s:\(w\)::;
> > 		next if ($out eq "");
> > 		$out = "/var/tmp/patches/$out";
> > 		$dir = $out;
> > 		$dir =~ s:/[^/]*$::;
> > 		print STDERR "$out\n";
> > 		system("mkdir -p $dir");
> > 		open(OUT, ">$out") || die("cannot open $out");
> > 	}
> > 	if ($out) {
> > 		print OUT $_;
> > 	}
> > }
> > 
> > diff -uNrp linux-2.4.19-rc2/Makefile linux-2.4.19-rc3/Makefile
> > --- linux-2.4.19-rc2/Makefile	Sun Jul 21 20:16:21 2002
> > +++ linux-2.4.19-rc3/Makefile	Sun Jul 21 22:07:56 2002
> > @@ -1,7 +1,7 @@
> >  VERSION = 2
> >  PATCHLEVEL = 4
> >  SUBLEVEL = 19
> > -EXTRAVERSION = -rc2
> > +EXTRAVERSION = -rc3
> >  
> >  KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
> >  
> > diff -uNrp linux-2.4.19-rc2/arch/i386/kernel/apm.c linux-2.4.19-rc3/arch/i386/kernel/apm.c
> > --- linux-2.4.19-rc2/arch/i386/kernel/apm.c	Sun Jul 21 20:16:22 2002
> > +++ linux-2.4.19-rc3/arch/i386/kernel/apm.c	Sun Jul 21 22:07:56 2002
> > @@ -1198,12 +1198,12 @@ static int suspend(int vetoable)
> >  		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
> >  	}
> >  	get_time_diff();
> > -	cli();
> > +	__cli();
> >  	err = set_system_power_state(APM_STATE_SUSPEND);
> >  	reinit_timer();
> >  	set_time();
> >  	ignore_normal_resume = 1;
> > -	sti();
> > +	__sti();
> >  	if (err == APM_NO_ERROR)
> >  		err = APM_SUCCESS;
> >  	if (err != APM_SUCCESS)
> > diff -uNrp linux-2.4.19-rc2/arch/i386/kernel/pci-irq.c linux-2.4.19-rc3/arch/i386/kernel/pci-irq.c
> > --- linux-2.4.19-rc2/arch/i386/kernel/pci-irq.c	Sun Jul 21 20:16:22 2002
> > +++ linux-2.4.19-rc3/arch/i386/kernel/pci-irq.c	Sun Jul 21 22:07:56 2002
> > @@ -489,6 +489,10 @@ static struct irq_router pirq_routers[] 
> >  	  pirq_serverworks_get, pirq_serverworks_set },
> >  	{ "AMD756 VIPER", PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_740B,
> >  		pirq_amd756_get, pirq_amd756_set },
> > +	{ "AMD766", PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7413,
> > +		pirq_amd756_get, pirq_amd756_set },
> > +	{ "AMD768", PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_VIPER_7443,
> > +		pirq_amd756_get, pirq_amd756_set },
> >  
> >  	{ "default", 0, 0, NULL, NULL }
> >  };
> > diff -uNrp linux-2.4.19-rc2/arch/i386/kernel/traps.c linux-2.4.19-rc3/arch/i386/kernel/traps.c
> > --- linux-2.4.19-rc2/arch/i386/kernel/traps.c	Sun Jul 21 20:16:22 2002
> > +++ linux-2.4.19-rc3/arch/i386/kernel/traps.c	Sun Jul 21 22:07:56 2002
> > @@ -139,14 +139,14 @@ void show_trace(unsigned long * stack)
> >  	if (!stack)
> >  		stack = (unsigned long*)&stack;
> >  
> > -	printk("Call Trace: ");
> > +	printk("Call Trace:   ");
> >  	i = 1;
> >  	while (((long) stack & (THREAD_SIZE-1)) != 0) {
> >  		addr = *stack++;
> >  		if (kernel_text_address(addr)) {
> >  			if (i && ((i % 6) == 0))
> > -				printk("\n   ");
> > -			printk("[<%08lx>] ", addr);
> > +				printk("\n ");
> > +			printk(" [<%08lx>]", addr);
> >  			i++;
> >  		}
> >  	}
> > @@ -618,9 +618,10 @@ void math_error(void *eip)
> >  		default:
> >  			break;
> >  		case 0x001: /* Invalid Op */
> > -		case 0x040: /* Stack Fault */
> > -		case 0x240: /* Stack Fault | Direction */
> > +		case 0x041: /* Stack Fault */
> > +		case 0x241: /* Stack Fault | Direction */
> >  			info.si_code = FPE_FLTINV;
> > +			/* Should we clear the SF or let user space do it ???? */
> >  			break;
> >  		case 0x002: /* Denormalize */
> >  		case 0x010: /* Underflow */
> > diff -uNrp linux-2.4.19-rc2/drivers/char/agp/agp.h linux-2.4.19-rc3/drivers/char/agp/agp.h
> > --- linux-2.4.19-rc2/drivers/char/agp/agp.h	Sun Jul 21 20:16:24 2002
> > +++ linux-2.4.19-rc3/drivers/char/agp/agp.h	Sun Jul 21 22:07:59 2002
> > @@ -265,6 +265,9 @@ struct agp_bridge_data {
> >  #ifndef PCI_DEVICE_ID_AL_M1651_0
> >  #define PCI_DEVICE_ID_AL_M1651_0	0x1651
> >  #endif
> > +#ifndef PCI_DEVICE_ID_AL_M1671_0
> > +#define PCI_DEVICE_ID_AL_M1671_0	0x1671
> > +#endif
> >  
> >  /* intel register */
> >  #define INTEL_APBASE    0x10
> > diff -uNrp linux-2.4.19-rc2/drivers/char/agp/agpgart_be.c linux-2.4.19-rc3/drivers/char/agp/agpgart_be.c
> > --- linux-2.4.19-rc2/drivers/char/agp/agpgart_be.c	Sun Jul 21 20:16:24 2002
> > +++ linux-2.4.19-rc3/drivers/char/agp/agpgart_be.c	Sun Jul 21 22:07:59 2002
> > @@ -3946,6 +3946,12 @@ static struct {
> >  		"Ali",
> >  		"M1651",
> >  		ali_generic_setup },  
> > +	{ PCI_DEVICE_ID_AL_M1671_0,
> > +		PCI_VENDOR_ID_AL,
> > +		ALI_M1671,
> > +		"Ali",
> > +		"M1671",
> > +		ali_generic_setup },  
> >  	{ 0,
> >  		PCI_VENDOR_ID_AL,
> >  		ALI_GENERIC,
> > @@ -4094,6 +4100,12 @@ static struct {
> >  		"SiS",
> >  		"735",
> >  		sis_generic_setup },
> > +	{ PCI_DEVICE_ID_SI_745,
> > +		PCI_VENDOR_ID_SI,
> > +		SIS_GENERIC,
> > +		"SiS",
> > +		"745",
> > +		sis_generic_setup },
> >  	{ PCI_DEVICE_ID_SI_730,
> >  		PCI_VENDOR_ID_SI,
> >  		SIS_GENERIC,
> > diff -uNrp linux-2.4.19-rc2/drivers/ide/ide-features.c linux-2.4.19-rc3/drivers/ide/ide-features.c
> > --- linux-2.4.19-rc2/drivers/ide/ide-features.c	Sun Jul 21 20:16:25 2002
> > +++ linux-2.4.19-rc3/drivers/ide/ide-features.c	Sun Jul 21 22:07:59 2002
> > @@ -240,13 +240,16 @@ int set_transfer (ide_drive_t *drive, id
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_BLK_DEV_IDEDMA
> >  /*
> >   *  All hosts that use the 80c ribbon mus use!
> >   */
> >  byte eighty_ninty_three (ide_drive_t *drive)
> >  {
> > +#ifdef CONFIG_BLK_DEV_IDEPCI
> >  	if (HWIF(drive)->pci_devid.vid==0x105a)
> >  	    return(HWIF(drive)->udma_four);
> > +#endif
> >  	/* PDC202XX: that's because some HDD will return wrong info */
> >  	return ((byte) ((HWIF(drive)->udma_four) &&
> >  #ifndef CONFIG_IDEDMA_IVB
> > @@ -254,6 +257,7 @@ byte eighty_ninty_three (ide_drive_t *dr
> >  #endif /* CONFIG_IDEDMA_IVB */
> >  			(drive->id->hw_config & 0x6000)) ? 1 : 0);
> >  }
> > +#endif // CONFIG_BLK_DEV_IDEDMA
> >  
> >  /*
> >   * Similar to ide_wait_stat(), except it never calls ide_error internally.
> > @@ -374,6 +378,8 @@ EXPORT_SYMBOL(ide_auto_reduce_xfer);
> >  EXPORT_SYMBOL(ide_driveid_update);
> >  EXPORT_SYMBOL(ide_ata66_check);
> >  EXPORT_SYMBOL(set_transfer);
> > +#ifdef CONFIG_BLK_DEV_IDEDMA
> >  EXPORT_SYMBOL(eighty_ninty_three);
> > +#endif // CONFIG_BLK_DEV_IDEDMA
> >  EXPORT_SYMBOL(ide_config_drive_speed);
> >  
> > diff -uNrp linux-2.4.19-rc2/drivers/ide/ide-pci.c linux-2.4.19-rc3/drivers/ide/ide-pci.c
> > --- linux-2.4.19-rc2/drivers/ide/ide-pci.c	Sun Jul 21 20:16:25 2002
> > +++ linux-2.4.19-rc3/drivers/ide/ide-pci.c	Sun Jul 21 22:07:59 2002
> > @@ -669,7 +669,7 @@ check_if_enabled:
> >  	 */
> >  	pciirq = dev->irq;
> >  	
> > -#ifdef CONFIG_PDC202XX_FORCE
> > +#ifndef CONFIG_PDC202XX_FORCE
> >  	if (dev->class >> 8 == PCI_CLASS_STORAGE_RAID) {
> >  		/*
> >  		 * By rights we want to ignore Promise FastTrak and SuperTrak
> > diff -uNrp linux-2.4.19-rc2/drivers/media/radio/radio-zoltrix.c linux-2.4.19-rc3/drivers/media/radio/radio-zoltrix.c
> > --- linux-2.4.19-rc2/drivers/media/radio/radio-zoltrix.c	Sun Sep 30 12:26:06 2001
> > +++ linux-2.4.19-rc3/drivers/media/radio/radio-zoltrix.c	Sun Jul 21 22:07:59 2002
> > @@ -23,6 +23,7 @@
> >   *		(can detect if station is in stereo)
> >   *	      - Added unmute function
> >   *	      - Reworked ioctl functions
> > + * 2002-07-15 - Fix Stereo typo
> >   */
> >  
> >  #include <linux/module.h>	/* Modules                        */
> > @@ -280,7 +281,7 @@ static int zol_ioctl(struct video_device
> >  			struct video_audio v;
> >  			memset(&v, 0, sizeof(v));
> >  			v.flags |= VIDEO_AUDIO_MUTABLE | VIDEO_AUDIO_VOLUME;
> > -			v.mode != zol_is_stereo(zol)
> > +			v.mode |= zol_is_stereo(zol)
> >  				? VIDEO_SOUND_STEREO : VIDEO_SOUND_MONO;
> >  			v.volume = zol->curvol * 4096;
> >  			v.step = 4096;
> > diff -uNrp linux-2.4.19-rc2/drivers/net/wireless/orinoco_plx.c linux-2.4.19-rc3/drivers/net/wireless/orinoco_plx.c
> > --- linux-2.4.19-rc2/drivers/net/wireless/orinoco_plx.c	Sun Jul 21 20:16:26 2002
> > +++ linux-2.4.19-rc3/drivers/net/wireless/orinoco_plx.c	Sun Jul 21 22:08:00 2002
> > @@ -385,7 +385,7 @@ static struct pci_driver orinoco_plx_dri
> >  	name:"orinoco_plx",
> >  	id_table:orinoco_plx_pci_id_table,
> >  	probe:orinoco_plx_init_one,
> > -	remove:orinoco_plx_remove_one,
> > +	remove:__devexit_p(orinoco_plx_remove_one),
> >  	suspend:0,
> >  	resume:0
> >  };
> > diff -uNrp linux-2.4.19-rc2/drivers/pci/names.c linux-2.4.19-rc3/drivers/pci/names.c
> > --- linux-2.4.19-rc2/drivers/pci/names.c	Fri Nov  9 14:03:11 2001
> > +++ linux-2.4.19-rc3/drivers/pci/names.c	Sun Jul 21 22:08:00 2002
> > @@ -32,18 +32,18 @@ struct pci_vendor_info {
> >   * real memory.. Parse the same file multiple times
> >   * to get all the info.
> >   */
> > -#define VENDOR( vendor, name )		static char __vendorstr_##vendor[] __initdata = name;
> > +#define VENDOR( vendor, name )		static char __vendorstr_##vendor[] __devinitdata = name;
> >  #define ENDVENDOR()
> > -#define DEVICE( vendor, device, name ) 	static char __devicestr_##vendor##device[] __initdata = name;
> > +#define DEVICE( vendor, device, name ) 	static char __devicestr_##vendor##device[] __devinitdata = name;
> >  #include "devlist.h"
> >  
> >  
> > -#define VENDOR( vendor, name )		static struct pci_device_info __devices_##vendor[] __initdata = {
> > +#define VENDOR( vendor, name )		static struct pci_device_info __devices_##vendor[] __devinitdata = {
> >  #define ENDVENDOR()			};
> >  #define DEVICE( vendor, device, name )	{ 0x##device, 0, __devicestr_##vendor##device },
> >  #include "devlist.h"
> >  
> > -static struct pci_vendor_info __initdata pci_vendor_list[] = {
> > +static struct pci_vendor_info __devinitdata pci_vendor_list[] = {
> >  #define VENDOR( vendor, name )		{ 0x##vendor, sizeof(__devices_##vendor) / sizeof(struct pci_device_info), __vendorstr_##vendor, __devices_##vendor },
> >  #define ENDVENDOR()
> >  #define DEVICE( vendor, device, name )
> > @@ -121,7 +121,7 @@ pci_class_name(u32 class)
> >  
> >  #else
> >  
> > -void __init pci_name_device(struct pci_dev *dev)
> > +void __devinit pci_name_device(struct pci_dev *dev)
> >  {
> >  }
> >  
> > diff -uNrp linux-2.4.19-rc2/drivers/pci/quirks.c linux-2.4.19-rc3/drivers/pci/quirks.c
> > --- linux-2.4.19-rc2/drivers/pci/quirks.c	Sun Jul 21 20:16:26 2002
> > +++ linux-2.4.19-rc3/drivers/pci/quirks.c	Sun Jul 21 22:08:00 2002
> > @@ -457,10 +457,26 @@ static void __init quirk_amd_ordering(st
> >  }
> >  
> >  /*
> > + *	DreamWorks provided workaround for Dunord I-3000 problem
> > + *
> > + *	This card decodes and responds to addresses not apparently
> > + *	assigned to it. We force a larger allocation to ensure that
> > + *	nothing gets put too close to it.
> > + */
> > +
> > +static void __init quirk_dunord ( struct pci_dev * dev )
> > +{
> > +	struct resource * r = & dev -> resource [ 1 ];
> > +	r -> start = 0;
> > +	r -> end = 0xffffff;
> > +}
> > +
> > +/*
> >   *  The main table of quirks.
> >   */
> >  
> >  static struct pci_fixup pci_fixups[] __initdata = {
> > +	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_DUNORD,	PCI_DEVICE_ID_DUNORD_I3000,	quirk_dunord },
> >  	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release },
> >  	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release },
> >  	/*
> > diff -uNrp linux-2.4.19-rc2/drivers/scsi/aha152x.c linux-2.4.19-rc3/drivers/scsi/aha152x.c
> > --- linux-2.4.19-rc2/drivers/scsi/aha152x.c	Sun Jul 21 20:16:27 2002
> > +++ linux-2.4.19-rc3/drivers/scsi/aha152x.c	Sun Jul 21 22:08:01 2002
> > @@ -1368,7 +1368,13 @@ int aha152x_detect(Scsi_Host_Template * 
> >  
> >  		printk(KERN_INFO "aha152x%d: trying software interrupt, ", HOSTNO);
> >  		SETPORT(DMACNTRL0, SWINT|INTEN);
> > +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> > +		spin_unlock_irq(&io_request_lock);
> > +#endif
> >  		mdelay(1000);
> > +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> > +		spin_lock_irq(&io_request_lock);
> > +#endif
> >  		free_irq(shpnt->irq, shpnt);
> >  
> >  		if (!HOSTDATA(shpnt)->swint) {
> > diff -uNrp linux-2.4.19-rc2/drivers/scsi/atp870u.c linux-2.4.19-rc3/drivers/scsi/atp870u.c
> > --- linux-2.4.19-rc2/drivers/scsi/atp870u.c	Sun Sep 30 12:26:07 2001
> > +++ linux-2.4.19-rc3/drivers/scsi/atp870u.c	Sun Jul 21 22:08:01 2002
> > @@ -11,7 +11,8 @@
> >   *		   enable 32 bit fifo transfer
> >   *		   support cdrom & remove device run ultra speed
> >   *		   fix disconnect bug  2000/12/21
> > - *		   support atp880 chip lvd u160 2001/05/15 (7.1)
> > + *		   support atp880 chip lvd u160 2001/05/15
> > + *		   fix prd table bug 2001/09/12 (7.1)
> >   */
> >  
> >  #include <linux/module.h>
> > @@ -803,8 +804,18 @@ oktosend:
> >  		sgpnt = (struct scatterlist *) workrequ->request_buffer;
> >  		i = 0;
> >  		for (j = 0; j < workrequ->use_sg; j++) {
> > -			(unsigned long) (((unsigned long *) (prd))[i >> 1]) = virt_to_bus(sgpnt[j].address);
> > -			(unsigned short int) (((unsigned short int *) (prd))[i + 2]) = sgpnt[j].length;
> > +			bttl = virt_to_bus(sgpnt[j].address);
> > +			l = sgpnt[j].length;
> > +			while (l > 0x10000) {
> > +				(unsigned short int) (((unsigned short int *) (prd))[i + 3]) = 0x0000;
> > +				(unsigned short int) (((unsigned short int *) (prd))[i + 2]) = 0x0000;
> > +				(unsigned long) (((unsigned long *) (prd))[i >> 1]) = bttl;
> > +				l -= 0x10000;
> > +				bttl += 0x10000;
> > +				i += 0x04;
> > +			}
> > +			(unsigned long) (((unsigned long *) (prd))[i >> 1]) = bttl;
> > +			(unsigned short int) (((unsigned short int *) (prd))[i + 2]) = l;
> >  			(unsigned short int) (((unsigned short int *) (prd))[i + 3]) = 0;
> >  			i += 0x04;
> >  		}
> > @@ -2527,7 +2538,7 @@ int atp870u_detect(Scsi_Host_Template * 
> >  		   host_id = inb(base_io + 0x39);
> >  		   host_id >>= 0x04;
> >  
> > -		   printk(KERN_INFO "   ACARD AEC-67160 PCI Ultra160 LVD/SE SCSI Adapter: %d    IO:%x, IRQ:%d.\n"
> > +		   printk(KERN_INFO "   ACARD AEC-67160 PCI Ultra3 LVD Host Adapter: %d    IO:%x, IRQ:%d.\n"
> >  			  ,h, base_io, irq);
> >  		   dev->ioport = base_io + 0x40;
> >  		   dev->pciport = base_io + 0x28;
> > @@ -2764,7 +2775,7 @@ const char *atp870u_info(struct Scsi_Hos
> >  {
> >  	static char buffer[128];
> >  
> > -	strcpy(buffer, "ACARD AEC-6710/6712/67160 PCI Ultra/W/LVD SCSI-3 Adapter Driver V2.5+ac ");
> > +	strcpy(buffer, "ACARD AEC-6710/6712/67160 PCI Ultra/W/LVD SCSI-3 Adapter Driver V2.6+ac ");
> >  
> >  	return buffer;
> >  }
> > @@ -2809,7 +2820,7 @@ int atp870u_proc_info(char *buffer, char
> >  	if (offset == 0) {
> >  		memset(buff, 0, sizeof(buff));
> >  	}
> > -	size += sprintf(BLS, "ACARD AEC-671X Driver Version: 2.5+ac\n");
> > +	size += sprintf(BLS, "ACARD AEC-671X Driver Version: 2.6+ac\n");
> >  	len += size;
> >  	pos = begin + len;
> >  	size = 0;
> > diff -uNrp linux-2.4.19-rc2/drivers/scsi/megaraid.c linux-2.4.19-rc3/drivers/scsi/megaraid.c
> > --- linux-2.4.19-rc2/drivers/scsi/megaraid.c	Sun Jul 21 20:16:41 2002
> > +++ linux-2.4.19-rc3/drivers/scsi/megaraid.c	Sun Jul 21 22:08:01 2002
> > @@ -3076,10 +3076,12 @@ static int mega_findCard (Scsi_Host_Temp
> >  			/*
> >  			 * which firmware
> >  			 */
> > -			if( strcmp(megaCfg->fwVer, "H01.07") == 0 ||
> > -					strcmp(megaCfg->fwVer, "H01.08") == 0 ) {
> > +			if( strcmp(megaCfg->fwVer, "H01.07") == 0 || 
> > +			    strcmp(megaCfg->fwVer, "H01.08") == 0 ||
> > +			    strcmp(megaCfg->fwVer, "H01.09") == 0 )
> > +			{
> >  				printk(KERN_WARNING
> > -						"megaraid: Firmware H.01.07 or H.01.08 on 1M/2M "
> > +						"megaraid: Firmware H.01.07/8/9 on 1M/2M "
> >  						"controllers\nmegaraid: do not support 64 bit "
> >  						"addressing.\n"
> >  						"megaraid: DISABLING 64 bit support.\n");
> > diff -uNrp linux-2.4.19-rc2/drivers/scsi/scsi_scan.c linux-2.4.19-rc3/drivers/scsi/scsi_scan.c
> > --- linux-2.4.19-rc2/drivers/scsi/scsi_scan.c	Sun Jul 21 20:16:41 2002
> > +++ linux-2.4.19-rc3/drivers/scsi/scsi_scan.c	Sun Jul 21 22:08:01 2002
> > @@ -110,6 +110,10 @@ static struct dev_info device_list[] =
> >  	{"HP", "C1750A", "3226", BLIST_NOLUN},			/* scanjet iic */
> >  	{"HP", "C1790A", "", BLIST_NOLUN},			/* scanjet iip */
> >  	{"HP", "C2500A", "", BLIST_NOLUN},			/* scanjet iicx */
> > +	{"HP", "A6188A", "*", BLIST_SPARSELUN},			/* HP Va7100 Array */
> > +	{"HP", "A6189A", "*", BLIST_SPARSELUN},			/* HP Va7400 Array */
> > +	{"HP", "A6189B", "*", BLIST_SPARSELUN},			/* HP Va7410 Array */
> > +	{"HP", "OPEN-", "*", BLIST_SPARSELUN},			/* HP XP Arrays */
> >  	{"YAMAHA", "CDR100", "1.00", BLIST_NOLUN},		/* Locks up if polled for lun != 0 */
> >  	{"YAMAHA", "CDR102", "1.00", BLIST_NOLUN},		/* Locks up if polled for lun != 0  
> >  								 * extra reset */
> > @@ -173,7 +177,10 @@ static struct dev_info device_list[] =
> >  	{"HP", "C1557A", "*", BLIST_FORCELUN},
> >  	{"IBM", "AuSaV1S2", "*", BLIST_FORCELUN},
> >  	{"FSC", "CentricStor", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
> > -
> > +	{"DDN", "SAN DataDirector", "*", BLIST_SPARSELUN},
> > +	{"HITACHI", "DF400", "*", BLIST_SPARSELUN},
> > +	{"HITACHI", "DF500", "*", BLIST_SPARSELUN},
> > +	{"HITACHI", "DF600", "*", BLIST_SPARSELUN},
> >  
> >  	/*
> >  	 * Must be at end of list...
> > diff -uNrp linux-2.4.19-rc2/drivers/sound/cs4232.c linux-2.4.19-rc3/drivers/sound/cs4232.c
> > --- linux-2.4.19-rc2/drivers/sound/cs4232.c	Mon Feb 25 11:38:04 2002
> > +++ linux-2.4.19-rc3/drivers/sound/cs4232.c	Sun Jul 21 22:08:01 2002
> > @@ -34,6 +34,8 @@
> >   * anyway.
> >   *
> >   * Changes
> > + *      John Rood               Added Bose Sound System Support.
> > + *      Toshio Spoor
> >   *	Alan Cox		Modularisation, Basic cleanups.
> >   *      Paul Barton-Davis	Separated MPU configuration, added
> >   *                                       Tropez+ (WaveFront) support
> > @@ -58,6 +60,10 @@
> >  
> >  #define KEY_PORT	0x279	/* Same as LPT1 status port */
> >  #define CSN_NUM		0x99	/* Just a random number */
> > +#define INDEX_ADDRESS   0x00    /* (R0) Index Address Register */
> > +#define INDEX_DATA      0x01    /* (R1) Indexed Data Register */
> > +#define PIN_CONTROL     0x0a    /* (I10) Pin Control */
> > +#define ENABLE_PINS     0xc0    /* XCTRL0/XCTRL1 enable */
> >  
> >  static void CS_OUT(unsigned char a)
> >  {
> > @@ -67,6 +73,7 @@ static void CS_OUT(unsigned char a)
> >  #define CS_OUT2(a, b)		{CS_OUT(a);CS_OUT(b);}
> >  #define CS_OUT3(a, b, c)	{CS_OUT(a);CS_OUT(b);CS_OUT(c);}
> >  
> > +static int __initdata bss       = 0;
> >  static int mpu_base = 0, mpu_irq = 0;
> >  static int synth_base = 0, synth_irq = 0;
> >  static int mpu_detected = 0;
> > @@ -97,6 +104,30 @@ static void sleep(unsigned howlong)
> >  	schedule_timeout(howlong);
> >  }
> >  
> > +static void enable_xctrl(int baseio)
> > +{
> > +        unsigned char regd;
> > +                
> > +        /*
> > +         * Some IBM Aptiva's have the Bose Sound System. By default
> > +         * the Bose Amplifier is disabled. The amplifier will be 
> > +         * activated, by setting the XCTRL0 and XCTRL1 bits.
> > +         * Volume of the monitor bose speakers/woofer, can then
> > +         * be set by changing the PCM volume.
> > +         *
> > +         */
> > +                
> > +        printk("cs4232: enabling Bose Sound System Amplifier.\n");
> > +        
> > +        /* Switch to Pin Control Address */                   
> > +        regd = inb(baseio + INDEX_ADDRESS) & 0xe0;
> > +        outb(((unsigned char) (PIN_CONTROL | regd)), baseio + INDEX_ADDRESS );
> > +        
> > +        /* Activate the XCTRL0 and XCTRL1 Pins */
> > +        regd = inb(baseio + INDEX_DATA);
> > +        outb(((unsigned char) (ENABLE_PINS | regd)), baseio + INDEX_DATA );
> > +}
> > +
> >  int __init probe_cs4232(struct address_info *hw_config, int isapnp_configured)
> >  {
> >  	int i, n;
> > @@ -275,6 +306,11 @@ void __init attach_cs4232(struct address
> >  		}
> >  		hw_config->slots[1] = hw_config2.slots[1];
> >  	}
> > +	
> > +	if (bss)
> > +	{
> > +        	enable_xctrl(base);
> > +	}
> >  }
> >  
> >  void unload_cs4232(struct address_info *hw_config)
> > @@ -349,6 +385,8 @@ MODULE_PARM(synthirq,"i");
> >  MODULE_PARM_DESC(synthirq,"Maui WaveTable IRQ");
> >  MODULE_PARM(isapnp,"i");
> >  MODULE_PARM_DESC(isapnp,"Enable ISAPnP probing (default 1)");
> > +MODULE_PARM(bss,"i");
> > +MODULE_PARM_DESC(bss,"Enable Bose Sound System Support (default 0)");
> >  
> >  /*
> >   *	Install a CS4232 based card. Need to have ad1848 and mpu401
> > diff -uNrp linux-2.4.19-rc2/drivers/sound/maestro.c linux-2.4.19-rc3/drivers/sound/maestro.c
> > --- linux-2.4.19-rc2/drivers/sound/maestro.c	Sun Jul 21 20:16:41 2002
> > +++ linux-2.4.19-rc3/drivers/sound/maestro.c	Sun Jul 21 22:08:01 2002
> > @@ -3569,9 +3569,19 @@ maestro_probe(struct pci_dev *pcidev,con
> >  static void maestro_remove(struct pci_dev *pcidev) {
> >  	struct ess_card *card = pci_get_drvdata(pcidev);
> >  	int i;
> > +	u32 n;
> >  	
> >  	/* XXX maybe should force stop bob, but should be all 
> >  		stopped by _release by now */
> > +
> > +	/* Turn off hardware volume control interrupt.
> > +	   This has to come before we leave the IRQ below,
> > +	   or a crash results if a button is pressed ! */
> > +
> > +	n = inw(card->iobase+0x18);
> > +	n&=~(1<<6);
> > +	outw(n, card->iobase+0x18);
> > +
> >  	free_irq(card->irq, card);
> >  	unregister_sound_mixer(card->dev_mixer);
> >  	for(i=0;i<NR_DSPS;i++)
> > diff -uNrp linux-2.4.19-rc2/drivers/usb/rtl8150.c linux-2.4.19-rc3/drivers/usb/rtl8150.c
> > --- linux-2.4.19-rc2/drivers/usb/rtl8150.c	Sun Jul 21 20:16:42 2002
> > +++ linux-2.4.19-rc3/drivers/usb/rtl8150.c	Sun Jul 21 22:08:01 2002
> > @@ -84,7 +84,7 @@ MODULE_DEVICE_TABLE (usb, rtl8150_table)
> >  
> >  
> >  struct rtl8150 {
> > -	unsigned int		flags;
> > +	unsigned long		flags;
> >  	struct usb_device	*udev;
> >  	struct usb_interface	*interface;
> >  	struct semaphore	sem;
> > diff -uNrp linux-2.4.19-rc2/include/linux/agp_backend.h linux-2.4.19-rc3/include/linux/agp_backend.h
> > --- linux-2.4.19-rc2/include/linux/agp_backend.h	Sun Jul 21 20:16:44 2002
> > +++ linux-2.4.19-rc3/include/linux/agp_backend.h	Sun Jul 21 22:08:04 2002
> > @@ -73,6 +73,7 @@ enum chipset_type {
> >  	ALI_M1644,
> >  	ALI_M1647,
> >  	ALI_M1651,
> > +	ALI_M1671,
> >  	ALI_GENERIC,
> >  	SVWRKS_HE,
> >  	SVWRKS_LE,
> > diff -uNrp linux-2.4.19-rc2/include/linux/pci_ids.h linux-2.4.19-rc3/include/linux/pci_ids.h
> > --- linux-2.4.19-rc2/include/linux/pci_ids.h	Sun Jul 21 20:16:44 2002
> > +++ linux-2.4.19-rc3/include/linux/pci_ids.h	Sun Jul 21 22:08:04 2002
> > @@ -1602,13 +1602,15 @@
> >  #define PCI_DEVICE_ID_S3_ViRGE_MXPMV	0x8c03
> >  #define PCI_DEVICE_ID_S3_SONICVIBES	0xca00
> >  
> > +#define PCI_VENDOR_ID_DUNORD		0x5544
> > +#define PCI_DEVICE_ID_DUNORD_I3000	0x0001
> > +#define PCI_VENDOR_ID_GENROCO		0x5555
> > +#define PCI_DEVICE_ID_GENROCO_HFP832	0x0003
> > +
> >  #define PCI_VENDOR_ID_DCI		0x6666
> >  #define PCI_DEVICE_ID_DCI_PCCOM4	0x0001
> >  #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
> >  
> > -#define PCI_VENDOR_ID_GENROCO		0x5555
> > -#define PCI_DEVICE_ID_GENROCO_HFP832	0x0003
> > -
> >  #define PCI_VENDOR_ID_INTEL		0x8086
> >  #define PCI_DEVICE_ID_INTEL_21145	0x0039
> >  #define PCI_DEVICE_ID_INTEL_82375	0x0482
> > diff -uNrp linux-2.4.19-rc2/include/linux/personality.h linux-2.4.19-rc3/include/linux/personality.h
> > --- linux-2.4.19-rc2/include/linux/personality.h	Sun Jul 21 20:16:44 2002
> > +++ linux-2.4.19-rc3/include/linux/personality.h	Sun Jul 21 22:08:04 2002
> > @@ -62,7 +62,8 @@ enum {
> >  	PER_RISCOS =		0x000c,
> >  	PER_SOLARIS =		0x000d | STICKY_TIMEOUTS,
> >  	PER_UW7 =		0x000e | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
> > -	PER_OSF4 =		0x000f,			 /* OSF/1 v4 */
> > +	PER_HPUX =		0x000f,
> > +	PER_OSF4 =		0x0010,			 /* OSF/1 v4 */
> >  	PER_MASK =		0x00ff,
> >  };
> >  
> > diff -uNrp linux-2.4.19-rc2/mm/shmem.c linux-2.4.19-rc3/mm/shmem.c
> > --- linux-2.4.19-rc2/mm/shmem.c	Sun Jul 21 20:16:44 2002
> > +++ linux-2.4.19-rc3/mm/shmem.c	Sun Jul 21 22:08:04 2002
> > @@ -905,7 +905,6 @@ out:
> >  fail_write:
> >  	status = -EFAULT;
> >  	ClearPageUptodate(page);
> > -	kunmap(page);
> >  	goto unlock;
> >  }
> >  
> > diff -uNrp linux-2.4.19-rc2/net/ipv4/netfilter/ip_conntrack_core.c linux-2.4.19-rc3/net/ipv4/netfilter/ip_conntrack_core.c
> > --- linux-2.4.19-rc2/net/ipv4/netfilter/ip_conntrack_core.c	Sun Jul 21 20:16:44 2002
> > +++ linux-2.4.19-rc3/net/ipv4/netfilter/ip_conntrack_core.c	Sun Jul 21 22:08:04 2002
> > @@ -497,11 +497,9 @@ init_conntrack(const struct ip_conntrack
> >  		/* Try dropping from random chain, or else from the
> >                     chain about to put into (in case they're trying to
> >                     bomb one hash chain). */
> > -		if (drop_next == ip_conntrack_htable_size-1)
> > -			drop_next = 0;
> > -		else
> > -			drop_next++;
> > -		if (!early_drop(&ip_conntrack_hash[drop_next])
> > +		unsigned int next = (drop_next++)%ip_conntrack_htable_size;
> > +
> > +		if (!early_drop(&ip_conntrack_hash[next])
> >  		    && !early_drop(&ip_conntrack_hash[hash])) {
> >  			if (net_ratelimit())
> >  				printk(KERN_WARNING
> > diff -uNrp linux-2.4.19-rc2/net/rose/af_rose.c linux-2.4.19-rc3/net/rose/af_rose.c
> > --- linux-2.4.19-rc2/net/rose/af_rose.c	Sun Jul 21 20:16:44 2002
> > +++ linux-2.4.19-rc3/net/rose/af_rose.c	Sun Jul 21 22:08:04 2002
> > @@ -26,6 +26,7 @@
> >   *
> >   *  ROSE 0.63	Jean-Paul(F6FBB) Fixed wrong length of L3 packets
> >   *					Added CLEAR_REQUEST facilities
> > + *  ROSE 0.64	Jean-Paul(F6FBB) Fixed null pointer in rose_kill_by_device
> >   */
> >  
> >  #include <linux/config.h>
> > @@ -227,7 +228,8 @@ static void rose_kill_by_device(struct n
> >  	for (s = rose_list; s != NULL; s = s->next) {
> >  		if (s->protinfo.rose->device == dev) {
> >  			rose_disconnect(s, ENETUNREACH, ROSE_OUT_OF_ORDER, 0);
> > -			s->protinfo.rose->neighbour->use--;
> > +			if (s->protinfo.rose->neighbour)
> > +				s->protinfo.rose->neighbour->use--;
> >  			s->protinfo.rose->device = NULL;
> >  		}
> >  	}
> > @@ -1433,7 +1435,7 @@ static struct notifier_block rose_dev_no
> >  
> >  static struct net_device *dev_rose;
> >  
> > -static const char banner[] = KERN_INFO "F6FBB/G4KLX ROSE for Linux. Version 0.63 for AX25.037 Linux 2.4\n";
> > +static const char banner[] = KERN_INFO "F6FBB/G4KLX ROSE for Linux. Version 0.64 for AX25.037 Linux 2.4\n";
> >  
> >  static int __init rose_proto_init(void)
> >  {
> 
> -- 
> --
>  Greetings,
> 
> Marc Duponcheel     Multicast Development Engineer      Cisco Systems
> email: mduponch@cisco.com tel: +32 2 704 52 40 cell: +32 478 68 10 91
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
--
 Greetings,

Marc Duponcheel     Multicast Development Engineer      Cisco Systems
email: mduponch@cisco.com tel: +32 2 704 52 40 cell: +32 478 68 10 91
