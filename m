Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264541AbTCYVVk>; Tue, 25 Mar 2003 16:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264542AbTCYVVk>; Tue, 25 Mar 2003 16:21:40 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:45586 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264541AbTCYVVh>;
	Tue, 25 Mar 2003 16:21:37 -0500
Date: Tue, 25 Mar 2003 13:32:06 -0800
From: Greg KH <greg@kroah.com>
To: Deepak Saxena <dsaxena@mvista.com>
Cc: Jan Dittmer <j.dittmer@portrix.net>, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: add eeprom i2c driver
Message-ID: <20030325213206.GD17249@kroah.com>
References: <3E806AC6.30503@portrix.net> <20030325172024.GC15823@kroah.com> <20030325212753.GA21498@xanadu.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325212753.GA21498@xanadu.az.mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 02:27:53PM -0700, Deepak Saxena wrote:
> On Mar 25 2003, at 09:20, Greg KH was caught saying:
> > On Tue, Mar 25, 2003 at 03:42:14PM +0100, Jan Dittmer wrote:
> > > This adds support for reading eeproms.
> > > Tested against latest bk changes with i2c-isa.
> > 
> > I'd like to hold off in submitting the i2c chip drivers just yet, due to
> > the changes for sysfs that are going to be needed for these drivers.
> > 
> > As an example of the changes necessary, here's a patch against the i2c
> > cvs version of the eeprom.c driver that converts it over to use sysfs,
> > instead of the /proc and sysctl interface.  It's still a bit rough, but
> > you should get the idea of where I'm wanting to go with this.  As you
> > can see, it takes about 100 lines of code off of this driver, which is
> > nice.
> > 
> > I'm copying the sensors list too, as they wanted to see how this was
> > going to be done.
> > 
> > Comments?
> 
> I would like to suggest completely re-writing the user interface to the 
> EEPROM device.  As an applications programmer, I should not have to 
> open a separate sysfs file for each 16 bytes in the EEPROM. I should be 
> able to open a single file and perform read/write/llseek operations 
> on the file descriptor. I don't think that the actual data of the EEPROM 
> device is something that belongs in sysfs, just as the data on a hard drive
> or from a serial port is not read through their sysfs counterparts.

Ok, in finding out a bit more of what the EEPROM driver is trying to do,
it looks like it qualifies for the "binary file in sysfs" exception.
It's just exporting a binary blob of data that exists in hardware
through the kernel to userspace, for userspace to do with it what it
wants to.

I'll work on converting the driver to that interface later tonight,
unless someone beats me to it :)

> Furthermore, I think that checksum data is not something that should be 
> in the kernel, but in the application that is using it.  An application can 
> open() /dev/eepromX (/dev/nvramX maybe?) and read the data and ensure that
> the checksum is OK.  Not all applications will have the same checksum
> mechanism, location, etc.  
> 
> From my experience in seeing I2C eeproms on embedded systems, most 
> people end up writing a custom little driver that does just what I 
> said above: read/write/llseek. The eeprom driver should export the data
> for each eeprom through /dev/eeprom interfaces This also allows for someone
> to add a driver for larger EEPROMs (I have 512byte eeproms on some embedded 
> boards) w/o having to add even more entries to sysfs for the remaining data.

I think the "one binary file" will work for all of your varied systems,
right?

thanks,

greg k-h
