Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbUKCT5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUKCT5e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUKCT4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:56:48 -0500
Received: from minimail.digi.com ([204.221.110.13]:27100 "EHLO
	minimail.digi.com") by vger.kernel.org with ESMTP id S261833AbUKCTzw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:55:52 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: patch for sysfs in the cyclades driver
Date: Wed, 3 Nov 2004 13:55:51 -0600
Message-ID: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D81B@minimail.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: patch for sysfs in the cyclades driver
Thread-Index: AcTBUcocM2la3948SzWTQ/WwNStlyQAi6wjQ
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Greg KH" <greg@kroah.com>
Cc: <germano.barreiro@cyclades.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, all,

> What's wrong with the kobject in /sys/class/tty/ which has one object
> per port?  I think we might not be exporting that class_device
> structure, but I would not have a problem with doing that.
> greg k-h

Using the simple class tty kobject that tty_io.c keeps might work for my
needs.

However, there is one thing that stopped me from using it earlier...

The naming of the directory (tty name) in /sys/class/tty is forced to
be:
"sprintf(p, "%s%d", driver->name, index + driver->name_base);"

Is it possible we could change this to be more relaxed about the naming
scheme?

Maybe we can allow a "custom" name to be sent into the
tty_register_device() call?
Like add another option parameter called "custom_name" that if non-NULL,
is used instead of the derived name?

Scott Kilau
Digi International




-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Tuesday, November 02, 2004 8:28 PM
To: Kilau, Scott
Cc: germano.barreiro@cyclades.com; linux-kernel@vger.kernel.org
Subject: Re: patch for sysfs in the cyclades driver


On Tue, Nov 02, 2004 at 02:51:33PM -0600, Kilau, Scott wrote:
> I know you have done work on USB serial drivers with devices with
> multiple ports...
> Is there any way to create a file in sys that can point back to a
port,
> and NOT the port's
> parent (ie, the board) WITHOUT having to create a new kobject per
port?

> What's wrong with the kobject in /sys/class/tty/ which has one object
> per port?  I think we might not be exporting that class_device
> structure, but I would not have a problem with doing that.
> greg k-h
