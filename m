Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWBMSDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWBMSDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWBMSDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:03:43 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:31375 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932381AbWBMSDm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:03:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YQkqcmHIS0Lirc7pZHC0rowzUgyQ1ttr9aw5YuVX7qth3ce17T0MgcuPazNhkATJzNDZN9I/Oe4o3xbeb9GUvFERFobBDFUbkmR89aEMJ2oKj1WdLlXARefHK+QlMjg5rrZRTKrX9bE8zKkAjJX0VXuL6vdvQ0TCEXMow3c1r20=
Message-ID: <d120d5000602131003l7bd1451bs64076475fdd6079c@mail.gmail.com>
Date: Mon, 13 Feb 2006 13:03:38 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: Daniel Barkalow <barkalow@iabervon.org>, Bill Davidsen <davidsen@tmr.com>,
       Nix <nix@esperi.org.uk>, Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060213175142.GB20952@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43D7AF56.nailDFJ882IWI@burner> <20060125173127.GR4212@suse.de>
	 <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix>
	 <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com>
	 <Pine.LNX.4.64.0602122256130.6773@iabervon.org>
	 <20060213062158.GA2335@kroah.com>
	 <Pine.LNX.4.64.0602130244500.6773@iabervon.org>
	 <20060213175142.GB20952@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Greg KH <greg@kroah.com> wrote:
> On Mon, Feb 13, 2006 at 03:05:49AM -0500, Daniel Barkalow wrote:
> > On Sun, 12 Feb 2006, Greg KH wrote:
> >
> > > On Mon, Feb 13, 2006 at 12:01:48AM -0500, Daniel Barkalow wrote:
> > > > sysfs doesn't do quite that level of categorization; if it did, cdrom_id
> > > > would be unnecessary.
> > >
> > > What?  cdrom_id queries the device directly to get some specific
> > > information about the device, much like any other type of device query
> > > (lspci, lsusb, etc.)
> > >
> > > And yes, it would be nice if some of that information was also exported
> > > through sysfs, and as always, patches are gladly accpeted.
> >
> > Are there guidelines on having a generic cdrom export information from its
> > block interface, rather than through its bus? I'm not finding any
> > documentation of sys/block/, aside from that it exists.
>
> That information should go into the device directory, not the sys/block
> directory (as it referrs to the device attributes, not the block gendev
> attributes.)
>

Not necessarily - it would be easier for userspace programs if we had
a separate class in sysfs - /sys/class/cdrom. The problem with this
approach is that we do not allow a device belong o several classes
without introducing intermediate class devices (I mean a DVD+RW shoudl
probably belong to classes cdrom, dvdrom, cdwriter and dvdwriter).

--
Dmitry
