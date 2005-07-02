Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVGBX2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVGBX2K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 19:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVGBX2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 19:28:09 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:8322 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261326AbVGBX1z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 19:27:55 -0400
Message-ID: <42C722F9.8060809@free.fr>
Date: Sun, 03 Jul 2005 01:27:53 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       dmitry.torokhov@gmail.com
Subject: Re: device_remove_file and disconnect
References: <42C2D354.6060607@free.fr> <20050629184621.GA28447@kroah.com> <42C301F7.4010309@free.fr> <20050629224235.GC18462@kroah.com> <20050630072643.GA14703@mut38-1-82-67-62-65.fbx.proxad.net> <20050630170406.GA11334@kroah.com> <42C456B0.6010706@free.fr>
In-Reply-To: <42C456B0.6010706@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
matthieu castet wrote:
>>
>>
>> Then they should be fixed.  Any specific examples?
>>
>>
> I am a little lasy to list all, but some drivers in driver/usb should 
> have this problem : the first driver I look : ./misc/phidgetkit.c do 
> [1]. So sysfs read don't check if to_usb_interface or usb_get_intfdata 
> return NULL pointer...
> And it is a bit your fault, as many developper should have read your 
> great tutorial [2] ;)
> 
>>> Also I always see driver free their privatre data in device disconnect,
>>> so if read/write from sysfs aren't serialized with device disconnect
>>> there are still a possible race like I show in my example.
>>
>>
>>
>> Yes, you are correct.  Again, any specific drivers you see with this
>> problem?
> 
> I believe near all drivers that use sysfs via device_create_file, as I 
> never see them use mutex in read/write in order to check there aren't in 
> the same time in their disconnect that could free there private data 
> when they do operation on it...
> 
> 
> Couldn't be possible the make device_remove_file blocking until all the 
> open file are closed ?
> 
> thanks,
> 
> Matthieu
> 
> [1]
> #define show_input(value)       \
> static ssize_t show_input##value(struct device *dev, char *buf) \
> {                                                                       \
>         struct usb_interface *intf = to_usb_interface(dev);             \
>         struct phidget_interfacekit *kit = usb_get_intfdata(intf);      \
>                                                                         \
>         return sprintf(buf, "%d\n", kit->inputs[value - 1]);            \
> }                                                                       \
> static DEVICE_ATTR(input##value, S_IRUGO, show_input##value, NULL);
> 
> [2] http://www.linuxjournal.com/article/7353
> 

So will there be a fix in the kernel, or all this driver are broken and 
should be fixed ?

thanks

Matthieu
