Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268470AbTCFWd3>; Thu, 6 Mar 2003 17:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268471AbTCFWd3>; Thu, 6 Mar 2003 17:33:29 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:15369 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268470AbTCFWdS>;
	Thu, 6 Mar 2003 17:33:18 -0500
Date: Thu, 6 Mar 2003 14:34:03 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.4.21-pre5
Message-ID: <20030306223402.GF12032@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB updates and bugfixes for 2.4.21-pre5.  These are all
changes that have been in 2.5 for a while.  The patches are so large
because a new firmware image was added for the Keyspan devices, and the
USB host controllers moved into their own subdirectory to be more like
the 2.5 tree.

Please pull from:  bk://linuxusb.bkbits.net/marcelo-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h

 drivers/usb/hcd/Config.in                |    7 
 drivers/usb/hcd/Makefile                 |   27 
 drivers/usb/hcd/ehci-dbg.c               |  650 ------
 drivers/usb/hcd/ehci-hcd.c               | 1033 ----------
 drivers/usb/hcd/ehci-hub.c               |  344 ---
 drivers/usb/hcd/ehci-mem.c               |  251 --
 drivers/usb/hcd/ehci-q.c                 | 1090 ----------
 drivers/usb/hcd/ehci-sched.c             | 1123 ----------
 drivers/usb/hcd/ehci.h                   |  452 ----
 drivers/usb/uhci-debug.h                 |  573 -----
 drivers/usb/uhci.c                       | 3172 -------------------------------
 drivers/usb/uhci.h                       |  441 ----
 drivers/usb/usb-ohci.c                   | 2938 ----------------------------
 drivers/usb/usb-ohci.h                   |  643 ------
 drivers/usb/usb-uhci-debug.h             |  195 -
 drivers/usb/usb-uhci.c                   | 3143 ------------------------------
 drivers/usb/usb-uhci.h                   |  308 ---
 drivers/usb/Config.in                    |   13 
 drivers/usb/Makefile                     |   15 
 drivers/usb/auermain.c                   |    4 
 drivers/usb/hcd.c                        |   11 
 drivers/usb/hcd.h                        |    1 
 drivers/usb/hid-core.c                   |    8 
 drivers/usb/host/Config.in               |   19 
 drivers/usb/host/Makefile                |   32 
 drivers/usb/host/ehci-dbg.c              |  656 ++++++
 drivers/usb/host/ehci-hcd.c              | 1058 ++++++++++
 drivers/usb/host/ehci-hub.c              |  344 +++
 drivers/usb/host/ehci-mem.c              |  251 ++
 drivers/usb/host/ehci-q.c                | 1121 ++++++++++
 drivers/usb/host/ehci-sched.c            | 1123 ++++++++++
 drivers/usb/host/ehci.h                  |  455 ++++
 drivers/usb/host/uhci-debug.h            |  573 +++++
 drivers/usb/host/uhci.c                  | 3172 +++++++++++++++++++++++++++++++
 drivers/usb/host/uhci.h                  |  441 ++++
 drivers/usb/host/usb-ohci.c              | 2938 ++++++++++++++++++++++++++++
 drivers/usb/host/usb-ohci.h              |  643 ++++++
 drivers/usb/host/usb-uhci-debug.h        |  195 +
 drivers/usb/host/usb-uhci.c              | 3143 ++++++++++++++++++++++++++++++
 drivers/usb/host/usb-uhci.h              |  308 +++
 drivers/usb/hpusbscsi.c                  |   20 
 drivers/usb/hpusbscsi.h                  |    1 
 drivers/usb/kaweth.c                     |    1 
 drivers/usb/kbtab.c                      |  179 +
 drivers/usb/pegasus.h                    |    2 
 drivers/usb/scanner.c                    |   12 
 drivers/usb/scanner.h                    |  147 -
 drivers/usb/serial/Config.in             |    2 
 drivers/usb/serial/io_edgeport.c         |   45 
 drivers/usb/serial/ipaq.c                |    1 
 drivers/usb/serial/ipaq.h                |    3 
 drivers/usb/serial/keyspan.c             |   33 
 drivers/usb/serial/keyspan.h             |   42 
 drivers/usb/serial/keyspan_mpr_fw.h      |  286 ++
 drivers/usb/serial/keyspan_usa49wlc_fw.h |  476 ++++
 drivers/usb/serial/pl2303.c              |    1 
 drivers/usb/serial/pl2303.h              |    3 
 drivers/usb/storage/transport.c          |   13 
 drivers/usb/storage/unusual_devs.h       |    6 
 drivers/usb/usb-midi.h                   |   32 
 drivers/usb/usb.c                        |   24 
 61 files changed, 17712 insertions(+), 16531 deletions(-)
