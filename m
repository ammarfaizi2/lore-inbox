Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261893AbTCQTr7>; Mon, 17 Mar 2003 14:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261898AbTCQTr7>; Mon, 17 Mar 2003 14:47:59 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:12805 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261893AbTCQTrx>;
	Mon, 17 Mar 2003 14:47:53 -0500
Date: Mon, 17 Mar 2003 11:46:56 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB changes for 2.5.64
Message-ID: <20030317194656.GA2255@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more small USB changes.  Included here is a spelling
patch, more USB devices are now supported, some memory leaks on error
paths fixed, and a few minor cleanups in a few different drivers.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h


 drivers/usb/class/bluetty.c           |    4 -
 drivers/usb/class/cdc-acm.c           |    4 -
 drivers/usb/class/usb-midi.c          |    2 
 drivers/usb/core/hub.c                |    4 -
 drivers/usb/core/urb.c                |    4 -
 drivers/usb/host/hc_simple.c          |    2 
 drivers/usb/host/hc_simple.h          |    4 -
 drivers/usb/host/hc_sl811.h           |    2 
 drivers/usb/host/ohci-q.c             |    6 +-
 drivers/usb/host/uhci-hcd.c           |    2 
 drivers/usb/image/hpusbscsi.c         |    4 -
 drivers/usb/image/hpusbscsi.h         |    2 
 drivers/usb/image/scanner.c           |   76 ++++++++++++++++++++++------------
 drivers/usb/image/scanner.h           |    4 +
 drivers/usb/input/hid-core.c          |    2 
 drivers/usb/input/hid-input.c         |    2 
 drivers/usb/input/hid.h               |    6 +-
 drivers/usb/media/dsbr100.c           |   75 ++++++++++++++++++---------------
 drivers/usb/media/konicawc.c          |    2 
 drivers/usb/media/pwc-ctrl.c          |    2 
 drivers/usb/media/pwc-if.c            |    6 +-
 drivers/usb/media/pwc-uncompress.c    |    2 
 drivers/usb/media/pwc.h               |    2 
 drivers/usb/media/se401.c             |    2 
 drivers/usb/media/vicam.c             |    2 
 drivers/usb/misc/auerswald.c          |   16 +++----
 drivers/usb/misc/speedtouch.c         |   70 ++++++++++++++++++-------------
 drivers/usb/net/usbnet.c              |    2 
 drivers/usb/serial/belkin_sa.c        |    2 
 drivers/usb/serial/cyberjack.c        |    2 
 drivers/usb/serial/io_edgeport.c      |    2 
 drivers/usb/serial/io_ionsp.h         |    2 
 drivers/usb/serial/io_ti.c            |   22 ++++++++-
 drivers/usb/serial/ir-usb.c           |    4 -
 drivers/usb/serial/keyspan_usa26msg.h |    2 
 drivers/usb/serial/keyspan_usa28msg.h |    2 
 drivers/usb/serial/keyspan_usa49msg.h |    2 
 drivers/usb/serial/kobil_sct.c        |    2 
 drivers/usb/serial/pl2303.c           |    1 
 drivers/usb/serial/pl2303.h           |    3 +
 drivers/usb/serial/usb-serial.c       |    4 -
 drivers/usb/serial/usb-serial.h       |    2 
 drivers/usb/serial/visor.c            |   10 ++++
 drivers/usb/serial/visor.h            |    2 
 drivers/usb/storage/isd200.c          |    6 +-
 drivers/usb/storage/transport.h       |    2 
 drivers/usb/usb-skeleton.c            |    2 
 47 files changed, 233 insertions(+), 152 deletions(-)
-----
Short changelog:

<green@linuxhacker.ru>:
  o USB: memleak in Edgeport USB Serial Converter driver
  o USB: more Edgeport USB Serial Converter driver stuff
  o Memleak in KOBIL USB Smart Card Terminal Driver

<msdemlei@cl.uni-heidelberg.de>:
  o USB: Patch for DSBR-100 driver

David Brownell <david-b@pacbell.net>:
  o USB ohci:  "registers" sysfs file

Duncan Sands <baldrick@wanadoo.fr>:
  o USB speedtouch: send path optimization

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: added support for Ericsson data cable to pl2303 driver
  o USB: fixup from previous io_ti.c patch
  o USB: Added support for the Sony Clie NZ90V device
  o USB: fix up a comment in usb_unlink()
  o USB: added support for the palm M100

