Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318002AbSGWJLr>; Tue, 23 Jul 2002 05:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318003AbSGWJLr>; Tue, 23 Jul 2002 05:11:47 -0400
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:20464 "HELO
	dardhal.mired.net") by vger.kernel.org with SMTP id <S318002AbSGWJLj>;
	Tue, 23 Jul 2002 05:11:39 -0400
Date: Tue, 23 Jul 2002 11:14:38 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [Build Errors] kernel version 2.5.27
Message-ID: <20020723091438.GB3455@localhost>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

Don't know if this can be helpful at all, but having a "powerful" (AMD XP
1700+, 256 MB DDR and 7200 rpm IDE disk) PC doing nothing most of the
time, I thought it could be doing something useful for the ongoing
development of the linux kernel. So I decided to do a full kernel compile 
(that is, a compile of the linux kernel with _all_ options enabled to be
compiled built-in, just a few as modules, those that can't be built
otherwise). And report errors that can happen, in the hope to unveil
them and make maintainers aware of them, should they still aren't.

.config file was created the "easy" way: going to all options shown in a
"make menuconfig" session, enabling everything to be built-in (when
possible), and making a second pass to check if some options were
activated by enabling some others. The file is 2206 lines long, but is
NOT attached, to help save bandwidth.

Installed software complies with versions stated in
Documentation/Changes, and current running kernel is 2.4.19-pre6aa1. The
testing procedure is as follows:

1) Unpack kernel sources under /usr/src
2) Set user and group ownership of all files just uncompressed to
   root:root => chown -Rv root:root /usr/src/linux-2.5.27
   (Yes, I know this is not needed of maybe even adviseable. Please tell
   if there is a better way to do things)
3) Run "make mrproper"
4) Copy a "master" config file to .config (all options enabled to be
   compiled built-in, as said before). If were are here due to build
   problems, use the modified .config to try to get a succesful build.
5) Run "make oldconfig"
6) Run "make dep". Report possible problems, try to disable the feature
   that caused the problem, and return to step 3.
7) Run "make bzImage". Report possible problems, try to disable the
   feature that caused the problem, and return to step 3.
8) Run "make modules". Report possible problems, try to disable the
   feature that caused the problem, and return to step 3.
9) Run "make modules_install". Report possible problems, try to disable
   the feature that caused the problem, and return to step 3.

Of course, if someone is doing something similar, the process is
badly thought of, or simply nobody sees it as useful, plese speak :). By
the way, could I use some kind of "compiler cacher" such as ccache or
compilercache to speed-up compiles without risk of getting partial or
incorrect kernel builds ?


So now for the "interesting" part: the testing and reporting of kernel
version 2.5.27 follows.


5) Run "make oldconfig". SUCCESS


6) Run "make dep". FAIL

ERROR #1
In file included from DAC960.c:49:
DAC960.h:2575: #error I am a non-portable driver, please convert me to use the Documentation/DMA-mapping.txt interfaces
TO CONTINUE: change .config to not include this driver (CONFIG_BLK_DEV_DAC960)

ERROR #2
i2c-old.c:17: linux/i2c-old.h: No such file or directory
TO CONTINUE: comment line 17 on file "drivers/media/video/i2c-old.c"

ERROR #3
i2o_core.c:25: #error Please convert me to Documentation/DMA-mapping.txt
TO CONTINUE: change .config to not include I2O support at all (CONFIG_I2O)


7) Run "make bzImage". FAIL