-----

ChangeSet@1.1033, 2003-03-06 13:45:25-08:00, stern@rowland.harvard.edu
  [PATCH] USB: Patch for auto-sense cmd_len
  
  This patch fixes an oversight in usb-storage whereby the command length
  and command buffer for an automatically-generated REQUEST-SENSE command
  would not be initialized properly.

 drivers/usb/storage/transport.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)
------

ChangeSet@1.1032, 2003-03-05 21:39:05-08:00, go@turbolinux.co.jp
  [PATCH] USB: Another hid-core worksround
  
  This is a another hid-core workaround.
  OKI USB keyboard(ID=0007) has keyboard + mouse + pointer.
  And it needs HID_QUIRK_NOGET.

 drivers/usb/hid-core.c |    4 ++++
 1 files changed, 4 insertions(+)
------

ChangeSet@1.1031, 2003-03-05 21:38:48-08:00, go@turbolinux.co.jp
  [PATCH] USB: Multiple interfaces with usb hotplug
  
  Some HID devices have multiple interfaces. e.x.
  Keyboard + Mouse
  Keyboard + Mouse + Pointer.
  Cuurent(2.4.21pre5) code of usb hotplug supports the first interface only.
  
  OKI/Fijitsu use this type of kerbaord.
  IBM Blade Center do USB emulation as PS2. And USB emulation has multiple interfaces.
  
  Below are IBM Blade Center's devices.
  
  T:  Bus=01 Lev=02 Prnt=03 Port=02 Cnt=02 Dev#=  5 Spd=12  MxCh= 0
  D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
  P:  Vendor=04b3 ProdID=4004 Rev= 0.01
  S:  Manufacturer=Cypress
  S:  Product=HID K/M
  C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=  0mA
  I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=hid  <-- 1st
  E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
  I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid  <-- 2nd.
  E:  Ad=82(I) Atr=03(Int.) MxPS=   4 Ivl=10ms
  
  As for blade server, keyboard which has multiple interfaces are often used.
  However, mouse dose not use with hotplug.
  
  This patch activates hotplug in accordance with number of interface.

 drivers/usb/usb.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)
------

ChangeSet@1.1030, 2003-03-05 21:02:50-08:00, go@turbolinux.co.jp
  [PATCH] USB: Another sony memorystick
  
  This is another sony memorystick MSC-U03 for unusual_devs.
  If there is no entry, and when USB hotplug is enabled,
  the system will be stoped for a while.
  Some new SONY laptops has this memorystick by built-in.

 drivers/usb/storage/unusual_devs.h |    6 ++++++
 1 files changed, 6 insertions(+)
------

ChangeSet@1.1029, 2003-03-05 21:02:24-08:00, go@turbolinux.co.jp
  [PATCH] USB: Another kaweth ID
  
  This is another ID for kaweth.c.
  It is accessory of NTT-ME MN128.

 drivers/usb/kaweth.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.1028, 2003-03-05 21:02:07-08:00, go@turbolinux.co.jp
  [PATCH] USB: Another pegasus ID
  
  Laneed LD-USBL/TX is LUN-egg OEM.
  The other LUN-egg(s) are used by IODATA, Corega.
  (Which means they are the same thing)

 drivers/usb/pegasus.h |    2 ++
 1 files changed, 2 insertions(+)