Henning Meier-Geinitz <henning@meier-geinitz.de>:
  o USB: Fix crash in read/write/ioctl in scanner driver

Johannes Erdfelt <johannes@erdfelt.com>:
  o uhci-hcd.c 2.5 finish completions in correct order

Steven Cole <elenstev@mesatop.com>:
  o USB: spelling fixes for drivers/usb

-----
Long changelog:


ChangeSet@1.1094.6.14, 2003-03-14 15:06:18-08:00, greg@kroah.com
  [PATCH] USB: added support for Ericsson data cable to pl2303 driver.
  
  Thanks to kai.engert@gmx.de for the needed information

 drivers/usb/serial/pl2303.c |    1 +
 drivers/usb/serial/pl2303.h |    3 +++
 2 files changed, 4 insertions(+)
------

ChangeSet@1.1094.6.13, 2003-03-14 12:06:50-08:00, greg@kroah.com
  [PATCH] USB: fixup from previous io_ti.c patch

 drivers/usb/serial/io_ti.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.1094.6.12, 2003-03-14 12:05:46-08:00, green@linuxhacker.ru
  [PATCH] USB: memleak in Edgeport USB Serial Converter driver

 drivers/usb/serial/io_ti.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)
------

ChangeSet@1.1094.6.11, 2003-03-14 11:58:58-08:00, elenstev@mesatop.com
  [PATCH] USB: spelling fixes for drivers/usb
  
  This spelling and typo cleanup patch was reviewed by Mike Hayes and
  Jared Daniel J. Smith.

 drivers/usb/class/bluetty.c           |    4 ++--
 drivers/usb/class/cdc-acm.c           |    4 ++--
 drivers/usb/class/usb-midi.c          |    2 +-
 drivers/usb/core/hub.c                |    4 ++--
 drivers/usb/core/urb.c                |    2 +-
 drivers/usb/host/hc_simple.c          |    2 +-
 drivers/usb/host/hc_simple.h          |    4 ++--
 drivers/usb/host/hc_sl811.h           |    2 +-
 drivers/usb/image/hpusbscsi.c         |    4 ++--
 drivers/usb/image/hpusbscsi.h         |    2 +-
 drivers/usb/image/scanner.c           |    6 +++---
 drivers/usb/input/hid-core.c          |    2 +-
 drivers/usb/input/hid-input.c         |    2 +-
 drivers/usb/input/hid.h               |    6 +++---
 drivers/usb/media/konicawc.c          |    2 +-
 drivers/usb/media/pwc-ctrl.c          |    2 +-
 drivers/usb/media/pwc-if.c            |    6 +++---
 drivers/usb/media/pwc-uncompress.c    |    2 +-
 drivers/usb/media/pwc.h               |    2 +-
 drivers/usb/media/se401.c             |    2 +-
 drivers/usb/media/vicam.c             |    2 +-
 drivers/usb/misc/auerswald.c          |   16 ++++++++--------
 drivers/usb/misc/speedtouch.c         |    2 +-
 drivers/usb/net/usbnet.c              |    2 +-
 drivers/usb/serial/belkin_sa.c        |    2 +-
 drivers/usb/serial/cyberjack.c        |    2 +-
 drivers/usb/serial/io_edgeport.c      |    2 +-
 drivers/usb/serial/io_ionsp.h         |    2 +-
 drivers/usb/serial/ir-usb.c           |    4 ++--
 drivers/usb/serial/keyspan_usa26msg.h |    2 +-
 drivers/usb/serial/keyspan_usa28msg.h |    2 +-
 drivers/usb/serial/keyspan_usa49msg.h |    2 +-
 drivers/usb/serial/usb-serial.c       |    4 ++--
 drivers/usb/serial/usb-serial.h       |    2 +-
 drivers/usb/storage/isd200.c          |    6 +++---
 drivers/usb/storage/transport.h       |    2 +-
 drivers/usb/usb-skeleton.c            |    2 +-
 37 files changed, 59 insertions(+), 59 deletions(-)
------

ChangeSet@1.1094.6.10, 2003-03-14 11:10:11-08:00, green@linuxhacker.ru
  [PATCH] USB: more Edgeport USB Serial Converter driver stuff

 drivers/usb/serial/io_ti.c |    4 ++++
 1 files changed, 4 insertions(+)
------

