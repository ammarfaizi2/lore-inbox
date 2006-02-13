Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422761AbWBNSc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422761AbWBNSc3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422762AbWBNSc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:32:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:59342 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422761AbWBNSc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:32:28 -0500
Date: Mon, 13 Feb 2006 07:49:21 -0800
From: Greg KH <greg@kroah.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: davidsen@tmr.com, nix@esperi.org.uk, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060213154921.GA22597@kroah.com>
References: <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <43F0891E.nailKUSCGC52G@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F0891E.nailKUSCGC52G@burner>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 02:26:54PM +0100, Joerg Schilling wrote:
> Greg KH <greg@kroah.com> wrote:
> 
> > On Fri, Feb 10, 2006 at 04:06:39PM -0500, Bill Davidsen wrote:
> > > 
> > > The kernel could provide a list of devices by category. It doesn't have 
> > > to name them, run scripts, give descriptions, or paint them blue. Just a 
> > > list of all block devices, tapes, by major/minor and category (ie. 
> > > block, optical, floppy) would give the application layer a chance to do 
> > > it's own interpretation.
> >
> > It does so today in sysfs, that is what it is there for.
> 
> Do you really whant libscg to open _every_ non-directory file under /sys?

Of course not.  Here's one line of bash that gets you the major:minor
file of every block device in the system:
	block_devices="$(echo /sys/block/*/dev /sys/block/*/*/dev)"

The block devices are all in a specific location.

And here's a way to get the cdroms of the system:
	media="$(echo /sys/block/*/device/media)"
	for i in $media; do
		type="$(cat $i)"
		if [ "${type}" == "cdrom" ]
		then
			# we have a cdrom here, at $media block device
		fi
	done

If you want to do this in C, there is a libsysfs, which should help you
out a bit on intregrating sysfs support into your program (although udev
has recently ripped it out and replaced it with 200 lines of code that
is way smaller and much faster...)

Hope this helps,

greg k-h