------

ChangeSet@1.1027, 2003-03-05 14:55:14-08:00, greg@kroah.com
  [PATCH] USB: move the OHCI driver into drivers/usb/host

 drivers/usb/usb-ohci.c      | 2938 --------------------------------------------
 drivers/usb/usb-ohci.h      |  643 ---------
 drivers/usb/Config.in       |    2 
 drivers/usb/Makefile        |    4 
 drivers/usb/host/Config.in  |    4 
 drivers/usb/host/Makefile   |    3 
 drivers/usb/host/usb-ohci.c | 2938 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/usb-ohci.h |  643 +++++++++
 8 files changed, 3586 insertions(+), 3589 deletions(-)
------

ChangeSet@1.1026, 2003-03-05 14:49:41-08:00, greg@kroah.com
  [PATCH] USB: move the UHCI drivers into drivers/usb/host

 drivers/usb/uhci-debug.h          |  573 ------
 drivers/usb/uhci.c                | 3172 --------------------------------------
 drivers/usb/uhci.h                |  441 -----
 drivers/usb/usb-uhci-debug.h      |  195 --
 drivers/usb/usb-uhci.c            | 3143 -------------------------------------
 drivers/usb/usb-uhci.h            |  308 ---
 drivers/usb/Config.in             |    8 
 drivers/usb/Makefile              |    4 
 drivers/usb/host/Config.in        |    8 
 drivers/usb/host/Makefile         |    2 
 drivers/usb/host/uhci-debug.h     |  573 ++++++
 drivers/usb/host/uhci.c           | 3172 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/uhci.h           |  441 +++++
 drivers/usb/host/usb-uhci-debug.h |  195 ++
 drivers/usb/host/usb-uhci.c       | 3143 +++++++++++++++++++++++++++++++++++++
 drivers/usb/host/usb-uhci.h       |  308 +++
 16 files changed, 7844 insertions(+), 7842 deletions(-)
------

