Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVBCBTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVBCBTN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVBCBOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:14:36 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:29577 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262898AbVBCBNQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 20:13:16 -0500
Date: Wed, 2 Feb 2005 20:13:15 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@localhost.localdomain
To: Joseph Pingenot <trelane@digitasaru.net>
cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Please open sysfs symbols to proprietary modules
In-Reply-To: <20050203000917.GA12204@digitasaru.net>
Message-ID: <Pine.LNX.4.62.0502021950040.19812@localhost.localdomain>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
 <20050203000917.GA12204@digitasaru.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Joseph!

On Wed, 2 Feb 2005, Joseph Pingenot wrote:

>> From Pavel Roskin on Wednesday, 02 February, 2005:
>> All I want to do is to have a module that would create subdirectories for
>> some network interfaces under /sys/class/net/*/, which would contain
>> additional parameters for those interfaces.  I'm not creating a new
>> subsystem or anything like that.  sysctl is not good because the data is
>> interface specific.  ioctl on a socket would be OK, although it wouldn't
>> be easily scriptable.  The restriction on sysfs symbols would just force
>> me to write a proprietary userspace utility to set those parameters
>> instead of using a shell script.
>
> Please pardon my ignorance, but if the existing network device management
>  framework is insufficient, it seems that the optimal way to deal with
>  this is to work with the community to address the insufficiencies, not
>  hacking in a new interface to the device.

OK, then the "insufficiency" is inability to set and get additional named 
variables for network interfaces.

I won't open all details, but suppose I want the bridge to handle certain 
frames in a special way, just like BPDU frames are handled if STP is 
enabled.  There is a hook for that already - see br_handle_frame_hook. 
The proprietary module would just have to change it.

What I want it to tell that module what to do with those special frames. 
I also want to get information like what was in the last special frame and 
how many of them have been received.  In other words, I want the 
proprietary module to communicate with userspace.  Ideally, the userspace 
application should be a simple shell script, so I'm reluctant to use 
ioctl.

-- 
Regards,
Pavel Roskin