ERROR #1
In file included from cache.c:28:
/usr/src/linux-2.5.27/include/linux/intermezzo_fs.h:126: field `fset_nd' has incomplete type
TO CONTINUE: change .config to not include Intermezzo (CONFIG_INTERMEZZO_FS)

ERROR #2
   ld -m elf_i386  -r -o built-in.o hci_usb.o hci_vhci.o hci_uart.o dtl1_cs.o bluecard_cs.o
bluecard_cs.o(.data+0x40): multiple definition of `dev_list'
dtl1_cs.o(.data+0x40): first defined here
make[2]: *** [built-in.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/bluetooth'
TO CONTINUE: change .config to not include HCI BlueCard (PC Card) driver (CONFIG_BLUEZ_HCIBLUECARD)

ERROR #3
cyclades.c: In function `cy_detect_pci':
cyclades.c:5096: structure has no member named `resource'
cyclades.c:5097: structure has no member named `res_start'
cyclades.c:5098: structure has no member named `res_len'
cyclades.c:5286: structure has no member named `resource'
cyclades.c:5287: structure has no member named `res_start'
cyclades.c:5288: structure has no member named `res_len'
make[2]: *** [cyclades.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/char'
TO CONTINUE: change .config to not include Cyclades asyn multiport serial board (CONFIG_CYCLADES)

ERROR #4
pci_hotplug_core.c: In function `default_read_file':
pci_hotplug_core.c:186: parse error before `)'
pci_hotplug_core.c: In function `default_write_file':
pci_hotplug_core.c:192: parse error before `)'
pci_hotplug_core.c: In function `pcihpfs_create_by_name':
pci_hotplug_core.c:420: parse error before `)'
pci_hotplug_core.c: In function `power_read_file':
pci_hotplug_core.c:540: parse error before `)'
pci_hotplug_core.c: In function `power_write_file':
pci_hotplug_core.c:581: parse error before `)'
pci_hotplug_core.c: In function `attention_read_file':
pci_hotplug_core.c:651: parse error before `)'
pci_hotplug_core.c: In function `attention_write_file':
pci_hotplug_core.c:692: parse error before `)'
pci_hotplug_core.c: In function `latch_read_file':
pci_hotplug_core.c:744: parse error before `)'
pci_hotplug_core.c: In function `presence_read_file':
pci_hotplug_core.c:788: parse error before `)'
pci_hotplug_core.c: In function `test_write_file':
pci_hotplug_core.c:829: parse error before `)'
pci_hotplug_core.c: In function `pci_hotplug_init':
pci_hotplug_core.c:1073: parse error before `)'
make[2]: *** [pci_hotplug_core.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/hotplug'
TO CONTINUE: change .config to not include support for PCI HotPlug (CONFIG_HOTPLUG_PCI)

ERROR #5
ataraid.c: In function `ataraid_make_request':
ataraid.c:105: dereferencing pointer to incomplete type
ataraid.c:103: warning: `minor' might be used uninitialized in this
function
ataraid.c: In function `ataraid_get_bhead':
ataraid.c:123: sizeof applied to an incomplete type
ataraid.c: In function `ataraid_end_request':
ataraid.c:147: dereferencing pointer to incomplete type
ataraid.c:153: dereferencing pointer to incomplete type
ataraid.c: In function `ataraid_split_request':
ataraid.c:177: dereferencing pointer to incomplete type
ataraid.c:177: dereferencing pointer to incomplete type
ataraid.c:177: dereferencing pointer to incomplete type
ataraid.c:178: dereferencing pointer to incomplete type
ataraid.c:178: dereferencing pointer to incomplete type
ataraid.c:178: dereferencing pointer to incomplete type
ataraid.c:180: dereferencing pointer to incomplete type
ataraid.c:181: dereferencing pointer to incomplete type
ataraid.c:183: dereferencing pointer to incomplete type
ataraid.c:183: dereferencing pointer to incomplete type
ataraid.c:184: dereferencing pointer to incomplete type
ataraid.c:185: dereferencing pointer to incomplete type
ataraid.c:188: dereferencing pointer to incomplete type
ataraid.c:189: dereferencing pointer to incomplete type
ataraid.c:192: dereferencing pointer to incomplete type
ataraid.c:192: dereferencing pointer to incomplete type
ataraid.c:194: warning: passing arg 1 of `generic_make_request' makes
pointer from integer without a cast
ataraid.c:194: too many arguments to function `generic_make_request'
ataraid.c:195: warning: passing arg 1 of `generic_make_request' makes
pointer from integer without a cast
ataraid.c:195: too many arguments to function `generic_make_request'
ataraid.c: In function `ataraid_init':
ataraid.c:276: warning: passing arg 2 of `blk_queue_make_request' from
incompatible pointer type
make[2]: *** [ataraid.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/ide'
TO CONTINUE: change .config to not include support for IDE Raid controllers (CONFIG_BLK_DEV_ATARAID)

ERROR #6
q40kbd.c:42: asm/q40_master.h: No such file or directory
q40kbd.c:44: asm/q40ints.h: No such file or directory
q40kbd.c: In function `q40kbd_interrupt':
q40kbd.c:62: `IRQ_KEYB_MASK' undeclared (first use in this function)
q40kbd.c:62: (Each undeclared identifier is reported only once
q40kbd.c:62: for each function it appears in.)
q40kbd.c:62: warning: implicit declaration of function `master_inb'
q40kbd.c:62: `INTERRUPT_REG' undeclared (first use in this function)
q40kbd.c:64: `KEYCODE_REG' undeclared (first use in this function)
q40kbd.c:66: warning: implicit declaration of function `master_outb'
q40kbd.c:66: `KEYBOARD_UNLOCK_REG' undeclared (first use in this
function)
q40kbd.c:60: warning: unused variable `flags'
q40kbd.c: In function `q40kbd_init':
q40kbd.c:77: `Q40_IRQ_KEYBOARD' undeclared (first use in this function)
q40kbd.c:80: `IRQ_KEYB_MASK' undeclared (first use in this function)
q40kbd.c:80: `INTERRUPT_REG' undeclared (first use in this function)
q40kbd.c:81: `KEYCODE_REG' undeclared (first use in this function)
q40kbd.c:84: `KEYBOARD_UNLOCK_REG' undeclared (first use in this
function)
q40kbd.c:85: `KEY_IRQ_ENABLE_REG' undeclared (first use in this
function)
q40kbd.c:87: warning: implicit declaration of function
`register_serio_port'
q40kbd.c: In function `q40kbd_exit':
q40kbd.c:93: warning: implicit declaration of function
`unregister_serio_port'
q40kbd.c:94: `Q40_IRQ_KEYBOARD' undeclared (first use in this function)
q40kbd.c: At top level:
q40kbd.c:98: warning: initialization from incompatible pointer type
make[2]: *** [q40kbd.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/input/serio'
TO CONTINUE: change .config to not include support for Q40 keyboard controller (CONFIG_SERIO_Q40KBD)
WORKAROUND/PATCH: see lkml "Subject: PATCH: Missing input config check"

ERROR #7
In file included from module.c:17:
capi.h:141: `msg' defined as wrong kind of tag
make[3]: *** [module.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.27/drivers/isdn/act2000'
TO CONTINUE: change .config to not include support for IBM Active 2000 (CONFIG_ISDN_DRV_ACT2000)

ERROR #8
lvm.c:1: #error Broken until maintainers will sanitize kdev_t handling
(many more errors, but I suppose these are a consequence of the above)
TO CONTINUE: change .config to not include support for LVM (CONFIG_BLK_DEV_LVM)

ERROR #9
miropcm20-rds-core.c: In function `aci_rds_cmd':
miropcm20-rds-core.c:186: `EINTR' undeclared (first use in this function)
miropcm20-rds-core.c:186: (Each undeclared identifier is reported only once
miropcm20-rds-core.c:186: for each function it appears in.)
make[3]: *** [miropcm20-rds-core.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.27/drivers/media/radio'
TO CONTINUE: change .config to not include support for miroSOUND PCM20 radio RDS user interface (CONFIG_RADIO_MIROPCM20)
WORKAROUND/PATCH: see lkml "Subject: PATCH: 2.5.27 correct headers so miropcm-rds builds"

ERROR #10
In file included from zr36120.c:43:
zr36120.h:29: linux/i2c-old.h: No such file or directory
In file included from zr36120.c:43:
zr36120.h:101: field `i2c' has incomplete type
zr36120.c: In function `zoran_muxsel':
zr36120.c:392: warning: implicit declaration of function `i2c_control_device'
zr36120.c:392: `I2C_DRIVERID_VIDEODECODER' undeclared (first use in this function)
zr36120.c:392: (Each undeclared identifier is reported only once
zr36120.c:392: for each function it appears in.)
zr36120.c: In function `zoran_common_open':
zr36120.c:738: `I2C_DRIVERID_VIDEODECODER' undeclared (first use in this function)
zr36120.c: In function `zoran_ioctl':
zr36120.c:1166: `I2C_DRIVERID_VIDEODECODER' undeclared (first use in this function)
zr36120.c:1440: `I2C_DRIVERID_TUNER' undeclared (first use in this function)
zr36120.c: At top level:
zr36120.c:1497: unknown field `open' specified in initializer
zr36120.c:1497: warning: initialization makes integer from pointer without a cast
zr36120.c:1498: unknown field `close' specified in initializer
zr36120.c:1498: warning: initialization from incompatible pointer type
zr36120.c:1499: unknown field `read' specified in initializer
zr36120.c:1500: unknown field `write' specified in initializer
zr36120.c:1500: warning: initialization makes integer from pointer without a cast
zr36120.c:1501: unknown field `poll' specified in initializer
zr36120.c:1501: warning: missing braces around initializer
zr36120.c:1501: warning: (near initialization for `zr36120_template.lock')
zr36120.c:1501: warning: initialization makes integer from pointer without a cast
zr36120.c:1502: unknown field `ioctl' specified in initializer
zr36120.c:1502: warning: initialization makes integer from pointer without a cast
zr36120.c:1503: unknown field `mmap' specified in initializer
zr36120.c:1503: warning: initialization makes integer from pointer without a cast
zr36120.c:1504: unknown field `minor' specified in initializer
zr36120.c:1833: unknown field `open' specified in initializer
zr36120.c:1833: warning: initialization makes integer from pointer without a cast
zr36120.c:1834: unknown field `close' specified in initializer
zr36120.c:1834: warning: initialization from incompatible pointer type
zr36120.c:1835: unknown field `read' specified in initializer
zr36120.c:1836: unknown field `write' specified in initializer
zr36120.c:1836: warning: initialization makes integer from pointer without a cast
zr36120.c:1837: unknown field `poll' specified in initializer
zr36120.c:1837: warning: missing braces around initializer
zr36120.c:1837: warning: (near initialization for `vbi_template.lock')
zr36120.c:1837: warning: initialization makes integer from pointer without a cast
zr36120.c:1838: unknown field `ioctl' specified in initializer
zr36120.c:1838: warning: initialization makes integer from pointer without a cast
zr36120.c:1839: unknown field `minor' specified in initializer
zr36120.c: In function `init_zoran':
zr36120.c:2013: warning: implicit declaration of function `i2c_register_bus'
zr36120.c: In function `release_zoran':
zr36120.c:2047: warning: implicit declaration of function `i2c_unregister_bus'
make[3]: *** [zr36120.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.27/drivers/media/video'
TO CONTINUE: comment line 43 on file "drivers/media/video/zr36120.c", change config file to not include support for Zoran ZR36120/36125 Video For Linux (CONFIG_VIDEO_ZR36120)

ERROR #11
i2c-parport.c:23: linux/i2c-old.h: No such file or directory
i2c-parport.c:33: field `i2c' has incomplete type
i2c-parport.c: In function `i2c_setlines':
i2c-parport.c:45: dereferencing pointer to incomplete type
i2c-parport.c: In function `i2c_getdataline':
i2c-parport.c:52: dereferencing pointer to incomplete type
i2c-parport.c: At top level:
i2c-parport.c:56: variable `parport_i2c_bus_template' has initializer but incomplete type
i2c-parport.c:58: warning: excess elements in struct initializer
i2c-parport.c:58: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:59: `I2C_BUSID_PARPORT' undeclared here (not in a function)
i2c-parport.c:59: warning: excess elements in struct initializer
i2c-parport.c:59: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:60: warning: excess elements in struct initializer
i2c-parport.c:60: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:62: warning: excess elements in struct initializer
i2c-parport.c:62: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:64: warning: excess elements in struct initializer
i2c-parport.c:64: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:65: warning: excess elements in struct initializer
i2c-parport.c:65: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:67: warning: excess elements in struct initializer
i2c-parport.c:67: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:68: warning: excess elements in struct initializer
i2c-parport.c:68: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:69: warning: excess elements in struct initializer
i2c-parport.c:69: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c:70: warning: excess elements in struct initializer
i2c-parport.c:70: warning: (near initialization for `parport_i2c_bus_template')
i2c-parport.c: In function `i2c_parport_attach':
i2c-parport.c:88: warning: implicit declaration of function `i2c_register_bus'
i2c-parport.c: In function `i2c_parport_detach':
i2c-parport.c:106: warning: implicit declaration of function `i2c_unregister_bus'
make[3]: *** [i2c-parport.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.27/drivers/media/video'
TO CONTINUE: comment line 23 on file "drivers/media/video/i2c-parport.c", change .config file to not include support for I2C on parallel port (CONFIG_I2C_PARPORT)

ERROR #12
Change done to avoid ERROR #2 on 6) seems to break build of I2C code.
But i2c-old.c includes (on line 17) "i2c-old.h", that doesn't exist in
the sources of version 2.5.27.
TO CONTINUE: change .config to not include support for I2C (CONFIG_I2C)
WORKAROUND/PATCH: see lkml "2.5.27 build errors - linux/i2c-old.h"

ERROR #13
stradis.c: In function `saa_open':
stradis.c:1949: structure has no member named `busy'
stradis.c: In function `saa_close':
stradis.c:1961: structure has no member named `busy'
stradis.c: At top level:
stradis.c:1974: unknown field `open' specified in initializer
stradis.c:1974: warning: initialization makes integer from pointer
without a cast
stradis.c:1975: unknown field `close' specified in initializer
stradis.c:1975: warning: initialization from incompatible pointer type
stradis.c:1976: unknown field `read' specified in initializer
stradis.c:1977: unknown field `write' specified in initializer
stradis.c:1977: warning: initialization makes integer from pointer
without a cast
stradis.c:1978: unknown field `ioctl' specified in initializer
stradis.c:1978: warning: missing braces around initializer
stradis.c:1978: warning: (near initialization for `saa_template.lock')
stradis.c:1978: warning: initialization makes integer from pointer
without a cast
stradis.c:1979: unknown field `mmap' specified in initializer
stradis.c:1979: warning: initialization makes integer from pointer
without a cast
stradis.c:245: warning: `detach_inform' defined but not used
make[3]: *** [stradis.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.27/drivers/media/video'
TO CONTINUE: change .config to not include support for Stradis 4:2:2 MPEG-2 video driver (CONFIG_VIDEO_STRADIS)

ERROR #14
ftl.c: In function `ftl_reread_partitions':
ftl.c:1175: `whole' undeclared (first use in this function)
ftl.c:1175: (Each undeclared identifier is reported only once
ftl.c:1175: for each function it appears in.)
ftl.c:1171: label `leave' used but not defined
ftl.c: In function `do_ftl_request':
ftl.c:1203: switch quantity not an integer
ftl.c:1205: warning: unreachable code at beginning of switch statement
ftl.c: In function `ftl_notify_add':
ftl.c:1294: incompatible type for argument 1 of `ftl_reread_partitions'
ftl.c: In function `init_ftl':
ftl.c:1352: too few arguments to function `blk_init_queue'
make[2]: *** [ftl.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/mtd'
TO CONTINUE: change .config to not include support for FTL (Flash Translation Layer) support (CONFIG_FTL)

ERROR #15
iph5526.c: In function `add_to_sest':
iph5526.c:4284: structure has no member named `address'
iph5526.c:4384: structure has no member named `address'
iph5526.c:4393: structure has no member named `address'
iph5526.c:4399: structure has no member named `address'
iph5526.c: At top level:
iph5526.c:227: warning: `driver_template' defined but not used
make[3]: *** [iph5526.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.27/drivers/net/fc'
TO CONTINUE: change .config to not include support for Interphase 5526 Tachyon chipset based adapter (CONFIG_IPHASE5526)

ERROR #16
In file included from aironet4500_cs.c:57:
../aironet4500.h:1502: field `immediate_bh' has incomplete type
make[3]: *** [aironet4500_cs.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.27/drivers/net/pcmcia'
TO CONTINUE: change .config to not include support for Aironet 4500/4800 PCMCIA (CONFIG_AIRONET4500_CS)
WORKAROUND/PATCH: see lkml "Subject: PATCH: 2.5.27 missing config constraint on AIRO_CS"

ERROR #17
rrunner.c:24: #error Please convert me to Documentation/DMA-mapping.txt
TO CONTINUE: change .config to not include support for Essential RoadRunner HIPPI PCI adapter (CONFIG_ROADRUNNER)

ERROR #18
rcpci45.c:47: #error Please convert me to Documentation/DMA-mapping.txt
TO CONTINUE: change .config to not include support for Red Creek Hardware VPN (CONFIG_RCPCI)

ERROR #19
tlan.c:169: #error Please convert me to Documentation/DMA-mapping.txt
TO CONTINUE: change .config to not include support for TI ThunderLAN (CONFIG_TLAN)
WORKAROUND/PATCH: see lkml "Subject: PATCH: 2.5.27 port thunderlan to the new DMA API"

ERROR #20
In file included from aironet4500_core.c:39:
aironet4500.h:1502: field `immediate_bh' has incomplete type
aironet4500_core.c: In function `awc_interrupt_process':
aironet4500_core.c:2375: warning: implicit declaration of function `queue_task'
aironet4500_core.c:2375: `tq_immediate' undeclared (first use in this function)
aironet4500_core.c:2375: (Each undeclared identifier is reported only once
aironet4500_core.c:2375: for each function it appears in.)
make[2]: *** [aironet4500_core.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/net'
TO CONTINUE: change .config file to not include support for Aironet 4500/4800 series adapters (CONFIG_AIRONET4500)
WORKAROUND/PATCH: see lkml "Subject: PATCH: 2.5.27 Make the aironet build again"

ERROR #21
defxx.c:202: #error Please convert me to Documentation/DMA-mapping.txt
TO CONTINUE: change .config to not include support for Digital DEFEA and DEFPA adapter (CONFIG_DEFXX)

ERROR #22
irda/built-in.o: In function `smc_init':
irda/built-in.o(.text.init+0x1770): multiple definition of `smc_init'
smc9194.o(.text.init+0x0): first defined here
ld: Warning: size of symbol `smc_init' changed from 99 to 6 in irda/built-in.o
make[2]: *** [built-in.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/net'
TO CONTINUE: change .config to not include support for SMC 9194 Ethernet (CONFIG_SMC9194)

ERROR #23
cpqfcTSinit.c: In function `cpqfcTS_ioctl':
cpqfcTSinit.c:604: request for member `waiting' in something not a structure or union
cpqfcTSinit.c:614: request for member `waiting' in something not a structure or union
cpqfcTSinit.c: In function `cpqfcTS_TargetDeviceReset':
cpqfcTSinit.c:1546: request for member `waiting' in something not a structure or union
cpqfcTSinit.c:1549: request for member `waiting' in something not a structure or union
make[2]: *** [cpqfcTSinit.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for Compaq Fibre Channel 64-bit/66Mhz HBA (CONFIG_SCSI_CPQFCTS)

ERROR #24
ini9100u.c:111: #error Please convert me to Documentation/DMA-mapping.txt
TO CONTINUE: change .config to not include support for Initio 9100U(W) SCSI controller (CONFIG_SCSI_INITIO)

ERROR #25
pci2000.c: In function `Irq_Handler':
pci2000.c:392: warning: passing arg 1 of `_raw_spin_unlock' from incompatible pointer type
pci2000.c: In function `Pci2000_QueueCommand':
pci2000.c:508: structure has no member named `address'
pci2000.c:531: structure has no member named `address'
make[2]: *** [pci2000.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for PCI2000 SCSI controller (CONFIG_SCSI_PCI2000)

ERROR #26
pci2220i.c:37: #error Convert me to understand page+offset based scatterlists
TO CONTINUE: change .config to not include support for PCI2220i SCSI controller (CONFIG_SCSI_PCI2220I)

ERROR #27
BusLogic.c:32: #error Please convert me to Documentation/DMA-mapping.txt
TO CONTINUE: change .config to not include support for BusLogic SCSI controller (CONFIG_SCSI_BUSLOGIC)

ERROR #28
dpt_i2o.c:31: #error Please convert me to Documentation/DMA-mapping.txt
TO CONTINUE: change .config to not include support for Adaptec I2O RAID
SCSI controller (CONFIG_SCSI_DPT_I2O)

ERROR #29
aha1740.c: In function `aha1740_queuecommand':
aha1740.c:400: structure has no member named `address'
make[2]: *** [aha1740.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for Adaptec AHA1740 SCSI controller (CONFIG_SCSI_AHA1740)

ERROR #30
fd_mcs.c: In function `fd_mcs_intr':
fd_mcs.c:1045: structure has no member named `address'
fd_mcs.c:1079: structure has no member named `address'
fd_mcs.c: In function `fd_mcs_queue':
fd_mcs.c:1197: structure has no member named `address'
fd_mcs.c: In function `fd_mcs_biosparam':
fd_mcs.c:1397: invalid operands to binary &
make[2]: *** [fd_mcs.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for Future Domain MCS-600/700 SCSI controller (CONFIG_SCSI_FD_MCS)

ERROR #31
fdomain.c: In function `do_fdomain_16x0_intr':
fdomain.c:1568: structure has no member named `address'
fdomain.c:1601: structure has no member named `address'
fdomain.c: In function `fdomain_16x0_queue':
fdomain.c:1687: structure has no member named `address'
fdomain.c: In function `fdomain_16x0_release':
fdomain.c:2046: warning: control reaches end of non-void function
make[2]: *** [fdomain.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for Future Domain 16xx SCSI/AHA-2920A controller (CONFIG_SCSI_FUTURE_DOMAIN)

ERROR #31
in2000.c: In function `in2000_queuecommand':
in2000.c:358: structure has no member named `address'
in2000.c: In function `transfer_bytes':
in2000.c:765: structure has no member named `address'
make[2]: *** [in2000.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for Always IN2000 SCSI controller (CONFIG_SCSI_IN2000)

ERROR #32
In file included from g_NCR5380.c:711:
NCR5380.c: In function `initialize_SCp':
NCR5380.c:340: structure has no member named `address'
In file included from g_NCR5380.c:711:
NCR5380.c: In function `NCR5380_timer_fn':
NCR5380.c:619: `io_request_lock' undeclared (first use in this function)
NCR5380.c:619: (Each undeclared identifier is reported only once
NCR5380.c:619: for each function it appears in.)
NCR5380.c: In function `notyet_generic_proc_info':
NCR5380.c:874: `io_request_lock' undeclared (first use in this function)
NCR5380.c: In function `do_generic_NCR5380_intr':
NCR5380.c:1386: `io_request_lock' undeclared (first use in this function)
NCR5380.c: In function `NCR5380_information_transfer':
NCR5380.c:2311: structure has no member named `address'
g_NCR5380.c: At top level:
NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
NCR5380.c:402: warning: `NCR5380_print' defined but not used
make[2]: *** [g_NCR5380.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for Generic NCR5380/53c400 SCSI controller (CONFIG_SCSI_GENERIC_NCR5380)

ERROR #33
NCR53c406a.c: In function `NCR53c406a_intr':
NCR53c406a.c:899: structure has no member named `address'
NCR53c406a.c:928: structure has no member named `address'
make[2]: *** [NCR53c406a.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for NCR53c406a SCSI controller (CONFIG_SCSI_NCR53C406A)

ERROR #34
sym53c416.c: In function `sym53c416_intr_handle':
sym53c416.c:452: structure has no member named `address'
sym53c416.c:478: structure has no member named `address'
make[2]: *** [sym53c416.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for Symbios 53c416 SCSI controller (CONFIG_SCSI_SYM53C416)

ERROR #35
In file included from pas16.c:598:
NCR5380.c: In function `initialize_SCp':
NCR5380.c:340: structure has no member named `address'
In file included from pas16.c:598:
NCR5380.c: In function `NCR5380_timer_fn':
NCR5380.c:619: `io_request_lock' undeclared (first use in this function)
NCR5380.c:619: (Each undeclared identifier is reported only once
NCR5380.c:619: for each function it appears in.)
NCR5380.c: In function `pas16_proc_info':
NCR5380.c:874: `io_request_lock' undeclared (first use in this function)
NCR5380.c: In function `do_pas16_intr':
NCR5380.c:1386: `io_request_lock' undeclared (first use in this function)
NCR5380.c: In function `NCR5380_transfer_dma':
NCR5380.c:2021: `io_request_lock' undeclared (first use in this function)
NCR5380.c: In function `NCR5380_information_transfer':
NCR5380.c:2311: structure has no member named `address'
pas16.c: At top level:
NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
NCR5380.c:402: warning: `NCR5380_print' defined but not used
make[2]: *** [pas16.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for PAS16 SCSI controller (CONFIG_SCSI_PAS16)

ERROR #36
seagate.c: In function `internal_command':
seagate.c:1072: structure has no member named `address'
seagate.c:1339: structure has no member named `address'
seagate.c:1523: structure has no member named `address'
make[2]: *** [seagate.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for Seagate ST-02 and Future Domain TMC-8xx SCSI controller (CONFIG_SCSI_SEAGATE)

ERROR #37
In file included from t128.c:399:
NCR5380.c: In function `initialize_SCp':
NCR5380.c:340: structure has no member named `address'
In file included from t128.c:399:
NCR5380.c: In function `NCR5380_timer_fn':
NCR5380.c:619: `io_request_lock' undeclared (first use in this function)
NCR5380.c:619: (Each undeclared identifier is reported only once
NCR5380.c:619: for each function it appears in.)
NCR5380.c: In function `t128_proc_info':
NCR5380.c:874: `io_request_lock' undeclared (first use in this function)
NCR5380.c: In function `do_t128_intr':
NCR5380.c:1386: `io_request_lock' undeclared (first use in this function)
NCR5380.c: In function `NCR5380_information_transfer':
NCR5380.c:2311: structure has no member named `address'
t128.c: At top level:
NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
NCR5380.c:402: warning: `NCR5380_print' defined but not used
make[2]: *** [t128.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for Trantor T128/T128F/T228 SCSI controller (CONFIG_SCSI_T128)

ERROR #38
In file included from dmx3191d.c:52:
NCR5380.c: In function `initialize_SCp':
NCR5380.c:340: structure has no member named `address'
In file included from dmx3191d.c:52:
NCR5380.c: In function `NCR5380_timer_fn':
NCR5380.c:619: `io_request_lock' undeclared (first use in this function)
NCR5380.c:619: (Each undeclared identifier is reported only once
NCR5380.c:619: for each function it appears in.)
NCR5380.c: In function `dmx3191d_proc_info':
NCR5380.c:874: `io_request_lock' undeclared (first use in this function)
NCR5380.c: In function `dmx3191d_do_intr':
NCR5380.c:1386: `io_request_lock' undeclared (first use in this function)
NCR5380.c: In function `NCR5380_information_transfer':
NCR5380.c:2311: structure has no member named `address'
dmx3191d.c: At top level:
NCR5380.c:738: warning: `NCR5380_print_options' defined but not used
NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
NCR5380.c:402: warning: `NCR5380_print' defined but not used
NCR5380.c:684: warning: `NCR5380_probe_irq' defined but not used
make[2]: *** [dmx3191d.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for DMX3191D SCSI controller (CONFIG_SCSI_DMX3191D)

ERROR #39
In file included from dtc.c:438:
NCR5380.c: In function `initialize_SCp':
NCR5380.c:340: structure has no member named `address'
In file included from dtc.c:438:
NCR5380.c: In function `NCR5380_timer_fn':
NCR5380.c:619: `io_request_lock' undeclared (first use in this function)
NCR5380.c:619: (Each undeclared identifier is reported only once
NCR5380.c:619: for each function it appears in.)
NCR5380.c: In function `dtc_proc_info':
NCR5380.c:874: `io_request_lock' undeclared (first use in this function)
NCR5380.c: In function `NCR5380_transfer_dma':
NCR5380.c:2021: `io_request_lock' undeclared (first use in this function)
NCR5380.c: In function `NCR5380_information_transfer':
NCR5380.c:2311: structure has no member named `address'
dtc.c: At top level:
NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
NCR5380.c:402: warning: `NCR5380_print' defined but not used
make[2]: *** [dtc.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for DTC3180/3280 SCSI controller (CONFIG_SCSI_DTC3280)

ERROR #40
53c7,8xx.c:65: #error Please convert me to Documentation/DMA-mapping.txt
53c7,8xx.c: In function `create_cmd':
53c7,8xx.c:3791: structure has no member named `address'
53c7,8xx.c: In function `insn_to_offset':
53c7,8xx.c:5758: structure has no member named `address'
53c7,8xx.c:5759: structure has no member named `address'
53c7,8xx.c:5767: structure has no member named `address'
make[2]: *** [53c7,8xx.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for NCR53c7,8xx SCSI controller (CONFIG_SCSI_NCR53C7xx)

ERROR #41
eata_dma.c:66: #error Please convert me to Documentation/DMA-mapping.txt
eata_dma.c: In function `eata_queue':
eata_dma.c:577: structure has no member named `address'
eata_dma.c:577: structure has no member named `address'
eata_dma.c:577: structure has no member named `address'
make[2]: *** [eata_dma.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for EATA-DMA [Obsolete] (DPT, NEC, AT&T, SNI, AST, Olivetti, Alphatronix) SCSI controllers (CONFIG_SCSI_EATA_DMA)

ERROR #42
eata_pio.c: In function `IncStat':
eata_pio.c:102: structure has no member named `address'
eata_pio.c: In function `eata_pio_queue':
eata_pio.c:375: structure has no member named `address'
make[2]: *** [eata_pio.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for EATA-PIO (old DPT PM2001, PM2012A) SCSI controller (CONFIG_SCSI_EATA_PIO)

ERROR #43
ibmmca.c: In function `interrupt_handler':
ibmmca.c:508: warning: dereferencing `void *' pointer
ibmmca.c:508: request for member `host_lock' in something not a structure or union
ibmmca.c:515: warning: dereferencing `void *' pointer
ibmmca.c:515: request for member `host_lock' in something not a structure or union
ibmmca.c:524: warning: dereferencing `void *' pointer
ibmmca.c:524: request for member `host_lock' in something not a structure or union
ibmmca.c:531: warning: dereferencing `void *' pointer
ibmmca.c:531: request for member `host_lock' in something not a structure or union
ibmmca.c:532: warning: dereferencing `void *' pointer
ibmmca.c:532: request for member `host_lock' in something not a structure or union
ibmmca.c:542: warning: dereferencing `void *' pointer
ibmmca.c:542: request for member `host_lock' in something not a structure or union
ibmmca.c: In function `internal_ibmmca_scsi_setup':
ibmmca.c:1409: warning: implicit declaration of function `strtok'
ibmmca.c:1409: warning: assignment makes pointer from integer without a cast
ibmmca.c:1427: warning: assignment makes pointer from integer without a cast
ibmmca.c: In function `ibmmca_getinfo':
ibmmca.c:1445: warning: dereferencing `void *' pointer
ibmmca.c:1445: request for member `host_lock' in something not a structure or union
make[2]: *** [ibmmca.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for IBMMCA SCSI controller (CONFIG_SCSI_IBMMCA)

ERROR #44
In file included from tmscsim.c:1823:
scsiiom.c:9: #error Please convert me to Documentation/DMA-mapping.txt
tmscsim.c:2530: badly punctuated parameter list in `#define'
tmscsim.c: In function `DC390_waiting_timed_out':
tmscsim.c:1074: request for member `pScsiHost' in something not a structure or union
tmscsim.c:1078: request for member `pScsiHost' in something not a structure or union
tmscsim.c: In function `dc390_BuildSRB':
tmscsim.c:1146: structure has no member named `address'
In file included from tmscsim.c:1823:
scsiiom.c: In function `DC390_Interrupt':
scsiiom.c:267: `DC390_LOCK_IO' undeclared (first use in this function)
scsiiom.c:267: (Each undeclared identifier is reported only once
scsiiom.c:267: for each function it appears in.)
scsiiom.c:343: `DC390_UNLOCK_IO' undeclared (first use in this function)
scsiiom.c:229: warning: unused variable `iflags'
scsiiom.c: In function `dc390_DataOut_0':
scsiiom.c:384: structure has no member named `address'
scsiiom.c: In function `dc390_DataIn_0':
scsiiom.c:448: structure has no member named `address'
scsiiom.c: In function `dc390_restore_ptr':
scsiiom.c:747: structure has no member named `address'
scsiiom.c:761: structure has no member named `address'
scsiiom.c:764: structure has no member named `address'
scsiiom.c: In function `dc390_DataIO_Comm':
scsiiom.c:898: structure has no member named `address'
scsiiom.c: In function `dc390_SRBdone':
scsiiom.c:1373: structure has no member named `address'
scsiiom.c:1448: structure has no member named `address'
scsiiom.c:1523: structure has no member named `address'
scsiiom.c: In function `dc390_RequestSense':
scsiiom.c:1764: structure has no member named `address'
tmscsim.c: In function `dc390_inquiry':
tmscsim.c:2401: request for member `rq_status' in something not a structure or union
tmscsim.c: In function `dc390_sendstart':
tmscsim.c:2451: request for member `rq_status' in something not a structure or union
tmscsim.c: In function `dc390_set_info':
tmscsim.c:2558: request for member `pScsiHost' in something not a structure or union
tmscsim.c:2607: `p' undeclared (first use in this function)
tmscsim.c:2633: warning: passing arg 1 of `strsep' makes pointer from integer without a cast
tmscsim.c:2635: warning: passing arg 1 of `strsep' makes pointer from integer without a cast
tmscsim.c:2653: warning: passing arg 1 of `strsep' makes pointer from integer without a cast
tmscsim.c:2656: warning: passing arg 1 of `strsep' makes pointer from integer without a cast
tmscsim.c:2659: warning: passing arg 1 of `strsep' makes pointer from integer without a cast
tmscsim.c:2671: warning: passing arg 1 of `strsep' makes pointer from integer without a cast
tmscsim.c:2684: warning: passing arg 1 of `strsep' makes pointer from integer without a cast
tmscsim.c:2698: warning: implicit declaration of function `SEARCH3'
tmscsim.c:2722: request for member `pScsiHost' in something not a structure or union
tmscsim.c:2729: request for member `pScsiHost' in something not a structure or union
tmscsim.c:2739: request for member `pScsiHost' in something not a structure or union
tmscsim.c:2747: request for member `pScsiHost' in something not a structure or union
tmscsim.c:2753: warning: passing arg 1 of `strsep' makes pointer from integer without a cast
tmscsim.c:2761: request for member `pScsiHost' in something not a structure or union
tmscsim.c:2767: warning: passing arg 1 of `strsep' makes pointer from integer without a cast
tmscsim.c:2776: request for member `pScsiHost' in something not a structure or union
tmscsim.c:2783: warning: passing arg 1 of `strsep' makes pointer from integer without a cast
tmscsim.c:2791: request for member `pScsiHost' in something not a structure or union
tmscsim.c:2798: warning: passing arg 1 of `strsep' makes pointer from integer without a cast
tmscsim.c:2807: request for member `pScsiHost' in something not a structure or union
tmscsim.c:2815: request for member `pScsiHost' in something not a structure or union
make[2]: *** [tmscsim.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for Tekram DC390(T) and Am53/79C974 SCSI (CONFIG_SCSI_DC390T)

ERROR #45
AM53C974.c:1: #error Please convert me to Documentation/DMA-mapping.txt
AM53C974.c: In function `initialize_SCp':
AM53C974.c:846: structure has no member named `address'
AM53C974.c: In function `AM53C974_information_transfer':
AM53C974.c:1560: structure has no member named `address'
make[2]: *** [AM53C974.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for AM53/79C974 PCI SCSI controller (CONFIG_SCSI_AM53C974)

ERROR #46
atp870u.c:17: #error Please convert me to Documentation/DMA-mapping.txt
atp870u.c: In function `send_s870':
atp870u.c:808: structure has no member named `address'
make[2]: *** [atp870u.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for ACARD SCSI controller (CONFIG_SCSI_ACARD)
WORKAROUND/PATCH: see lkml "Subject: PATCH: 2.5.27 - Fix up the atp870u scsi driver"

ERROR #46
gdth.c:298: #error Please convert me to Documentation/DMA-mapping.txt
In file included from gdth.c:704:
gdth_proc.c:1393: macro `GDTH_LOCK_SCSI_DONE' used with just one arg
gdth.c:3346: macro `GDTH_UNLOCK_SCSI_DONE' used with too many (2) args
In file included from gdth.c:704:
gdth_proc.c: In function `gdth_do_cmd':
gdth_proc.c:1269: request for member `rq_status' in something not a structure or union
gdth_proc.c:1271: request for member `waiting' in something not a structure or union
gdth_proc.c: In function `gdth_scsi_done':
gdth_proc.c:1291: request for member `rq_status' in something not a structure or union
gdth_proc.c:1294: request for member `waiting' in something not a structure or union
gdth_proc.c:1295: request for member `waiting' in something not a structure or union
gdth_proc.c: In function `gdth_wait_completion':
gdth_proc.c:1393: parse error before `)'
gdth_proc.c:1393: invalid type argument of `->'
gdth_proc.c:1395: `dev' undeclared (first use in this function)
gdth_proc.c:1395: (Each undeclared identifier is reported only once
gdth_proc.c:1395: for each function it appears in.)
gdth.c: In function `gdth_copy_internal_data':
gdth.c:2633: structure has no member named `address'
gdth.c:2633: structure has no member named `address'
gdth.c: In function `gdth_fill_cache_cmd':
gdth.c:2808: structure has no member named `address'
gdth.c: In function `gdth_fill_raw_cmd':
gdth.c:2925: structure has no member named `address'
gdth.c: In function `gdth_interrupt':
gdth.c:3346: `dev' undeclared (first use in this function)
make[2]: *** [gdth.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi'
TO CONTINUE: change .config to not include support for Intel/ICP (former GDT SCSI Disk Array) RAID Controller (CONFIG_SCSI_GDTH)

ERROR #47
ixj.c: In function `ixj_release':
ixj.c:2277: invalid operands to binary &
ixj.c:2464: warning: passing arg 2 of `clear_bit' from incompatible pointer type
ixj.c: In function `ixj_read':
ixj.c:2857: invalid operands to binary &
ixj.c: In function `ixj_enhanced_read':
ixj.c:2914: invalid operands to binary &
ixj.c: In function `ixj_enhanced_write':
ixj.c:2993: invalid operands to binary &
ixj.c: In function `ixj_write_cidcw':
ixj.c:3399: warning: passing arg 2 of `clear_bit' from incompatible pointer type
ixj.c:3426: warning: passing arg 2 of `clear_bit' from incompatible pointer type
ixj.c:3441: warning: passing arg 2 of `clear_bit' from incompatible pointer type
ixj.c: In function `ixj_poll':
ixj.c:4706: invalid operands to binary &
ixj.c: In function `ixj_ioctl':
ixj.c:6205: invalid operands to binary &
ixj.c:6206: invalid operands to binary &
ixj.c:6208: invalid operands to binary &
ixj.c:6223: warning: passing arg 2 of `clear_bit' from incompatible pointer type
ixj.c:6750: warning: passing arg 2 of `clear_bit' from incompatible pointer type
ixj.c: In function `ixj_fasync':
ixj.c:6756: invalid operands to binary &
make[2]: *** [ixj.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/telephony'
TO CONTINUE: change .config to not include support for QuickNet Internet LineJack/PhoneJack (CONFIG_PHONE_IXJ)

ERROR #48
pm2fb.c: In function `reset_units':
pm2fb.c:988: `PM2R_RASTERIZER_MODE' undeclared (first use in this function)
pm2fb.c:988: (Each undeclared identifier is reported only once
pm2fb.c:988: for each function it appears in.)
pm2fb.c:989: `PM2R_DELTA_MODE' undeclared (first use in this function)
pm2fb.c:989: `PM2F_DELTA_ORDER_RGB' undeclared (first use in this function)
pm2fb.c: In function `pm2fb_set_disp':
pm2fb.c:1975: structure has no member named `screen_base'
pm2fb.c: In function `pm2fb_init':
pm2fb.c:2284: warning: implicit declaration of function `fbgen_install_cmap'
make[2]: *** [pm2fb.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/video'
TO CONTINUE: change .config to not include support for Permedia2 framebuffer (CONFIG_FB_PM2)

ERROR #49
aty128fb.c: In function `aty128_init':
aty128fb.c:1775: `con' undeclared (first use in this function)
aty128fb.c:1775: (Each undeclared identifier is reported only once
aty128fb.c:1775: for each function it appears in.)
aty128fb.c:1776: incompatible type for argument 1 of `fb_alloc_cmap'
aty128fb.c:1662: warning: `size' might be used uninitialized in this function
make[2]: *** [aty128fb.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/video'
TO CONTINUE: change .config to not include support for ATI Rage128 display support (CONFIG_FB_ATY128)

ERROR #50
vfb.c:27: linux/fbcon.h: No such file or directory
vfb.c: In function `vfb_init':
vfb.c:449: `vesafb_fix' undeclared (first use in this function)
vfb.c:449: (Each undeclared identifier is reported only once
vfb.c:449: for each function it appears in.)
vfb.c: At top level:
vfb.c:45: storage size of `disp' isn't known
make[2]: *** [vfb.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.27/drivers/video'
TO CONTINUE: change .config to not include support for Virtual Frame Buffer (CONFIG_FB_VIRTUAL)

ERROR #51
   ld -m elf_i386  -r -o built-in.o pci/built-in.o acpi/built-in.o parport/built-in.o base/built-in.o char/built-in.o block/built-in.o misc/built-in.o net/built-in.o media/built-in.o atm/built-in.o ide/built-in.o scsi/built-in.o message/built-in.o ieee1394/built-in.o cdrom/built-in.o mtd/built-in.o pcmcia/built-in.o pnp/built-in.o video/built-in.o block/paride/built-in.o usb/built-in.o input/built-in.o input/gameport/built-in.o input/serio/built-in.o telephony/built-in.o md/built-in.o bluetooth/built-in.o isdn/built-in.o
ld: cannot open ieee1394/built-in.o: No such file or directory
make[1]: *** [built-in.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.27/drivers'
TO CONTINUE: change .config to not include support for IEEE 1394 (FireWire) at all (CONFIG_IEEE1394_OHCI1394)

ERROR #52
ad1848_lib.c:1171: parse error before `alsa_ad1848_init'
ad1848_lib.c:1172: warning: return-type defaults to `int'
ad1848_lib.c:1176: parse error before `alsa_ad1848_exit'
ad1848_lib.c:1177: warning: return-type defaults to `int'
ad1848_lib.c: In function `alsa_ad1848_exit':
ad1848_lib.c:1178: warning: control reaches end of non-void function
ad1848_lib.c: At top level:
ad1848_lib.c:1181: parse error before `module_exit'
ad1848_lib.c:1182: parse error at end of input
make[3]: *** [ad1848_lib.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.27/sound/isa/ad1848'
TO CONTINUE: implement WORKAROUND/PATCH
WORKAROUND/PATCH: see lkml "Subject: PATCH: 2.5.27 Fix dump non compile in ad1848 audio"

ERROR #53
netsyms.c:449: `tr_source_route' undeclared here (not in a function)
netsyms.c:449: initializer element is not constant
netsyms.c:449: (near initialization for `__ksymtab_tr_source_route.value')
make[1]: *** [netsyms.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.27/net'
TO CONTINUE: change .config to not include support for Token Ring driver (CONFIG_TR)

ERROR #54
drivers/built-in.o: In function `fore200e_detect':
/usr/src/linux-2.5.27/drivers/atm/fore200e.c(.text+0x1dad69): undefined reference to `__udivdi3'
/usr/src/linux-2.5.27/drivers/atm/fore200e.c(.text+0x1dba13): undefined reference to `__udivdi3'
/usr/src/linux-2.5.27/drivers/atm/fore200e.c(.text+0x1dcb19): undefined reference to `__udivdi3'
/usr/src/linux-2.5.27/drivers/atm/fore200e.c(.text+0x1de66d): undefined reference to `__udivdi3'
/usr/src/linux-2.5.27/drivers/atm/fore200e.c(.text+0x1e08eb): undefined reference to `__udivdi3'
drivers/built-in.o: In function `firestream_cleanup_module':
/usr/src/linux-2.5.27/drivers/atm/firestream.c(.data+0x30f14): undefined reference to `local symbols in discarded section .text.exit'
/usr/src/linux-2.5.27/drivers/atm/firestream.c(.data+0x31274): undefined reference to `local symbols in discarded section .text.exit'
sound/sound.o: In function `alsa_hammerfall_mem_init':
sound/sound.o(.text.init+0x2ca97): undefined reference to `local symbols in discarded section .text.exit'
net/network.o: In function `sock_init':
net/network.o(.text.init+0x6a): undefined reference to `bluez_init'
make: *** [vmlinux] Error 1
TO CONTINUE: change .config to not include support for FORE Systems 200E-series (CONFIG_ATM_FORE200E_MAYBE). Same problem happens with _all_ ATM drivers, so ATM support is disabled, Asynchronous Transfer Mode (ATM) (CONFIG_ATM). The second part of the error seems to be the well known and longstanding linker problem. Commented out DISCARD section of file "arch/i386/vmlinux.lds".

ERROR #55
  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o security/built-in.o /usr/src/linux-2.5.27/arch/i386/lib/lib.a lib/lib.a /usr/src/linux-2.5.27/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o arch/i386/math-emu/math.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
drivers/built-in.o: In function `SkPnmiInit':
drivers/built-in.o(.text+0x1dad69): undefined reference to `__udivdi3'
drivers/built-in.o: In function `SkPnmiEvent':
drivers/built-in.o(.text+0x1dba13): undefined reference to `__udivdi3'
drivers/built-in.o: In function `SensorStat':
drivers/built-in.o(.text+0x1dcb19): undefined reference to `__udivdi3'
drivers/built-in.o: In function `General':
drivers/built-in.o(.text+0x1de66d): undefined reference to `__udivdi3'
drivers/built-in.o: In function `GetTrapEntry':
drivers/built-in.o(.text+0x1e08eb): undefined reference to `__udivdi3'
drivers/built-in.o: In function `acpi_bus_exit':
drivers/built-in.o(.text.exit+0x5c): undefined reference to `acpi_pci_link_exit'
drivers/built-in.o: In function `videodev_exit':
drivers/built-in.o(.text.exit+0x3eb1): undefined reference to `videodev_proc_destroy'
drivers/built-in.o: In function `pcbit_exit':
drivers/built-in.o(.text.exit+0x6e92): undefined reference to `pcbit_terminate'
net/network.o: In function `sock_init':
net/network.o(.text.init+0x6a): undefined reference to `bluez_init'
make: *** [vmlinux] Error 1
TO CONTINUE: too much work for today :-(


8) Run "make modules". FAIL

ERROR #1
../fdomain.c: In function `do_fdomain_16x0_intr':
../fdomain.c:1568: structure has no member named `address'
../fdomain.c:1601: structure has no member named `address'
../fdomain.c: In function `fdomain_16x0_queue':
../fdomain.c:1687: structure has no member named `address'
../fdomain.c: In function `fdomain_16x0_release':
../fdomain.c:2046: warning: control reaches end of non-void function
make[3]: *** [fdomain.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi/pcmcia'
TO CONTINUE: change .config to not include support for Future Domain PCMCIA SCSI controller (CONFIG_PCMCIA_FDOMAIN)

ERROR #2
nsp_cs.c: In function `nsp_queuecommand':
nsp_cs.c:203: structure has no member named `address'
nsp_cs.c: In function `nsp_pio_read':
nsp_cs.c:715: structure has no member named `address'
nsp_cs.c: In function `nsp_pio_write':
nsp_cs.c:788: structure has no member named `address'
make[3]: *** [nsp_cs.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.27/drivers/scsi/pcmcia'
TO CONTINUE: change .config to not include support for NinjaSCSI-3 / NinjaSCSI-32Bi (16bit) PCMCIA SCSI controller (CONFIG_PCMCIA_NINJA_SCSI)


9) Run "make modules_install". SUCCESS


-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Woody (Linux 2.4.19-pre6aa1)
