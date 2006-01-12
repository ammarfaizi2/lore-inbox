Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWALMyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWALMyv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 07:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWALMyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 07:54:51 -0500
Received: from cantor2.suse.de ([195.135.220.15]:59366 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964912AbWALMyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 07:54:50 -0500
Message-ID: <43C65196.8040402@suse.de>
Date: Thu, 12 Jan 2006 13:54:46 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com> <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com> <43C5B59C.8050908@us.ibm.com>
In-Reply-To: <43C5B59C.8050908@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Hi,

>> Huh?  You can't just throw a "MODULE_VERSION()", and a module_init()
>> somewhere into the xen code to get this to happen?  Then all of your
>> configurable paramaters show up automagically.
> 
> No, I can't. Xen does not have modules. Xen loads and runs linux.

You can.  Just look at a recent drivers/xen/blkback/blkback.c, the 
module parameters specified there show up in 
/sys/module/blkback/parameters, no matter whenever the code was built 
statically into the kernel or as module (which curently doesn't work for 
blkback anyway ...).

Any read-only attributes can trivially be implemented that way.  Simple 
writable stuff (balloon driver?) probably too, I don't know whenever a 
notify callback on parameter changes is possible though.

The current /proc files which are not simple attributes such as 
/proc/xen/{privcmd,xenbus} are a bit more tricky, not sure what the best 
approach for these is.  privcmd returns a filehandle which is then used 
for ioctls (misc char dev maybe?).  xenbus can be opened and (I think) 
read(2) on to listen for any xenbus activity, much like /proc/kmsg. 
Suggestions what to use here instead of procfs?  Or just leave it there?

cheers,

   Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
