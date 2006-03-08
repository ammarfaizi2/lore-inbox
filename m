Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWCHJEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWCHJEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWCHJEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:04:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9147 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750946AbWCHJEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:04:06 -0500
Date: Wed, 8 Mar 2006 01:02:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: maneesh@in.ibm.com, linux-kernel@vger.kernel.org,
       mochel@digitalimplant.org
Subject: Re: problem with duplicate sysfs directories and files
Message-Id: <20060308010205.7e989a5a.akpm@osdl.org>
In-Reply-To: <20060308075342.GA17718@kroah.com>
References: <20060308075342.GA17718@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> Hi,
> 
> I spent some time tonight trying to track down how to fix the issue of
> duplicate sysfs files and/or directories.  This happens when you try to
> create a kobject with the same name in the same directory.  The creation
> of the second kobject will fail, but the directory will remain in sysfs.
> 
> Now I know this isn't a normal operation, but it would be good to fix
> this eventually.  I traced the issue down to fs/sysfs/dir.c:create_dir()
> and the check for:
> 	if (error && (error != -EEXIST)) {
> 
> Problem is, error is set to -EEXIST, so we don't clean up properly.  Now
> I know we can't just not check for this, as if you do that error
> cleanup, the original kobject's sysfs entry gets very messed up (ls -l
> does not like it at all...)
> 
> But I can't seem to figure out what exactly we need to do to clean up
> properly here.
> 
> Do you, or anyone else, have any pointers or ideas?
> 

Emit a loud warning and don't bother cleaning up - leave the current
behaviour as-is.  Whatever takes the least amount code and has the minimum
end-user impact, IMO.