ChangeSet@1.1025, 2003-03-05 14:36:23-08:00, david-b@pacbell.net
  [PATCH] ehci, sync with 2.5 latest
  
  This patch syncs the 2.4 version with the latest from 2.5 ...
  to make it easier for folk to use this before the "host"
  directory rename, I decided not to depend on that patch yet.
  
  VIA users will see the most benefit from this, as well as
  anyone rebooting with usb-only configurations.
  
    - uses reboot notifier to make sure the companion
      controller can be used during reboot
  
    - keeps statistics for lost IAA IRQs (seems to be an
      issue on at least one VT8235)
  
    - defers using IAA, which makes VT8235 more stable
      (and on 2.4 with usb-storage, 4-5 times faster!)
      and generally reduces IRQs at the cost of some
      extra dma accesses.
  
    - assumes IAA is a bit flakey, re-initting the async
      queue head (which I've seen become invalid) and not
      resetting the qh "next" pointer after IAA says it's
      safe to do so (likely how it became invalid, by a
      memory access race and/or silicon bug).

 drivers/usb/host/ehci-dbg.c |    6 ++++--
 drivers/usb/host/ehci-hcd.c |   25 +++++++++++++++++++++++--
 drivers/usb/host/ehci-q.c   |   31 +++++++++++++++++++++++--------
 drivers/usb/host/ehci.h     |    3 +++
 4 files changed, 53 insertions(+), 12 deletions(-)
------

ChangeSet@1.1024, 2003-03-05 14:33:27-08:00, david-b@pacbell.net
  [PATCH] USB: call hcd->stop() in task context
  
  This is the 2.4 version of a fix that's been in 2.5 for some
  time now:  when an HCD dies a premature death, its cleanup
  needs to be done in a task context.  The most likely case for
  that would be physical cardbus eject without driver shutdown.

 drivers/usb/hcd.c |   11 ++++++++++-
 drivers/usb/hcd.h |    1 +
 2 files changed, 11 insertions(+), 1 deletion(-)
------

ChangeSet@1.1022, 2003-03-05 14:18:18-08:00, bunk@fs.tum.de
  [PATCH] USB: fix Auerswald compile
  
  I got the following error at the final linking:
  
  <--  snip  -->
  
  ...
          --end-group \
          -o vmlinux
  ...
  drivers/usb/usbdrv.o(.text+0x65061): In function `auerchar_open':
  : undefined reference to `auerdev_table_mutex'
  drivers/usb/usbdrv.o(.text+0x6506a): In function `auerchar_open':
  : undefined reference to `auerdev_table_mutex'
  drivers/usb/usbdrv.o(.text+0x65087): In function `auerchar_open':
  : undefined reference to `auerdev_table'
  drivers/usb/usbdrv.o(.text+0x65094): In function `auerchar_open':
  : undefined reference to `auerdev_table_mutex'
  drivers/usb/usbdrv.o(.text+0x650c1): In function `auerchar_open':
  : undefined reference to `auerdev_table_mutex'
  drivers/usb/usbdrv.o(.text+0x650da): In function `auerchar_open':
  : undefined reference to `auerdev_table_mutex'
  make: *** [vmlinux] Error 1
  
  <--  snip  -->
  
  auerdev_table and auerdev_table_mutex are static in auermain.c but used
  from auerchar.c. The following patch makes them non-static:

 drivers/usb/auermain.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.1021, 2003-03-05 14:18:05-08:00, clemens@ladisch.de
  [PATCH] usb-midi.h: fixes for SC-8820/50
  
  Clemens Ladisch wrote:
  > OK, here are further changes for 2.4.
  
  ... and now, hopefully, with correct formatting.
  
  
  sync with Nagano's version:
  - protect vendor ids against multiple definitions
  - sort Roland device ids
  - add SC-8820 table entry for hotplugging
  - add quirk for the MOTU Fastlane

 drivers/usb/usb-midi.h |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)
------

ChangeSet@1.1020, 2003-03-05 14:17:51-08:00, josh@joshisanerd.com
  [PATCH] USB: add KB Gear USB Tablet Driver

 drivers/usb/Config.in  |    1 
 drivers/usb/Makefile   |    1 
 drivers/usb/hid-core.c |    4 +
 drivers/usb/kbtab.c    |  179 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 185 insertions(+)
------

ChangeSet@1.1019, 2003-03-05 14:02:35-08:00, greg@kroah.com
  USB: merge fixup for the scanner driver.

 drivers/usb/scanner.c |    3 +++
 1 files changed, 3 insertions(+)
------

ChangeSet@1.1018, 2003-03-05 13:56:31-08:00, henning@meier-geinitz.de
  [PATCH] USB: New vendor/product ids for scanner driver
  
  This patch adds vendor/product ids for Artec, Avision, Brother,
  Medion, Primax, Prolink, Fujitsu, Plustek, and SYSCAN scanners.

 drivers/usb/scanner.c |    4 ++++
 drivers/usb/scanner.h |   22 ++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)
------

ChangeSet@1.1017, 2003-03-05 13:56:07-08:00, henning@meier-geinitz.de
  [PATCH] USB scanner.h, scanner.c: New vendor/product ids
  
  This patch adds vendor/product ids for Artec, Canon, Compaq, Epson,
  HP, and Microtek scanners. Further more, the device list was cleaned
  up, sorted and duplicated entries have been removed.

 drivers/usb/scanner.c |    5 +-
 drivers/usb/scanner.h |  125 +++++++++++++++++++++++++++-----------------------
 2 files changed, 73 insertions(+), 57 deletions(-)
