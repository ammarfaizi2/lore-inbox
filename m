Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbTFRDbZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 23:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbTFRDbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 23:31:25 -0400
Received: from fmr01.intel.com ([192.55.52.18]:34252 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S265061AbTFRDbX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 23:31:23 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780DD16A41@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'Alan Stern'" <stern@rowland.harvard.edu>
Cc: "'Patrick Mochel'" <mochel@osdl.org>,
       "'Russell King'" <rmk@arm.linux.org.uk>, "'Greg KH'" <greg@kroah.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Flaw in the driver-model implementation of attributes
Date: Tue, 17 Jun 2003 20:44:50 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kevin P. Fleming [mailto:kpfleming@cox.net]
>
> These are two wildly differing views, but yes, they are the same device.
> These differing attributes do _not_ belong in the same directory. An
> application looking at your IDE devices does not really care how the
> block subsystem perceives those devices (i.e. hdparm). Conversely, an
> application looking at your block devices should not care about what
> underlying physical devices (if any :-) they are associated with. 

But that is describing a physical mapping vs. a logical view.

I can think of many different "views" I want to see (IDE, block,
physical, block sorted by size, the ones who are green and sing 
in Basque...) but only one is unique and inherently defined: the
physical one. 

I guess I agree with Alan; I'd prefer something like:

/sys/devices/pci0/0000:00:07.1/ide0/0.0/
  attr1
  attr2 ...   sysfs specific attrs 
  block-attr1
  block-attr2 ... block layer specific attrs
  ide-attr1
  ide-attr2 ... ide layer specific attrs

(or make that TAG- a subdirectory of the device if you wish,
that is just an example). 

This way, for each device I have an *unique* location where to
track it, and an easy way to hunt down attributes specific to
each layer that controls it.

And when, when I want to make logical views (again, by IDE, by
block device ...), I can do that from user space and create a
tree full of symlinks to the unique, physical locations.

Maybe this is going to kill my argument as an analogy, but think
about a C++ class hierarchy, where belonging to a class means
to inherit that class' methods. When an object is instantiated
and its class inherits a lot of other classes, it inherits all
the methods of those classes. Your methods are the attrs, and
you can access them with the same pointer, you don't  need to
look somewhere else ...

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
