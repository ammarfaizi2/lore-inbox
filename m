Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbTKIBHV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 20:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTKIBHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 20:07:21 -0500
Received: from mail.kroah.org ([65.200.24.183]:10173 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261982AbTKIBHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 20:07:20 -0500
Date: Sat, 8 Nov 2003 14:25:29 -0800
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Accessing device information in REMOVE agent
Message-ID: <20031108222529.GB7671@kroah.com>
References: <200311081602.25978.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311081602.25978.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 08, 2003 at 04:02:25PM +0300, Andrey Borzenkov wrote:
> I'd like to be notified when block device goes away (e.g. USB stick unplugged) 
> basically to look if device is in use and possibly initiate clean up. Block 
> hotplug currently is passing only DEVPATH; but it alone is not reliable way 
> to identify it; device may be used under alias names via symbolic links.

What do you mean?  DEVPATH is unique for that point in time.  There are
no alias's in sysfs.

> Is it safe to access /sys/$DEVPATH in REMOVE agent? Apparently hotplug is 
> called asynchronously i.e. it is possible that /sys entry is already removed?

The /sys entry is probably already removed, but if not, it will
disappear any second.  So no, it's not safe to try to access it, as it
will not work.

> Would it make sense to add device number? It seems to be natural native "block 
> device ID" :)

What "device number"?  The major/minor?  Why?  It's about as unique as
DEVPATH is for any point in time.

thanks,

greg k-h
