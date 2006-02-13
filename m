Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWBMTJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWBMTJk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWBMTJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:09:40 -0500
Received: from iabervon.org ([66.92.72.58]:26886 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964799AbWBMTJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:09:39 -0500
Date: Mon, 13 Feb 2006 14:09:55 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: dtor_core@ameritech.net
cc: Greg KH <greg@kroah.com>, Bill Davidsen <davidsen@tmr.com>,
       Nix <nix@esperi.org.uk>, Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <d120d5000602131003l7bd1451bs64076475fdd6079c@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0602131339140.6773@iabervon.org>
References: <43D7AF56.nailDFJ882IWI@burner> <20060125173127.GR4212@suse.de>
  <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> 
 <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> 
 <Pine.LNX.4.64.0602122256130.6773@iabervon.org>  <20060213062158.GA2335@kroah.com>
  <Pine.LNX.4.64.0602130244500.6773@iabervon.org>  <20060213175142.GB20952@kroah.com>
 <d120d5000602131003l7bd1451bs64076475fdd6079c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Dmitry Torokhov wrote:

> On 2/13/06, Greg KH <greg@kroah.com> wrote:
> > On Mon, Feb 13, 2006 at 03:05:49AM -0500, Daniel Barkalow wrote:
> > > Are there guidelines on having a generic cdrom export information from its
> > > block interface, rather than through its bus? I'm not finding any
> > > documentation of sys/block/, aside from that it exists.
> >
> > That information should go into the device directory, not the sys/block
> > directory (as it referrs to the device attributes, not the block gendev
> > attributes.)
> >
> 
> Not necessarily - it would be easier for userspace programs if we had
> a separate class in sysfs - /sys/class/cdrom. The problem with this
> approach is that we do not allow a device belong o several classes
> without introducing intermediate class devices (I mean a DVD+RW shoudl
> probably belong to classes cdrom, dvdrom, cdwriter and dvdwriter).

I don't think it needs to be a class, but I think that there should be a 
single place with a directory for each device that could be what you want, 
with a file that tells you if it is. That's why I was looking at block/; 
these things must be block devices, and there aren't an huge number of 
block devices.

I suppose "grep 1 /sys/block/*/device/dvdwriter" is just as good; I hadn't 
dug far enough in to realize that the reason I wasn't seeing anything 
informative in /sys/block/*/device/ was that I didn't have any devices 
with informative drivers, not that it was actually supposed to only have 
links to other things.

	-Daniel
*This .sig left intentionally blank*
