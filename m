Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267694AbTACWhq>; Fri, 3 Jan 2003 17:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267697AbTACWhq>; Fri, 3 Jan 2003 17:37:46 -0500
Received: from mailer2.lut.ac.uk ([158.125.1.206]:46735 "EHLO
	mailer2.lut.ac.uk") by vger.kernel.org with ESMTP
	id <S267694AbTACWhp>; Fri, 3 Jan 2003 17:37:45 -0500
Message-ID: <3E1612D4.60304@lboro.ac.uk>
Date: Fri, 03 Jan 2003 22:46:44 +0000
From: A E Lawrence <A.E.Lawrence@lboro.ac.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-gb, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: GET_TIMEOUT too small for hotplugging in usb.c (2.4.20)
Content-Type: multipart/mixed;
 boundary="------------090003070803020604040003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090003070803020604040003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

There seem to be several threads in the archives which report problems that 
the small timeout seems to explain. Details attached.

ael

--------------090003070803020604040003
Content-Type: text/plain;
 name="usb_TIMEOUT.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usb_TIMEOUT.txt"

GET_TIMEOUT in usb.c requires a larger value to permit hotplugging
------------------------------------------------------------------

drivers/usb/usb.c from 2.4.20 (no version number in file)

#ifdef CONFIG_USB_LONG_TIMEOUT
#define GET_TIMEOUT 20          <== This was 4
#else
#define GET_TIMEOUT 3
#endif
#define SET_TIMEOUT 3

Hotplugging my usb Epson scanner ceased to work sometime ago. I have just 
traced this to a short GET_TIMEOUT in usb.c as above.

It is well known that Epson scanners take a long time to respond.
Mine takes around 12 seconds: the explanation seems to be that it switchs
on the transparency light source and waits for it to stabilize before answering
enquiries. This is covered in scanner.c which uses extended timeouts for
Epsons.

However, even with CONFIG_USB_LONG_TIMEOUT set, the timeout in usbcore is only
4 seconds, so the hotplug script does not get called to load that scanner
module. So the longer value of GET_TIMEOUT needs to be increased to at least
15 seconds, perhaps much longer to cover other devices that may be even slower?
Or should it become a module parameter?

A.E.Lawrence

--------------090003070803020604040003--

