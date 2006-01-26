Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWAZToN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWAZToN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWAZToN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:44:13 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:21262 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932257AbWAZToM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:44:12 -0500
Date: Thu, 26 Jan 2006 20:44:02 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060126194402.GB51864@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Diego Calleja <diegocg@gmail.com>, vojtech@suse.cz,
	linux-kernel@vger.kernel.org
References: <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz> <20060126175506.GA32972@dspnet.fr.eu.org> <20060126181034.GA9694@suse.cz> <20060126182818.GA44822@dspnet.fr.eu.org> <20060126202832.baa824b6.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060126202832.baa824b6.diegocg@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 08:28:32PM +0100, Diego Calleja wrote:
> El Thu, 26 Jan 2006 19:28:18 +0100,
> Olivier Galibert <galibert@pobox.com> escribió:
> 
> > - find the devices, what should I scan/filter on.  udev seems likes it
> >   needs to run a program (/sbin/cdrom_id) or scan
> >   /proc/sys/dev/cdrom/info just to know if a device is a cdrom...
> 
> Not at all - /sys/devices/pci0000:00/0000:00:0f.1/ide1/1.0/media 
> tells that in my box. cdrom_id is, AFAICS, a way to find the
> capabilities of the drive (ie, look if it's a cdrom or a dvd, etc)

Hmmm, since when?  The most recent kernel with a cdrom attached I have
handy is a 2.6.14-rc2, and it does not give a "media" entry.

/proc/ide has it though.  Of course, I'd hoped the point of sysfs and
SG_IO was not to have to care whether it's scsi, ide, usb or something
else underlying...


> > - find the /dev name associated to a sysfs-found device.
> 
> HAL tells you that the sysfs path associated to a device.
> 
> root@estel # hal-get-property --udi '/org/freedesktop/Hal/devices/block_HL-DT-ST DVDRAM GSA-4163B-K01544H0250' --key 'block.device'
> /dev/cd-rw
> root@estel #
> 
> (yes, that "udi" path sucks)

Indeed, since the model is not given in sysfs, at least with
2.6.14-rc2 or previous.  There too, /proc/ide has it.  I also have no
idea what that "GSA" thing is either.


> Although that sucks, IMO the whole point of udev/hal & friends is to
> be able to make programs work regardless of what the name of the device
> is (or at least, if I had to use a program, I would like that the program
> design is good enought that it just ask the system what cd recorders are
> connected to the system).

Me too.  But at this point it looks like we have to go back to the
good old "scan /dev/hd?, /dev/scd*, /dev/sr*, /dev/sg* and pray".
Pity.

  OG.
