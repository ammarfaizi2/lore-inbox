Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVDDKXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVDDKXT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 06:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVDDKXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 06:23:19 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:23813 "EHLO
	BAYC1-PASMTP03.cez.ice") by vger.kernel.org with ESMTP
	id S261211AbVDDKXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 06:23:01 -0400
Message-ID: <BAYC1-PASMTP03A4A4DD478BB2FC220CE1E13B0@cez.ice>
X-Originating-IP: [209.226.122.45]
X-Originating-Email: [mostly_harmless@sympatico.ca]
Message-ID: <002401c53900$9a47b0e0$1d2aa8c0@stormie>
From: "Don Guy" <mostly_harmless@sympatico.ca>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: v2.4.29 won't compile with PCI support disabled
Date: Mon, 4 Apr 2005 06:25:15 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-OriginalArrivalTime: 04 Apr 2005 10:22:57.0684 (UTC) FILETIME=[45633540:01C53900]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PROBLEM:

Attempts to compile v2.4.29 with PCI support disabled result in the
following errors:

drivers/char/char.o: In function `siig10x_init_fn':
drivers/char/char.o(.text.init+0x12cd): undefined reference to
`pci_siig10x_fn'
drivers/char/char.o: In function `siig20x_init_fn':
drivers/char/char.o(.text.init+0x12ed): undefined reference to
`pci_siig20x_fn'

It has been suggested that enabling PCI support in the kernel will make this
go away however a) enabling PCI support on a 486 which only has ISA & VLB is
downright silly, and b) a test run with CONFIG_PCI=y resulted in a plethora
of other errors.

Current kernel version: Linux version 2.4.5 (root@bigkitty) (gcc version
2.95.3 20010315 (release)) #10
Fri Jun 22 02:20:21 PDT 2001

>From .config:
    #
    # General setup
    CONFIG_NET=y
    # CONFIG_PCI is not set
    CONFIG_ISA=y
    # CONFIG_EISA is not set
    # CONFIG_MCA is not set
    # CONFIG_HOTPLUG is not set
    # CONFIG_PCMCIA is not set
    # CONFIG_HOTPLUG_PCI is not set
    CONFIG_SYSVIPC=y
    # CONFIG_BSD_PROCESS_ACCT is not set
    CONFIG_SYSCTL=y
    # CONFIG_KCORE_AOUT is not set
    CONFIG_BINFMT_AOUT=y
    CONFIG_BINFMT_ELF=y
    CONFIG_BINFMT_MISC=y
    CONFIG_OOM_KILLER=y
    # CONFIG_PM is not set
    # CONFIG_APM is not set


Software (from ver_linux):
    If some fields are empty or look unusual you may have an old version.
    Compare to the current minimal requirements in Documentation/Changes.

    Linux deepthought 2.4.5 #10 Fri Jun 22 02:20:21 PDT 2001 i486 unknown

    Gnu C                  2.95.3
    Gnu make               3.79.1
    binutils               2.11.90.0.19
    util-linux             2.11f
    mount                  2.11b
    modutils               2.4.16
    e2fsprogs              1.27
    PPP                    2.4.1
    awk: cmd. line:2: (FILENAME=- FNR=1) fatal: attempt to access field -1
    Dynamic linker (ldd)   2.3.4
    Procps                 2.0.7
    Net-tools              1.60
    Kbd                    1.06
    Sh-utils               2.0
    Modules Loaded         ne 8390 isa-pnp ppp_deflate ppp_async ppp_generic
lp parport_pc parport


Processor (from /proc/cpuinfo):
    processor       : 0
    vendor_id       : unknown
    cpu family      : 4
    model           : 0
    model name      : 486
    stepping        : unknown
    fdiv_bug        : no
    hlt_bug         : no
    f00f_bug        : no
    coma_bug        : no
    fpu             : yes
    fpu_exception   : no
    cpuid level     : -1
    wp              : yes
    flags           :
    bogomips        : 33.17

Modules (from /proc/modules):
    ne                      6720   1
    8390                    6112   0 [ne]
    isa-pnp                27400   0 [ne]
    ppp_deflate            39008   0 (unused)
    ppp_async               6624   0 (unused)
    ppp_generic            16648   0 [ppp_deflate ppp_async]
    lp                      5888   0 (unused)
    parport_pc             19172   1
    parport                23040   1 [lp parport_pc]

Loaded driver and hardware information (from /proc/ioports, /proc/iomem):
    0000-001f : dma1
    0020-003f : pic1
    0040-005f : timer
    0060-006f : keyboard
    0070-007f : rtc
    0080-008f : dma page reg
    00a0-00bf : pic2
    00c0-00df : dma2
    00f0-00ff : fpu
    0240-025f : eth0
    02f8-02ff : serial(set)
    0330-0333 : aha1542
    0378-037a : parport0
    03c0-03df : vga+
    03f8-03ff : serial(auto)

    00000000-0009efff : System RAM
    000a0000-000bffff : Video RAM area
    000c0000-000c7fff : Video ROM
    000c8000-000cbfff : Extension ROM
    000f0000-000fffff : System ROM
    00100000-01ffffff : System RAM
      00100000-002beda7 : Kernel code
      002beda8-0039a7e7 : Kernel data

PCI Information:
    n/a

SCSI information (from /proc/scsi/scsi):
    Attached devices:
    Host: scsi0 Channel: 00 Id: 00 Lun: 00
      Vendor: SEAGATE  Model: ST34572WS        Rev: HP00
      Type:   Direct-Access                    ANSI SCSI revision: 02
    Host: scsi0 Channel: 00 Id: 01 Lun: 00
      Vendor: SEAGATE  Model: ST34572W         Rev: 0876
      Type:   Direct-Access                    ANSI SCSI revision: 02
    Host: scsi0 Channel: 00 Id: 04 Lun: 00
      Vendor: TOSHIBA  Model: CD-ROM XM-3701TA Rev: 0236
      Type:   CD-ROM                           ANSI SCSI revision: 02
    Host: scsi0 Channel: 00 Id: 05 Lun: 00
      Vendor: PIONEER  Model: CD-ROM DR-124X   Rev: 1.00
      Type:   CD-ROM                           ANSI SCSI revision: 02
    Host: scsi0 Channel: 00 Id: 06 Lun: 00
      Vendor: ARCHIVE  Model: Python 25501-XXX Rev: 5.AC
      Type:   Sequential-Access                ANSI SCSI revision: 02


Any help appreciated!

-d.

