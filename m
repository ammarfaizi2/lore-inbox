Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbUJ1BNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbUJ1BNo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 21:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUJ1BNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 21:13:44 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:60329 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262571AbUJ1BNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 21:13:41 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1, class_simple_* and GPL addition
Date: Wed, 27 Oct 2004 20:12:44 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, Norbert Preining <preining@logic.at>,
       Andrew Morton <akpm@osdl.org>
References: <20041027135052.GE32199@gamma.logic.tuwien.ac.at> <20041027153715.GB13991@kroah.com>
In-Reply-To: <20041027153715.GB13991@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410272012.44361.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 October 2004 10:37 am, Greg KH wrote:
> On Wed, Oct 27, 2004 at 03:50:52PM +0200, Norbert Preining wrote:
> > Hi Andrew!
> > 
> > The change from 
> > 	EXPORT_SYMBOL
> > to
> > 	EXPORT_SYMBOL_GPL
> > for class_simple_* makes the nvidia module useless as it uses several:
> > nvidia: Unknown symbol class_simple_device_add
> > nvidia: Unknown symbol class_simple_destroy
> > nvidia: Unknown symbol class_simple_device_remove
> > nvidia: Unknown symbol class_simple_create
> 
> I think these changes are only in the Gentoo modified version of the
> driver, right?  I don't think that nvidia wrote the driver that way.
> 
> > I don't want to start a flame war and long discussion, just want to ask
> > wether this change (to _GPL) was intended,
> 
> Yes it was.
> 

I wonder what are the technical merits of this change. I certainly agree
with Pat's assertion that the rest of driver model functions should be used
by in-kernel subsystems (such as PCI, USB, serio etc) only and not exposed
to the outside world. This will allow freely fix/enhance the core without
fear of silently breaking external modules.

But class_simple is itself a limited and contained interface with well-
defined semantic. Which I believe was advertised aat one time as a wrapper
for the objects wanting to plug into hotplug/udev model but either living
outside of established subsystems or within subsystem not yet ready to
implement proper refcounting needed for full-blown sysfs integration.

I think it is a mistake to convert class_simple into GPL-only export.  

--  
Dmitry
