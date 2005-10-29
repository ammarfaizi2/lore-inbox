Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbVJ2T6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVJ2T6u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 15:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVJ2T6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 15:58:50 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:11170 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1751273AbVJ2T6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 15:58:49 -0400
Date: Sat, 29 Oct 2005 21:58:47 +0200
From: Folkert van Heusden <folkert@vanheusden.com>
To: linux-kernel@vger.kernel.org
Cc: linux.nics@intel.com
Subject: Fw: kernel panic with 2.6.13.3 and a Intel Corp. 82547EI Gigabit
	Ethernet Controller (LOM)
Message-ID: <20051029195847.GV23731@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Reply-By: Fri Oct 28 09:42:57 CEST 2005
X-MSMail-Priority: High
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Reproducable i get a kernel panic when inserting the e1000 module on my
system. Kernel 2.6.13.3.
It is P4 with hyperthreading enabled. 1GB ram.
lspci output:
00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro Ultra TF
02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet Controller (LOM)
03:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
03:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
03:0a.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 50)
03:0a.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 50)
03:0a.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
03:0b.0 Communication controller: Individual Computers - Jens Schoenfeld Intel 537
03:0c.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
03:0c.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
03:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)

I've placed the .config here: http://keetweej.vanheusden.com/~folkert/e1000_crash_.config
dmesg output (when the system starts, don't have it from a crash as the system frashes hard): http://keetweej.vanheusden.com/~folkert/e1000_crash_dmesg
screendump (so that one can verify if I didn't make any typing errors): http://keetweej.vanheusden.com/~folkert/e1000_crash_screendump.jpg

Ok and what is written in the dump:
c013dfc0 handle_irq_event+0x50/0x60
c0105796 __do_irq+0xc6/0x70
c0103796 common_interrupt+0x1a/0x20
c01f1768 acpi_processor_idle+0x10d/0x2b1
c0100d70 cpu_idle+0x70/0x80
c03ca8db start_kernel+0x14b/0x170

Code: 44 24 0c 0f 31 89 44 24 04 b9 04 etc. (hand to handwrite it down)


Linux muur 2.6.13.3-pwc #9 SMP Wed Oct 26 21:49:05 CEST 2005 i686
unknown unknown GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.1.1
util-linux             2.12h
mount                  2.12h
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          2001------------->
reiser4progs           line
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.5
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.2.1
Modules Loaded         wcfxo zaptel netconsole police sch_ingress
cls_u32 sch_sfq sch_cbq ipt_limit tuner tvaudio bttv video_buf
firmware_class i2c_algo_bit btcx_risc tveeprom ipt_state pl2303
usbserial audio nfs ipt_REJECT ipt_MASQUERADE ipt_TOS iptable_mangle
usbnet bsd_comp w83627hf eeprom i2c_sensor i2c_isa i2c_core soundcore
snd_page_alloc ip6table_filter ip6_tables iptable_filter ide_cd cdrom
parport_pc parport microcode nfsd exportfs lockd sunrpc ipv6 rtl8150
3c59x mii iptable_nat ip_conntrack ip_tables ppp_deflate zlib_deflate
zlib_inflate ppp_async crc_ccitt ppp_generic slip slhc genrtc rd


Folkert van Heusden

- -- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
- ----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
- ----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iIMEARECAEMFAkNj1Hc8Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiusXgAn0ry5MhI
sKShkC8pR9iYMiKO+MMVAJ9f/BdI6QsthuYT5Tl1LN68QoQ0UQ==
=xmnB
-----END PGP SIGNATURE-----
