Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262739AbSJCFkT>; Thu, 3 Oct 2002 01:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262740AbSJCFkT>; Thu, 3 Oct 2002 01:40:19 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:24331 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262739AbSJCFkR>;
	Thu, 3 Oct 2002 01:40:17 -0400
Date: Wed, 2 Oct 2002 22:43:07 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.40
Message-ID: <20021003054306.GB17960@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series also includes a bugfix to the driver core hotplug logic.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 drivers/usb/serial/usbserial.c  | 1950 ----------------------------------------
 drivers/base/hotplug.c          |    1 
 drivers/usb/Makefile            |    1 
 drivers/usb/core/message.c      |   13 
 drivers/usb/core/usb.c          |    2 
 drivers/usb/input/usbkbd.c      |    4 
 drivers/usb/misc/Config.help    |    6 
 drivers/usb/misc/Config.in      |    1 
 drivers/usb/misc/Makefile       |    1 
 drivers/usb/misc/speedtouch.c   |   15 
 drivers/usb/misc/usbtest.c      |  570 +++++++++++
 drivers/usb/net/pegasus.h       |    2 
 drivers/usb/net/rtl8150.c       |   61 +
 drivers/usb/serial/Makefile     |    9 
 drivers/usb/serial/console.c    |  266 +++++
 drivers/usb/serial/usb-serial.c | 1683 ++++++++++++++++++++++++++++++++++
 drivers/usb/serial/usb-serial.h |   15 
 17 files changed, 2624 insertions(+), 1976 deletions(-)
-----

ChangeSet@1.683, 2002-10-02 22:34:04-07:00, greg@kroah.com
  USB: split the usb serial console code out into its own file.

 drivers/usb/serial/usbserial.c  | 1950 ----------------------------------------
 drivers/usb/serial/Makefile     |    9 
 drivers/usb/serial/console.c    |  266 +++++
 drivers/usb/serial/usb-serial.c | 1683 ++++++++++++++++++++++++++++++++++
 drivers/usb/serial/usb-serial.h |   15 
 5 files changed, 1970 insertions(+), 1953 deletions(-)
------

ChangeSet@1.682, 2002-10-02 16:22:25-07:00, greg@kroah.com
  [PATCH] hotplug: fix for non-pci and usb calls
  
  clear the environment variables so for busses without callbacks, we can
  successfully call /sbin/hotplug.
  
  Thanks to patmans@us.ibm.com for finding this bug.

 drivers/base/hotplug.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.681, 2002-10-02 14:44:06-07:00, greg@kroah.com
  USB: speedtouch driver fix due to ioctl function parameter change

 drivers/usb/misc/speedtouch.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)
------

ChangeSet@1.680, 2002-10-02 14:26:29-07:00, david-b@pacbell.net
  [PATCH] USB: framework for testing usbcore
  
  USB test driver

 drivers/usb/Makefile         |    1 
 drivers/usb/misc/Config.help |    6 
 drivers/usb/misc/Config.in   |    1 
 drivers/usb/misc/Makefile    |    1 
 drivers/usb/misc/usbtest.c   |  570 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 579 insertions(+)
------

ChangeSet@1.679, 2002-10-02 14:21:13-07:00, cip307@cip.physik.uni-wuerzburg.de
  [PATCH] USB: string query fix
  
  Query for stringlen before reading a string in usb.c

 drivers/usb/core/message.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)
------

ChangeSet@1.678, 2002-10-02 11:48:32-07:00, luc.vanoostenryck@easynet.be
  [PATCH] 2.5.40: warning fix for drivers/usb/core/usb.c
  
  usb_hotplug()' prototype doesn't match when CONFIG_HOTPLUG is not defined.

 drivers/usb/core/usb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.677, 2002-10-02 11:47:51-07:00, davem@redhat.com
  [PATCH] USB: usbkbd fix
  

 drivers/usb/input/usbkbd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.676, 2002-10-02 11:21:03-07:00, petkan@users.sourceforge.net
  [PATCH] USB: pegasus update
  
    device ID fix

 drivers/usb/net/pegasus.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.675, 2002-10-02 11:16:55-07:00, petkan@users.sourceforge.net
  [PATCH] USB: rtl8150 update
  
  set_mac_address is now added to the driver.  thanks to Orjan Friberg <orjan.friberg@axis.com>
  the actual writing to the eeprom is disabled by default

 drivers/usb/net/rtl8150.c |   61 +++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 53 insertions(+), 8 deletions(-)
------

