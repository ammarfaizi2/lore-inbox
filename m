Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVAEJ7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVAEJ7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 04:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVAEJ7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 04:59:44 -0500
Received: from dsl-217-155-115-179.zen.co.uk ([217.155.115.179]:4480 "HELO
	felix.billp.org") by vger.kernel.org with SMTP id S262311AbVAEJ7S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 04:59:18 -0500
From: bil@beeb.net
Reply-To: bil@beeb.net
To: linux-kernel@vger.kernel.org
Subject: problems with 2.6.10
Date: Wed, 5 Jan 2005 09:59:13 +0000
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501050959.14091.bil@beeb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've downloaded, configured and compiled 2.6.10 for my IBM Thinkpad A21m.
I've installed quite a few kernels over the years, and while not a
kernel expert, thought I understood enough to get by. Sadly when I
tried to boot up the new kernel I get a few error messages which I
can't figure out. Also, once the system is up my keyboard is DEAD.
My only option is the power-off button! My 'base' system is Mandrake 10.0.
I have been running 2.6.7 with only minor problems (hence the desire
to upgrade to 2.6.10).

The error messages that I've been able to find in the log are:
(I'm including an 'expected' message to indicate roughly the context)

Jan  5 08:22:33 felix kernel: Loaded 23850 symbols 
from /boot/System.map-2.6.10.
Jan  5 08:22:33 felix kernel: Symbols match kernel version 2.6.10.
Jan  5 08:22:33 felix kernel: No module symbols loaded - kernel modules not 
enabled.

This is right at the start of the log. Not sure if this means that the symbols
for the modules are not enabled, as various module-provided functions do
seem to be working. I can't run lsmod to check as the keyboard is dead.

Jan  5 08:22:33 felix kernel: Mounted devfs on /dev
Jan  5 08:22:33 felix kernel: jbd: version magic '2.6.3-7mdk 586 ' should be 
'2.6.10 PENTIUMIII gcc-3.3'
Jan  5 08:22:33 felix kernel: ext3: version magic '2.6.3-7mdk 586 ' should be 
'2.6.10 PENTIUMIII gcc-3.3'

Not sure if these are significant. 2.6.3-7mdk is the original Mandrake 10.0
kernel.

Jan  5 08:22:18 felix usb: Initializing USB controller (usb-uhci):  succeeded 
Jan  5 08:22:18 felix mount: mount: fs type usbdevfs not supported by kernel 
Jan  5 08:22:18 felix usb: Mount USB filesystem failed 

This worries me - I definitely have usbdevfs marked in the config:

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

Despite this, USB seems to be working OK, my mouse is USB and that was
responding when X11 had come up.

Jan  5 08:22:31 felix ifplugd(eth0)[1716]: Using interface eth0 
Jan  5 08:22:31 felix ifplugd(eth0)[1716]: Failed to detect plug status of 
eth0 
Jan  5 08:22:31 felix ifplugd(eth0)[1716]: Executing 
'/etc/ifplugd/ifplugd.action eth0 up'. 
Jan  5 08:22:31 felix ifplugd(eth0)[1716]: client: xircom_tulip_cb device eth0 
does not seem to be present, delaying initialization. 
Jan  5 08:22:31 felix ifplugd(eth0)[1716]: Program execution failed, return 
value is 1. 
Jan  5 08:22:31 felix ifplugd(eth0)[1716]: Exiting. 

This is serious! If the ethernet had come up, there was a chance that I
could have logged in via ssh to debug further. The ethernet comes up fine
under 2.6.7

That's all the error  messages that I could find. Everything else seemed
to be much as normal. I can live with a few error messages at boot-up
provided things continue to work, but a dead keyboard is a major setback.

After I rebooted back to 2.6.7 I checked the .config file, and checked
to see what modules were around and thought I'd found something - the
'input.ko' module was missing. Checking through using 'make xconfig'
I discovered that there was no option for this - it's just displayed
as a heading. However, checking the .config file shows 

CONFIG_INPUT=y

so I presume that the 'module' has been compiled into the kernel.

I'm not a subscriber to the lkml (too much traffic) so I'd appreciate
a direct reply if anyone can help. 

Many thanks

Bill
-- 
+-----------------------------------------------+
| Bill Purvis, thrice-retired software engineer |
| e-mail:  bil@beeb.net                         |
| web:     bil.members.beeb.net                 |
+-----------------------------------------------+
