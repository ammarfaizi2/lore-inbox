Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269602AbTGJVv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 17:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbTGJVvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:51:45 -0400
Received: from [205.200.104.254] ([205.200.104.254]:45612 "EHLO
	pl6w2kex.lan.powerlandcomputers.com") by vger.kernel.org with ESMTP
	id S269602AbTGJVur convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:50:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21, patchattached to fix
Date: Thu, 10 Jul 2003 17:05:25 -0500
Message-ID: <18DFD6B776308241A200853F3F83D507279B@pl6w2kex.lan.powerlandcomputers.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21, patchattached to fix
Thread-Index: AcNHKNcGo84AXJPsQAeVDq6qS0/6SQAAbydQ
From: "Chad Kitching" <CKitching@powerlandcomputers.com>
To: "Samuel Flory" <sflory@rackable.com>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "Steven Dake" <sdake@mvista.com>, <linux-kernel@vger.kernel.org>,
       <andre@linux-ide.org>, <frankt@promise.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know.  That seemed to have changed the option from merely mystifying to down right confusing.  By that wording, does that feature override it into being a plain IDE controller, or an IDE RAID controller?  The new name seems to imply the former, while the mentions of ataraid suggest the latter.

Despite the grammatical errors, pdc202xx.c's comments perhaps describe it better.
* Linux kernel will misunderstand FastTrak ATA-RAID series as Ultra
* IDE Controller, UNLESS you enable "CONFIG_PDC202XX_FORCE"
* That's you can use FastTrak ATA-RAID controllers as IDE controllers.

If this is true, may I suggest something more along the lines of:

Ignore FastTrak BIOS and configure controller for RAID
CONFIG_PDC202XX_FORCE
  Forces the driver to use the ATA-RAID capabilities, overriding the
  BIOS configuration of the controller. Do not enable if you are
  using Promise's binary module.  This option is compatible with the 
  ataraid driver.

If the Linux driver has the same limitation in regards to using CD-ROM drives on the controller while it's in RAID mode as the Windows drivers do, it may be useful to mention the fact that the option is incompatible with CD-ROM drives attached to the controller.

Of course, maybe it means the complete opposite, and I'm reading everything wrong, in which case, there are some comments you may want to fix, too.

-----Original Message-----
From: Samuel Flory
Sent: July 10, 2003 4:11 PM
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21,
patchattached to fix


Bartlomiej Zolnierkiewicz wrote:

>Hi,
>
>Do you have "Special FastTrak Feature" enabled?
  
Can we change the option to something that makes sense.  I get the 
feeling no one understands what it does at 1st glance.  This is the 2nd 
time I've seen a patch like this. 
