Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289748AbSA2QY2>; Tue, 29 Jan 2002 11:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289741AbSA2QYU>; Tue, 29 Jan 2002 11:24:20 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:60178 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289748AbSA2QYJ>;
	Tue, 29 Jan 2002 11:24:09 -0500
Date: Tue, 29 Jan 2002 08:22:58 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@suse.cz>
Cc: mochel@osdl.org, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driverfs support for USB
Message-ID: <20020129162258.GC17837@kroah.com>
In-Reply-To: <20020125021435.GA22080@kroah.com> <20020128125204.A72@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020128125204.A72@toy.ucw.cz>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 01 Jan 2002 14:07:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2002 at 12:52:04PM +0000, Pavel Machek wrote:
> Hi!
> 
> > .
> >         |-- pci1
> >         |   |-- 01:08.0
> >         |   |   |-- power
> >         |   |   --- status
> >         |   |-- 01:0d.2
> >         |   |   |-- power
> >         |   |   --- status
> >         |   --- usb
> >         |       |-- 002
> >         |       |   |-- power
> >         |       |   --- status
> >         |       --- 003
> >         |           |-- power
> >         |           --- status
> 
> Should not usb bus hang off some pci device (uhci/ohci?)

You are correct, The "usb" device should hang off of the actual pci
device that is the USB host controller.  But due to the current split
between iobus and devices in the device core code, a usb bus has to
attach to the pci bus, which places it in the tree like you see here.

So to be correct the above portion of the tree should look something
like:
        |-- pci1
        |   |-- 01:08.0
        |   |   |-- power
        |   |   --- status
        |   |-- 01:0d.2
        |       |-- power
        |       |-- status
        |       --- usb
        |           |-- 002
        |               |-- power
        |               |-- status
        |               --- 003
        |                   |-- power
        |                   --- status


It's still a work in progress :)

thanks,

greg k-h