------

ChangeSet@1.1016, 2003-03-05 13:52:12-08:00, andre.breiler@null-mx.org
  [PATCH] io_edgeport.c diff to fix endianess bugs
  
  Hi Greg,
  
  attached a fix for the io_edgeport usb serial driver (I used the one from
  kernel 2.4.21-pre4 as base).
  This diff fixes endianess issues which prevented the driver to work on
  bigendian machines (e.g. sparc).
  
  Bye Andre'

 drivers/usb/serial/io_edgeport.c |   45 +++++++++++++++++++--------------------
 1 files changed, 23 insertions(+), 22 deletions(-)
------

ChangeSet@1.1015, 2003-03-05 13:51:59-08:00, kernel@jsl.com
  [PATCH] Re: Keyspan USB/Serial Drivers for 2.4.20/2.4.21-pre4
  
   I'm not sure why, but the current kernel source tree doesn't support some
  of the Keyspan USB/Serial adapter products (49WLC and MPR).  There is code
  at: http://www.keyspan.com/support/linux/files/currentversion/rev2003jan31/
  but it only works with 2.4.18 or 2.4.19.  Keyspan seems to think the code
  is current and they didn't want my patches.  Here they are for posterity.

 drivers/usb/serial/Config.in |    2 ++
 drivers/usb/serial/keyspan.c |   33 ++++++++++++++++++++++++++++++++-
 drivers/usb/serial/keyspan.h |   42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 1 deletion(-)
------

ChangeSet@1.1014, 2003-03-05 13:51:45-08:00, greg@kroah.com
  [PATCH] USB: add firmware files for two new keyspan devices.

 drivers/usb/serial/keyspan_mpr_fw.h      |  286 ++++++++++++++++++
 drivers/usb/serial/keyspan_usa49wlc_fw.h |  476 +++++++++++++++++++++++++++++++
 2 files changed, 762 insertions(+)
------

ChangeSet@1.1013, 2003-03-05 13:51:32-08:00, clemens@ladisch.de
  [PATCH] usb-midi.h: fixes for SC-8820/50
  
  The SC-8820 has two synth ports, not one.
  The SC-8850 has two external MIDI ports.
  
  BTW: The original driver at
  <http://member.nifty.ne.jp/Breeze/softwares/unix/usbmidi-e.html> already
  has had these fixes for some time now, and supports more devices.

 drivers/usb/usb-midi.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.1012, 2003-03-05 13:51:18-08:00, ganesh@vxindia.veritas.com
  [PATCH] USB ipaq.c: add ids for fujitsu loox
  
   Added ids for the Fujitsu-Siemens Loox. Thanks to Michael Brausen.

 drivers/usb/serial/ipaq.c |    1 +
 drivers/usb/serial/ipaq.h |    3 +++
 2 files changed, 4 insertions(+)
------

ChangeSet@1.1011, 2003-03-05 13:51:05-08:00, oliver@neukum.name
  [PATCH] USB: work around for a firmware bug of some scanners
  
  this makes Elite II scanners much more useable. It's against 2.4.
     - short command work around

 drivers/usb/hpusbscsi.c |   20 ++++++++++++++++++--
 drivers/usb/hpusbscsi.h |    1 +
 2 files changed, 19 insertions(+), 2 deletions(-)
------

ChangeSet@1.1010, 2003-03-05 12:07:30-08:00, greg@kroah.com
  [PATCH] USB: added support for radio shack device to pl2303 driver.
  
  Thanks to gene_heskett@iolinc.net for the info for this.

Push file://home/greg/linux/BK/gregkh-2.4 -> file://home/greg/linux/BK/bleed-2.4
 drivers/usb/serial/pl2303.c |    1 +
 drivers/usb/serial/pl2303.h |    3 +++
 2 files changed, 4 insertions(+)
------