ChangeSet@1.1094.6.9, 2003-03-14 10:53:01-08:00, msdemlei@cl.uni-heidelberg.de
  [PATCH] USB: Patch for DSBR-100 driver
  
  I since you are  listed as the maintainer of the USB subsystem and
  I can't really see who else applies, I'm sending you a patch to my
  driver for the DSBR-100 USB radio.  This is mainly code cosmetics
  (fixed ugly missing spaces after commas I inherited from the
  aztech driver, some constants moved to preprocessor symbols), but
  there's one technical change: I used to stop the radio when my
  file descriptor was closed.  Petr Slansky <slansky@usa.net>
  pointed out that the other radio drivers don't do that, so
  now I just let the radio run.

 drivers/usb/media/dsbr100.c |   75 ++++++++++++++++++++++++--------------------
 1 files changed, 41 insertions(+), 34 deletions(-)
------

ChangeSet@1.1094.6.8, 2003-03-14 10:43:24-08:00, green@linuxhacker.ru
  [PATCH] Memleak in KOBIL USB Smart Card Terminal Driver
  
     There is a memleak on error exit path in KOBIL USB Smart Card Terminal
     Driver in both current 2.4 and 2.5.
     See the patch.
     Found with help of smatch + enhanced unfree script.

 drivers/usb/serial/kobil_sct.c |    2 ++
 1 files changed, 2 insertions(+)
------

ChangeSet@1.1094.6.7, 2003-03-14 10:43:09-08:00, johannes@erdfelt.com
  [PATCH] uhci-hcd.c 2.5 finish completions in correct order
  
  Here's the 2.5 version of the patch to uhci.c to finish completions in
  the correct order.

 drivers/usb/host/uhci-hcd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.1094.6.6, 2003-03-14 10:37:16-08:00, henning@meier-geinitz.de
  [PATCH] USB: Fix crash in read/write/ioctl in scanner driver
  
  Used kobject reference counting to free the scn struct when the device
  is closed and disconnected. Avoids crashes when writing to a
  disconnected device. (Thanks to Greg KH).
  
  I've also changed irq_scanner to avoid submitting new URBs when the
  old one returned with an error. Without this change irq_scanner gets
  called ever and ever again after a disconnect while open.

 drivers/usb/image/scanner.c |   70 ++++++++++++++++++++++++++++++--------------
 drivers/usb/image/scanner.h |    4 +-
 2 files changed, 51 insertions(+), 23 deletions(-)
------

ChangeSet@1.1094.6.5, 2003-03-14 10:36:55-08:00, david-b@pacbell.net
  [PATCH] USB ohci:  "registers" sysfs file
  
  > This exhibits a build error when OHCI_VERBOSE_DEBUG is enabled:
  
  Odd, I guess the build I tested was when that was enabled
  without first enabling debugging.  The fix is trivial.

 drivers/usb/host/ohci-q.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.1094.6.4, 2003-03-11 17:35:29-08:00, greg@kroah.com
  [PATCH] USB: Added support for the Sony Clie NZ90V device.
  
  Thanks to Martin Brachtl <brachtl@redgrep.cz> for the information.

 drivers/usb/serial/visor.c |    7 +++++++
 drivers/usb/serial/visor.h |    1 +
 2 files changed, 8 insertions(+)
------

ChangeSet@1.1094.6.3, 2003-03-11 17:16:12-08:00, greg@kroah.com
  [PATCH] USB: fix up a comment in usb_unlink()
  
  Thanks to David for pointing this out.

 drivers/usb/core/urb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.1094.6.2, 2003-03-11 17:13:26-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: send path optimization
  
  Write multiple cells in one function call, rather than one cell per
  function call.  Under maximum send load, this reduces cell writing
  CPU usage from 0.0095% to 0.0085% on my machine.  A 10% improvement! :)

 drivers/usb/misc/speedtouch.c |   68 +++++++++++++++++++++++++-----------------
 1 files changed, 41 insertions(+), 27 deletions(-)
------

ChangeSet@1.1094.6.1, 2003-03-11 17:02:44-08:00, greg@kroah.com
  [PATCH] USB: added support for the palm M100
  
  Thanks to C Falconer <cf@avonside.school.nz> for the information.

Push file://home/greg/linux/BK/gregkh-2.5 -> file://home/greg/linux/BK/bleed-2.5
 drivers/usb/serial/visor.c |    3 +++
 drivers/usb/serial/visor.h |    1 +
 2 files changed, 4 insertions(+)
------
