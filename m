Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030460AbVJFA3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbVJFA3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 20:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbVJFA3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 20:29:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:23183 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030460AbVJFA3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 20:29:51 -0400
Date: Wed, 5 Oct 2005 17:29:31 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [PATCH] nesting class_device in sysfs to solve world peace
Message-ID: <20051006002931.GA4854@suse.de>
References: <20050928233114.GA27227@suse.de> <200509300032.50408.dtor_core@ameritech.net> <20051006000951.GA4411@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006000951.GA4411@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 05:09:51PM -0700, Greg KH wrote:
> Here's what sysfs looks like on this box with the patch below:
> 
> $ tree /sys/class/input_dev/ -d
> /sys/class/input_dev/
> |-- input0
> |   |-- capabilities
> |   `-- id
> |-- input1
> |   |-- capabilities
> |   |-- device -> ../../../devices/platform/i8042/serio1
> |   `-- id
> `-- input2
>     |-- capabilities
>     |-- device -> ../../../devices/pci0000:00/0000:00:1d.0/usb1/1-2/1-2:1.0
>     |-- id
>     `-- mouse0
>         `-- device -> ../../../../devices/pci0000:00/0000:00:1d.0/usb1/1-2/1-2:1.0

And here it is with all input devices converted over.  Just rename
input_dev to "input" and we are home free...

$ tree -d /sys/class/input_dev/
/sys/class/input_dev/
|-- input0
|   |-- capabilities
|   |-- event0
|   `-- id
|-- input1
|   |-- capabilities
|   |-- device -> ../../../devices/platform/i8042/serio1
|   |-- event1
|   |   `-- device -> ../../../../devices/platform/i8042/serio1
|   `-- id
|-- input2
|   |-- capabilities
|   |-- device -> ../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
|   |-- event2
|   |   `-- device -> ../../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
|   |-- id                      
|   |-- mouse0                  
|   |   `-- device -> ../../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
|   `-- ts0                     
|       `-- device -> ../../../../devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0
`-- mice                        


thanks,

greg k-h
