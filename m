Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311745AbSCNTdX>; Thu, 14 Mar 2002 14:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311746AbSCNTdO>; Thu, 14 Mar 2002 14:33:14 -0500
Received: from swszl.szkp.uni-miskolc.hu ([193.6.2.24]:49599 "EHLO
	swszl.szkp.uni-miskolc.hu") by vger.kernel.org with ESMTP
	id <S311745AbSCNTdJ>; Thu, 14 Mar 2002 14:33:09 -0500
Date: Thu, 14 Mar 2002 20:33:03 +0100
From: Vitez Gabor <gabor@swszl.szkp.uni-miskolc.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre2-ac4 -- audio related oops with quake2
Message-ID: <20020314193303.GA23086@swszl.szkp.uni-miskolc.hu>
In-Reply-To: <E16jpmG-0002oZ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16jpmG-0002oZ-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I can simply oops Linux-2.4.19-pre2-ac4: start quake2, it will start
playing a weird looping noise.. Exit, start again; quake2 dies with
"segmentation fault" and the kernel oopses.

Rebooting, and setting quake2's sound device to some random non-existing
file "cures" the problem.

Other similar software like mpg123, tuxracer work well.

The hardware is an Athlon 550, sitting on an ASUS K7V-RM motherboard 
(VIA KX133 chipset).
Sound device: onboard, via82cxxx driver.

Distribution used is fresh debian woody, updated daily.

The oops looks like this:
--
ksymoops 2.4.3 on i686 2.4.19-pre2-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre2-ac4/ (default)
     -m /boot/System.map-2.4.19-pre2-ac4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

ac97_codec: AC97 Audio codec, id: 0x4352:0x5934 (Cirrus Logic CS4299 rev D)
Unable to handle kernel NULL pointer dereference at virtual address 00000010
c0121cf5
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0121cf5>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210202
eax: c1d0000c   ebx: c2cdc2c0   ecx: c4954d40   edx: c4954d40
esi: 00000000   edi: c1d0000c   ebp: c4f00598   esp: c5d41ed4
ds: 0018   es: 0018   ss: 0018
Process quake2 (pid: 7419, stackpage=c5d41000)
Stack: c2cdc2c0 40166000 40166000 c138e400 c0121e5b c2cdc2c0 c4954d40 40166000 
       00000001 c4f00598 c2cdc2c0 40166000 c2cdc2dc c4954d40 c01112f7 c2cdc2c0 
       c4954d40 40166000 00000001 c5d40000 00000006 c01111e0 bffff91c 00000001 
Call Trace: [<c0121e5b>] [<c01112f7>] [<c01111e0>] [<c017acd8>] [<c01120c9>] 
   [<c0106dd4>] 
Code: 8b 5e 10 03 5e 04 e8 d0 80 00 00 3b 5e 18 73 0a 6a 30 e8 04 

>>EIP; c0121cf4 <do_no_page+134/1d0>   <=====
Trace; c0121e5a <handle_mm_fault+ca/140>
Trace; c01112f6 <do_page_fault+116/434>
Trace; c01111e0 <do_page_fault+0/434>
Trace; c017acd8 <tty_write+198/210>
Trace; c01120c8 <schedule+1f8/210>
Trace; c0106dd4 <error_code+34/3c>
Code;  c0121cf4 <do_no_page+134/1d0>
00000000 <_EIP>:
Code;  c0121cf4 <do_no_page+134/1d0>   <=====
   0:   8b 5e 10                  mov    0x10(%esi),%ebx   <=====
Code;  c0121cf6 <do_no_page+136/1d0>
   3:   03 5e 04                  add    0x4(%esi),%ebx
Code;  c0121cfa <do_no_page+13a/1d0>
   6:   e8 d0 80 00 00            call   80db <_EIP+0x80db> c0129dce <activate_page_nolock+13e/140>
Code;  c0121cfe <do_no_page+13e/1d0>
   b:   3b 5e 18                  cmp    0x18(%esi),%ebx
Code;  c0121d02 <do_no_page+142/1d0>
   e:   73 0a                     jae    1a <_EIP+0x1a> c0121d0e <do_no_page+14e/1d0>
Code;  c0121d04 <do_no_page+144/1d0>
  10:   6a 30                     push   $0x30
Code;  c0121d06 <do_no_page+146/1d0>
  12:   e8 04 00 00 00            call   1b <_EIP+0x1b> c0121d0e <do_no_page+14e/1d0>


1 warning issued.  Results may not be reliable.
--
It looks like bad ram, but I can reproduce it any time, and memtest86
finds nothing during a 30 minute run.

2.4.18 plays only noise too, but it does not oops.

lsmod looks like this:
Module                  Size  Used by    Not tainted
ipt_MASQUERADE          1248   1 (autoclean)
iptable_nat            12852   1 (autoclean) [ipt_MASQUERADE]
ipt_state                608   2 (autoclean)
ip_conntrack_ftp        3200   0 (unused)
ip_conntrack           13036   3 [ipt_MASQUERADE iptable_nat ipt_state ip_conntrack_ftp]
iptable_filter          1760   1
ip_tables              10560   6 [ipt_MASQUERADE iptable_nat ipt_state iptable_filter]
af_packet              11784   1 (autoclean)
via82cxxx_audio        18432   0
ac97_codec              9632   0 [via82cxxx_audio]
uart401                 6144   0 [via82cxxx_audio]
sound                  53580   0 [via82cxxx_audio uart401]
soundcore               3364   4 [via82cxxx_audio sound]
w83781d                17152   0 (unused)
i2c-proc                6176   0 [w83781d]
i2c-viapro              3752   0 (unused)
i2c-core               12616   0 [w83781d i2c-proc i2c-viapro]
mga                   103632   1
agpgart                12608   3
via-rhine              12452   2
mii                     1088   0 [via-rhine]


lspci:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:04.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 20)
00:09.0 Ethernet controller: VIA Technologies, Inc. Ethernet Controller (rev 43)
00:0b.0 Ethernet controller: VIA Technologies, Inc. Ethernet Controller (rev 42)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)

Third party modules: lm_sensors and i2c 2.6.2

Other information is available at: http://swszl.szkp.uni-miskolc.hu/~gabor/oops/
(full lspci, kernel configuration, ver_linux output)

	Regards:
		Gabor Vitez

