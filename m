Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbULTWuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbULTWuT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 17:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbULTWuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 17:50:07 -0500
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:4357 "EHLO
	smtp-vbr13.xs4all.nl") by vger.kernel.org with ESMTP
	id S261671AbULTWsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 17:48:42 -0500
Message-ID: <41C756CA.5080504@xs4all.nl>
Date: Mon, 20 Dec 2004 23:48:42 +0100
From: Pjotr Kourzanov <peter.kourzanov@xs4all.nl>
Organization: Appose.org
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ioctl assignment strategy?
References: <1103067067.2826.92.camel@chatsworth.hootons.org> <20041215004620.GA15850@kroah.com> <41C04FFA.6010407@nortelnetworks.com> <20041217234854.GA24506@kroah.com> <41C70DF2.80101@nortelnetworks.com>
In-Reply-To: <41C70DF2.80101@nortelnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Greg KH wrote:
> 
>> Rethink the way you want to control your device.  Seriously, a lot of
>> ioctls can be broken down into single device files, single sysfs files,
>> or other such things (a whole new fs as a last resort too.)
> 
> 
> Actually, my particular case is likely not a good example.  We've got a 
> misc char driver giving access to a lot of miscellaneous features we've 
> added to the kernel,.  We originally (a few years back) used new 
> syscalls, but then we started supporting a bunch more arches, and having 
> to patch all of them just to add syscall numbers sucked.
> 
> Some of it could easily be moved to /proc or /sys, but if you do it that 
> way, how do you handle returning unusual error values?  Other stuff 
> involves multiple stages of registration, then getting handles returned, 
> and doing new calls with those handles.  I don't see how this would tie 
> nicely into the read/write paradigm.

   /That/ is exactly what FS API is good for: returning error values is 
done via read(/sys/mystuff/errno,&err,4), getting handles is done via 
open(/sys/mystuff/mycomp) and doing new calls is just calling FS API 
with the *file* handle. Registration, depending on your definition of it 
can be viewed as a link(/sys/mystuff/object,/sys/mystuff/subsystem) or 
as a write(/sys/mystuff/subsystem/registered,"object"). Take a peek into 
Plan9 from Bell Labs for inspiration...

> 
> What's the big problem with ioctls anyways?  I mean, in a closed 
> environment where I'm writing both the userspace and the kernelspace 
> side of things.
> 
> Chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

