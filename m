Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbTDKXVI (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbTDKXTv (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:19:51 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:57338 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S262478AbTDKXT3 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 19:19:29 -0400
Message-ID: <3E975063.9090807@mvista.com>
Date: Fri, 11 Apr 2003 16:31:47 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <3E9725C5.3090503@mvista.com> <20030411204329.GT1821@kroah.com> <3E9741FD.4080007@mvista.com> <20030411225634.GD3786@kroah.com>
In-Reply-To: <20030411225634.GD3786@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote:

>On Fri, Apr 11, 2003 at 03:30:21PM -0700, Steven Dake wrote:
>  
>
>>There is no "spec" that states this is a requirement, however, telecom 
>>customers require the elapsed time from the time they request the disk 
>>to be used, to the disk being usable by the operating system to be 20 msec.
>>    
>>
>
>What defines the term, "request the disk to be used"?  Slamming it into
>the SCSI tray?  Mounting the device on the command line?  I don't think
>you can spin up a scsi disk in 20msec today :)
>
I should have been more clear.

What I actually mean is:
disk is in the bus/loop/etc, powered on, ready to be enumerated.
The user then tells the OS "please insert the disk"  This is the request 
which starts the clock.
The point where a device entry is in /dev ready to be used stops the clock.

>
>  
>
>>Its even more helpful for their applications if the call that hotswap 
>>inserts blocks until the device is actually ready to use and available 
>>in the filesystem.
>>    
>>
>
>What would it block from happening?  The kernel?  Userspace?  I'm
>confused.
>  
>
An insert operation would block until the following sequence occurs:
insert a disk, disk added to subsystem (scsi, etc), hotplug event, 
hotplug handler creates device node.

Without blocking until the device is created and ready to be used, it 
becomes difficult to actually "hotswap insert" and then immediatly use 
the device, requiring polling.  Most users would like to wait for the 
event to complete, or have a select()able fd to wait on to know when the 
event has been completed.

This might be possible to emulate through dnotify, but would still 
require a rescan of the dev directory, causing poor performance.

>thanks,
>
>greg k-h
>
>
>
>  
>

