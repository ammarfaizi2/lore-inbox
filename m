Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbTEQJho (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 05:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTEQJho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 05:37:44 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:38037 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S261324AbTEQJhn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 05:37:43 -0400
Date: Sat, 17 May 2003 11:50:04 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: David Gibson <david@gibson.dropbear.id.au>, Greg KH <greg@kroah.com>,
       Oliver Neukum <oliver@neukum.org>, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030517095004.GA16086@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <200305170155.15295.oliver@neukum.org> <20030517000338.GA17466@kroah.com> <20030517044459.GB13827@zax> <20030517084612.GC3808@ranty.ddts.net> <20030517090705.GA16092@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030517090705.GA16092@zax>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 07:07:05PM +1000, David Gibson wrote:
> On Sat, May 17, 2003 at 10:46:12AM +0200, Manuel Estrada Sainz wrote:
> > On Sat, May 17, 2003 at 02:44:59PM +1000, David Gibson wrote:
> > > On Fri, May 16, 2003 at 05:03:38PM -0700, Greg Kroah-Hartman wrote:
> > > > On Sat, May 17, 2003 at 01:55:15AM +0200, Oliver Neukum wrote:
> > > > > 
[snip]
> How about combining these two ideas: instead of "loading" and "data"
> we have "size" and "data".  First you write the size, then the data -
> the driver accepts it once it gets the expected number of bytes.
> Writing a new size throws away any partial image that's there, and
> restarts the upload.  Writing 0 cancels the upload entirely, and the
> driver will presumably fail to initialize (or maybe use a default
> image if it has one).

 Sounds good. I'll try that.
 
> There's another question - what happens if userspace tries to write an
> image when the driver hasn't requested one through hotplug?

 If you use request_firmware() directly, userspace will not find any
 file to write to :-)

 If you really want to be able to do that, instead of using
 request_firmware() you could register a class_device of class firmware
 and implement 'size'_show/store and 'data'_read/write. Thus exposing
 the firmware memory to userspace. The sequence would be like this:
	- On size_store you setup the download.
	- You can write directly to the device's memory on data_write.
	- Once you get all data you get the device back working.

 With this approach, you get the hotplug event for free and can take
 advantage of compatible userspace scripts.

 This is not currently possible, but should be easy to do if found
 interesting. I'll provide a (non-functional) sample next time.

 Thanks

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
