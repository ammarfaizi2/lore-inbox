Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTIPR4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTIPR4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:56:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:40136 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261970AbTIPR4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:56:13 -0400
Date: Tue, 16 Sep 2003 10:46:51 -0700
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.0-test5] fix oopses is kobject parent is removed before child
Message-ID: <20030916174651.GC3893@kroah.com>
References: <200309141737.04358.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309141737.04358.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 05:37:04PM +0400, Andrey Borzenkov wrote:
> It is possible that parent is removed before child when child is in use. 
> Trivial example is mounted USB storage when you unplug it. The kobject for 
> USB device is removed but subordinate SCSI device remains. Then kernel oopses 
> on attempt to release child e.g. umount removed USB storage. This patch fixes 
> two problems:
> 
> - kset_hotplug. It oopses in get_kobj_path_length because child->parent points 
> to nowhere - even if parent has not yet been overwritten, its name is already 
> freed. Common oops I get is

No, the scsi code should be fixed to prevent this from happening.  This
used to happen in the past, but I thought the scsi people fixed it up.
The SCSI code should grab a reference on the parent device which will
prevent it from going away until the SCSI device does, preventing all of
these oopes.

thanks,

greg k-h
