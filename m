Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTIBSce (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbTIBSce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:32:34 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:40906 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S261159AbTIBScY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:32:24 -0400
Message-ID: <3F54A9F4.4020705@wmich.edu>
Date: Tue, 02 Sep 2003 10:32:20 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: devfs to be obsloted by udev?
References: <3F54A4AC.1020709@wmich.edu> <20030902182025.GA18397@kroah.com>
In-Reply-To: <20030902182025.GA18397@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Sep 02, 2003 at 10:09:48AM -0400, Ed Sweetman wrote:
> 
>>It appears that devfs is to be replaced by the use of udev in the not so 
>>distant future.
> 
> 
> Possibly.  There are some things that udev can not do that only devfs in
> the kernel can do.  For those who need those things, devfs will be
> required.
> 
> I'm just offering people a choice :)
> 
> 
>>I'm not sure how it's supposed to replace a static /dev situaton
>>seeing as how it is a userspace daemon.  Is it not supposed to replace
>>/dev even when it's completed?
> 
> 
> Yes.
> 
> Think of a userspace daemon using mknod and rm to manage device nodes
> dynamically.
> 
> 
>>I dont see the real benefit in having two directories that basically
>>give the same info.
> 
> 
> What "two directories"?  udev can handle /dev.  What other directory are
> you talking about?

in your readme you  use the example of making the device root for udev 
/udev ... I thought that was the official suggestion since udev couldn't 
be loaded immediately at kernel boot.


> 
>>Right now we have something like that with proc and sysfs although not
>>everything in proc makes sense to be in sysfs and both are virtual
>>fs's where as /dev is a static fs on the disk that takes up space and
>>inodes and includes way too many files that a system may not use.
> 
> 
> Then delete your /dev and use udev to manage it.
> 
> Well, don't do that today, we aren't quite yet there :)
> 
> 
>>If udev is to take over the job of devfs, how will modules and drivers
>>work that require device files to be present in order to work since
>>undoubtedly the udev daemon will have to wait until the kernel is done
>>booting before being run.
> 
> 
> udev can run out of initramfs which is uncompressed before any busses
> are probed.
> 
> For more details, please read my OLS 2003 paper about udev.

Will do.  The initramfs is an interesting method, i'll have to check 
that out too.


> 
>>I'm just not following how it is going to replace devfs and thus why 
>>devfs is being abandoned as mentioned in akpm's patchset. Or as it 
>>seems, already has been abandoned.
> 
> 
> The devfs code base has been abandoned by its original
> author/maintainer.  udev has nothing to do with that.
> 
> Hope this helps,
> 
> greg k-h
> 

i didn't think udev was responsible for the lack of development, I 
assumed that was due to the lack of devfs adoption in the main stream.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Greg KH wrote:
> On Tue, Sep 02, 2003 at 10:09:48AM -0400, Ed Sweetman wrote:
> 
>>It appears that devfs is to be replaced by the use of udev in the not so 
>>distant future.
> 
> 
> Possibly.  There are some things that udev can not do that only devfs in
> the kernel can do.  For those who need those things, devfs will be
> required.
> 
> I'm just offering people a choice :)
> 
> 
>>I'm not sure how it's supposed to replace a static /dev situaton
>>seeing as how it is a userspace daemon.  Is it not supposed to replace
>>/dev even when it's completed?
> 
> 
> Yes.
> 
> Think of a userspace daemon using mknod and rm to manage device nodes
> dynamically.
> 
> 
>>I dont see the real benefit in having two directories that basically
>>give the same info.
> 
> 
> What "two directories"?  udev can handle /dev.  What other directory are
> you talking about?

in your readme you  use the example of making the device root for udev 
/udev ... I thought that was the official suggestion since udev couldn't 
be loaded immediately at kernel boot.


> 
>>Right now we have something like that with proc and sysfs although not
>>everything in proc makes sense to be in sysfs and both are virtual
>>fs's where as /dev is a static fs on the disk that takes up space and
>>inodes and includes way too many files that a system may not use.
> 
> 
> Then delete your /dev and use udev to manage it.
> 
> Well, don't do that today, we aren't quite yet there :)
> 
> 
>>If udev is to take over the job of devfs, how will modules and drivers
>>work that require device files to be present in order to work since
>>undoubtedly the udev daemon will have to wait until the kernel is done
>>booting before being run.
> 
> 
> udev can run out of initramfs which is uncompressed before any busses
> are probed.
> 
> For more details, please read my OLS 2003 paper about udev.

Will do.  The initramfs is an interesting method, i'll have to check 
that out too.


> 
>>I'm just not following how it is going to replace devfs and thus why 
>>devfs is being abandoned as mentioned in akpm's patchset. Or as it 
>>seems, already has been abandoned.
> 
> 
> The devfs code base has been abandoned by its original
> author/maintainer.  udev has nothing to do with that.
> 
> Hope this helps,
> 
> greg k-h
> 

i didn't think udev was responsible for the lack of development, I 
assumed that was due to the lack of devfs adoption in the main stream.

