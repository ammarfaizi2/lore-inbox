Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWAYRLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWAYRLA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWAYRLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:11:00 -0500
Received: from webmail.terra.es ([213.4.149.12]:23867 "EHLO
	csmtpout4.frontal.correo") by vger.kernel.org with ESMTP
	id S932075AbWAYRK7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:10:59 -0500
Date: Wed, 25 Jan 2006 18:10:48 +0100 (added by postmaster@terra.es)
From: are added/removed - which <grundig@teleline.es>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: axboe@suse.de, acahalan@gmail.com, linux-kernel@vger.kernel.org,
       rlrevell@joe-job.com, schilling@fokus.fraunhofer.de,
       matthias.andree@gmx.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060125180937.93bacfcb.grundig@teleline.es>
In-Reply-To: <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
	<Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
	<20060125144543.GY4212@suse.de>
	<Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 25 Jan 2006 16:13:46 +0100 (MET),
Jan Engelhardt <jengelh@linux01.gwdg.de> escribió:

> There's one kind of not-so-advanced linux newbies that just go to walmart, 
> buy a computer and whack a linux system on it for fun, and they still don't 
> know if their cdrom is at /dev/hdb or /dev/hdc. Looking for dmesg is 
> usually a nightmare for them, and apart that -scanbus lists scsi 
> host,id,lun instead of /dev/hd* (don't comment on this kthx), it is 
> convenient for this sort of users to find out what's available.

Wait - Looking at dmesg is a nightmare for newbies, but cdrecord -scanbus
is not?

Users should be show the available devices in a pretty GUI and for that to
be possible, the kernel needs to provide a unified way to show userspace
the available devices and notify them when they are added/removed - which
happens to be sysfs + udev etc.

libscg seems to want to replace the operative system for some tasks
in the name of cross-platform compatibility. Sorry, but libscg is
not the center of the world. It's fine that cdrecord does what
it does for the apps for all those platforms where -scanbus and friends
has sense, but linux just has SG_IO. libscg wanting to offer access
to the "transport layer below /dev/hd*" looks like a  layering design
violation in operative systems like linux, but it is fine that cdrecord
has it because it _is_ neccesary in other operative system which do
things differently. 

Using the native features of a platform is a Good Thing when writing
cross-platform software, ie: glib provides a "threading emulation" where
threads are not available, but it uses the native pthreads if it's
available. libscg wants to do everything everywhere, and that'd have
sense if SG_IO weren't able to do what cdrecord needs, but AFAIK from the
multiple flamewars I've seen, SG_IO does everything that cdrecord
needs. I've not had a problem with SG_IO in years...
