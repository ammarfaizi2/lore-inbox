Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbTEETxT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTEETxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:53:19 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:24961 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261260AbTEETxQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:53:16 -0400
Date: Mon, 5 May 2003 13:08:07 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [RFC] support for sysfs string based properties for SCSI (1/3)
Message-ID: <20030505200807.GA1314@beaverton.ibm.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>
References: <1051989099.2036.7.camel@mulgrave> <1051989565.2036.14.camel@mulgrave> <20030505170202.GA1296@kroah.com> <1052154516.1888.33.camel@mulgrave> <20030505171745.GA1477@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505171745.GA1477@kroah.com>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH [greg@kroah.com] wrote:
> On Mon, May 05, 2003 at 12:08:35PM -0500, James Bottomley wrote:
> > On Mon, 2003-05-05 at 12:02, Greg KH wrote:
> > > On Sat, May 03, 2003 at 02:19:23PM -0500, James Bottomley wrote:
> > > > diff -Nru a/drivers/base/core.c b/drivers/base/core.c
> > > > --- a/drivers/base/core.c	Sat May  3 14:18:21 2003
> > > > +++ b/drivers/base/core.c	Sat May  3 14:18:21 2003
> > > > @@ -42,6 +42,8 @@
> > > >  
> > > >  	if (dev_attr->show)
> > > >  		ret = dev_attr->show(dev,buf);
> > > > +	else if (dev->bus->show)
> > > > +		ret = dev->bus->show(dev, buf, attr);
> > > >  	return ret;
> > > 
> > > Can't you do this by using the class interface instead?
> > 
> > I don't know, I haven't digested the class interface patches yet, since
> > they just appeared this morning.
> 
> I think Mike has a patch queued up that takes advantage of the class
> code, which might address all of these issues.  Mike?
> 

The patches I sent add class support for scsi_host, but this only gives
granularity of attributes specific to scsi_host. There is no built in
functionality to override show or store handler functions.


-andmike
--
Michael Anderson
andmike@us.ibm.com

