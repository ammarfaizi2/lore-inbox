Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUASNIV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 08:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUASNIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 08:08:21 -0500
Received: from ns.suse.de ([195.135.220.2]:23187 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264881AbUASNIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 08:08:19 -0500
Date: Mon, 19 Jan 2004 14:08:17 +0100
From: Olaf Hering <olh@suse.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Greg KH <greg@kroah.com>, jw schultz <jw@pegasys.ws>,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Message-ID: <20040119130817.GA27953@suse.de>
References: <E19odOM-000NwL-00.arvidjaar-mail-ru@f22.mail.ru> <200308311453.00122.arvidjaar@mail.ru> <20030924211823.GA11234@kroah.com> <200401172334.13561.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200401172334.13561.arvidjaar@mail.ru>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Jan 17, Andrey Borzenkov wrote:

> > > Well, we did not move a tiny bit since the beginning of this thread :)
> > > You still did not show me namedev configuration that implements
> > > persistent name for a device based on its physical location :)))
> >
> > Ok, do you have any other ideas of how to do this?
> >
> 
> given current sysfs implementation - using wildcards remains the only 
> solution. I for now am using this trivial script:
> 
> pts/0}% cat /etc/udev/scripts/removables
> #!/usr/bin/perl
> 
> my $devpath, $base;
> 
> $base = $1 if ($ARGV[0] =~ /(.*\D)\d*$/);
> $devpath = readlink "/sys/block/$base/device";
> 
> if ($devpath =~ 
> m|/devices/pci0000:00/0000:00:1f.4/usb2/2-2/2-2.4/2-2.4:1.0/host\d+/\d+:0:0:0|) 
> {
>         print "flash0";
> } elsif ($devpath =~ 
> m|/devices/pci0000:00/0000:00:1f.4/usb2/2-2/2-2.1/2-2.1:1.0/host\d+/\d+:0:0:0|) 
> {
>         print "flash1";
> } elsif ($devpath =~ m|/devices/legacy/host\d+/\d+:0:4:0|) {
>         print "jaz";
> } else {
>         exit(1);
> }

I'm not sure what you are trying to do. Working with the 'physical
location' of removeable devices will probably fail. The usb-storage
devices here have a serial field, I really hope it is unique, use it.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
