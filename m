Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVFNGOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVFNGOs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 02:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVFNGOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 02:14:47 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:28576 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261240AbVFNGOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 02:14:45 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: Input sysbsystema and hotplug
Date: Tue, 14 Jun 2005 01:14:38 -0500
User-Agent: KMail/1.8.1
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
References: <200506131607.51736.dtor_core@ameritech.net> <200506131638.09140.dtor_core@ameritech.net> <20050613221736.GC15381@suse.de>
In-Reply-To: <20050613221736.GC15381@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506140114.39398.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 June 2005 17:17, Greg KH wrote:
> On Mon, Jun 13, 2005 at 04:38:08PM -0500, Dmitry Torokhov wrote:
> > On Monday 13 June 2005 16:26, Kay Sievers wrote:
> > > On Mon, Jun 13, 2005 at 04:07:51PM -0500, Dmitry Torokhov wrote:
> > > > 
> > > > where inputX are class devices, mouse and event are subclasses of input
> > > > class and mouseX and eventX are again class devices.
> > > 
> > > We don't support childs of class devices until now. Would be nice maybe, but
> > > someone needs to add that to the driver-core first and we would need to make
> > > a bunch of userspace stuff aware of it ...
> > > 
> > 
> > Something like patch below will suffice I think (not tested).
> 
> No, you need to increment the parent when you register the child.  Look
> at the device code for what's needed for this.
>

Don't quite follow what you are saying. If you are saying that it needs
to call class_get(parent) I don't think it's necessary as kobject code
will grab the reference (to class's subsystem kset).

All in all it seems to be working:

[dtor@core ~]$ ls /sys/class/input_dev/
input0  input3  input4  input_dev_subclass
[dtor@core ~]$

-- 
Dmitry
