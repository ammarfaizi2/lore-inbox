Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132555AbRCZT3D>; Mon, 26 Mar 2001 14:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132572AbRCZT2z>; Mon, 26 Mar 2001 14:28:55 -0500
Received: from mout03.kundenserver.de ([195.20.224.218]:59664 "EHLO
	mout03.kundenserver.de") by vger.kernel.org with ESMTP
	id <S132555AbRCZT2n>; Mon, 26 Mar 2001 14:28:43 -0500
Date: Mon, 26 Mar 2001 20:32:39 +0200
From: Alex Riesen <vmagic@users.sourceforge.net>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI power-off doesn't work on Asus CUV4X (VIA Apollo 133)
Message-ID: <20010326203238.A449@steel>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE7B2@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE7B2@orsmsx35.jf.intel.com>; from andrew.grover@intel.com on Mon, Mar 26, 2001 at 10:35:33AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2001 at 10:35:33AM -0800, Grover, Andrew wrote:
> > > > As i recompiled 2.4.2-ac20 with ACPI support
> > > > the system cannot switch itself off.
> > > > I get a message "Couldn't switch to S5" if
> > > > At load it shows that the mode is supported.
> > > 
> > > Same with AMR P6BAP-AP and P6VAP-AP () mainboards.
> 
> > > #define APCI_DEBUG 1 has NO effect on verbosity of messages :-(
> 
> The ACPI version in the kernel has debug messages stripped, for historical
> reasons. There is a non-stripped version available at
> http://developer.intel.com/technology/iapc/acpi/downloads.htm but this also
...
> 
> Either try the version on the website, or make this change and see if it
> helps:
> 
> 	drivers/acpi/hardware/hwsleep.c (at the bottom) :
> 
> 	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_a_CONTROL, PM1_acontrol);
> 	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_b_CONTROL, PM1_bcontrol);
> 	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_CONTROL,     <-- remove
> these
> 		(1 << acpi_hw_get_bit_shift (SLP_EN_MASK)));     <--

Didn't help for me. Exactly the same result.
I think about to try the driver from above...

Some details (from bios boot screen):

Award Medallion BIOS v6.0
ASUS CUV4X ACPI BIOS Revision 1006

bottom line:
07/25/2000-VT6942-CUV4X

Cannot tell whether ASUS have update for this BIOS,
because it looks that i dont get their page loaded in next 100 years
with the damned slow link i have. This may be the reason i'll
not try the original driver, too :-(


Usuals:
/proc/cpuinfo:
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 701.607
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 3
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1399.19


/proc/pci:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8605 [ProSavage PM133] (rev 129).
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8605 [PM133 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   4, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 34).
  Bus  0, device   4, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 16).
      Master Capable.  Latency=32.  
      I/O at 0xd800 [0xd80f].
  Bus  0, device   4, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 16).
      IRQ 10.
      Master Capable.  Latency=32.  
      I/O at 0xd400 [0xd41f].
  Bus  0, device   4, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 16).
      IRQ 10.
      Master Capable.  Latency=32.  
      I/O at 0xd000 [0xd01f].
  Bus  0, device   4, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 48).
  Bus  0, device  15, function  0:
    Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 6).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=12.Max Lat=128.
      I/O at 0xb800 [0xb83f].
  Bus  0, device  17, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 65).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=20.Max Lat=40.
      I/O at 0xb400 [0xb47f].
      Non-prefetchable 32 bit memory at 0xed800000 [0xed8003ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation GeForce 256 (rev 16).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xee000000 [0xeeffffff].
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].



