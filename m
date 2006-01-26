Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWAZT3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWAZT3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWAZT3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:29:15 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:49567 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751366AbWAZT3O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:29:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=hWEo/NoSEiAbUM99vS6fHWxpvIpoYCTP2/8laQtfJTzsxMCJM26yLCReocbe88tdGbpLbjg37JHnZE7eM1FEFbKMRkJjb0rKTjyshhd+WcuWEpecLVgtPYTuQ4JlLUtJLyGpjAAeVx1x/Upnv1/ijfV16KE2E913wO4QcpxzZUU=
Date: Thu, 26 Jan 2006 20:28:32 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060126202832.baa824b6.diegocg@gmail.com>
In-Reply-To: <20060126182818.GA44822@dspnet.fr.eu.org>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	<43D7A7F4.nailDE92K7TJI@burner>
	<8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
	<43D7B1E7.nailDFJ9MUZ5G@burner>
	<20060125230850.GA2137@merlin.emma.line.org>
	<43D8C04F.nailE1C2X9KNC@burner>
	<20060126161028.GA8099@suse.cz>
	<20060126175506.GA32972@dspnet.fr.eu.org>
	<20060126181034.GA9694@suse.cz>
	<20060126182818.GA44822@dspnet.fr.eu.org>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 26 Jan 2006 19:28:18 +0100,
Olivier Galibert <galibert@pobox.com> escribió:

> - find the devices, what should I scan/filter on.  udev seems likes it
>   needs to run a program (/sbin/cdrom_id) or scan
>   /proc/sys/dev/cdrom/info just to know if a device is a cdrom...

Not at all - /sys/devices/pci0000:00/0000:00:0f.1/ide1/1.0/media 
tells that in my box. cdrom_id is, AFAICS, a way to find the
capabilities of the drive (ie, look if it's a cdrom or a dvd, etc)

You can get the info even with a fancy output:

root@estel# systool -v -b ide
Bus = "ide"

  Device = "0.0"
  Device path = "/sys/devices/pci0000:00/0000:00:0f.1/ide0/0.0"
    drivename           = "hda"
    media               = "disk"
    modalias            = "ide:m-disk"
    uevent              = <store method only>

  Device = "1.0"
  Device path = "/sys/devices/pci0000:00/0000:00:0f.1/ide1/1.0"
    drivename           = "hdc"
    media               = "cdrom"
    modalias            = "ide:m-cdrom"
    uevent              = <store method only>

I guess the cdrom driver could in the future be taught to export
more data (the previus cdrom drive is really a dvd drive...) to 
the sysfs interface to know if it's a dvd so that cdrom_id is 
unnecesary in some cases.



> - find the /dev name associated to a sysfs-found device.

HAL tells you that the sysfs path associated to a device.

root@estel # hal-get-property --udi '/org/freedesktop/Hal/devices/block_HL-DT-ST DVDRAM GSA-4163B-K01544H0250' --key 'block.device'
/dev/cd-rw
root@estel #

(yes, that "udi" path sucks)


> /dev/cdrw*, /dev/dvd*, /dev/dvdrw*.  Fedora core 3 creates
> /dev/cdrom*, /dev/cdwriter*, /dev/dvd*, /dev/dvdwriter*.  I guess from
> your email that SuSE does /dev/cdrecorder*.  And I'm not able to
> guess what fedora core 5, mandrake, debian, slackware and infinite
> number of derivatives do.

Although that sucks, IMO the whole point of udev/hal & friends is to
be able to make programs work regardless of what the name of the device
is (or at least, if I had to use a program, I would like that the program
design is good enought that it just ask the system what cd recorders are
connected to the system).
