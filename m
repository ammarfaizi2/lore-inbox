Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbUKDWzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbUKDWzF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbUKDWvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:51:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:38286 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262473AbUKDWuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:50:55 -0500
Date: Thu, 4 Nov 2004 14:50:28 -0800
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, cohuck@de.ibm.com
Subject: Re: kernel BUG at fs/sysfs/dir.c:20!
Message-ID: <20041104225028.GA19575@kroah.com>
References: <20041104205238.GA11885@kroah.com> <20041104214414.GA2555@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104214414.GA2555@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 01:44:14PM -0800, Maneesh Soni wrote:
> On Thu, Nov 04, 2004 at 12:52:38PM -0800, Greg KH wrote:
> > Hi,
> > 
> > I get the following BUG in the sysfs code when I do:
> > 	- plug in a usb-serial device.
> > 	- open the port with 'cat /dev/ttyUSB0'
> > 	- unplug the device.
> > 	- stop the 'cat' process with control-C
> > 
> > This used to work just fine before your big sysfs changes.
> > 
> > Anything I should look at testing?
> > 
> 
> Hi Greg,
> 
> I was about to talk to you. There is a similar problem reported by
> s390 people where we see parent kobject (directory) going away before
> child kobject (sub-directory). It seems kobject code is able to handle
> this, but not the sysfs. What could be happening that in sysfs_remove_dir()
> of parent directory, we try to remove its contents. It works well with
> the regular files as it is the final removal for sysfs_dirent corresponding
> to the files. But in case of sub-directory we are doing an extra sysfs_put().
> Once while removing parent and the other one being the one from when 
> sysfs_remove_dir() is called for the child. 
> 
> The following patch worked for the s390 people, I hope same will work in
> this case also.
> 
> 
> o Do not remove sysfs_dirents corresponding to the sub-directory in 
>   sysfs_remove_dir(). They will be removed in the sysfs_remove_dir() call
>   for the specific sub-directory.

Nice, this fixes the BUG() for me.  I've applied it to my trees.

thanks for the quick response.

greg k-h
