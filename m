Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752432AbWKAVPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbWKAVPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbWKAVPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:15:52 -0500
Received: from mail.gmx.de ([213.165.64.20]:2514 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752432AbWKAVPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:15:52 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <gregkh@suse.de>, "Martin J. Bligh" <mbligh@google.com>,
       Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
In-Reply-To: <20061101104853.4e5e6c64.akpm@osdl.org>
References: <45461977.3020201@shadowen.org> <45461E74.1040408@google.com>
	 <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com>
	 <45463481.80601@shadowen.org>
	 <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com>
	 <1162276206.5959.9.camel@Homer.simpson.net> <4546EF3B.1090503@google.com>
	 <20061031065912.GA13465@suse.de>
	 <1162278594.6416.4.camel@Homer.simpson.net> <20061031072241.GB7306@suse.de>
	 <1162312126.5918.12.camel@Homer.simpson.net>
	 <1162318477.6016.3.camel@Homer.simpson.net>
	 <1162356198.6105.18.camel@Homer.simpson.net>
	 <20061031212508.1b116655.akpm@osdl.org>
	 <1162361529.5899.1.camel@Homer.simpson.net>
	 <1162373184.6126.8.camel@Homer.simpson.net>
	 <20061101104853.4e5e6c64.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 22:15:42 +0100
Message-Id: <1162415742.5647.3.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 10:48 -0800, Andrew Morton wrote:

> So it's failing here:
> 
> static int device_add_class_symlinks(struct device *dev)
> {
> 	int error;
> 
> 	if (!dev->class)
> 		return 0;
> 	error = sysfs_create_link(&dev->kobj, &dev->class->subsys.kset.kobj,
> 				  "subsystem");
> 	if (error) {
> 		DB();
> 		goto out;
> 	}
> 	error = sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
> 				  dev->bus_id);
> 	if (error) {
> -->>		DB();
> 		goto out_subsys;
> 	}
> 
> 
> Now, prior to driver-core-fixes-sysfs_create_link-retval-checks-in.patch we
> were simply ignoring the return value of sysfs_create_link().  Now we're
> not ignoring it and stuff is failing.
> 
> I'm suspecting that the second call to sysfs_create_link() in device_add():
> 
> 
> 	if (dev->class) {
> 		sysfs_create_link(&dev->kobj, &dev->class->subsys.kset.kobj,
> 				  "subsystem");
> -->>		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
> 				  dev->bus_id);
> 
> is simply always failing, only we never knew about it.
> 
> It would be useful if you could tell us what `error' is in there.  Usually
> -EEXIST.

Yeah, they're all -EEXIST.

	-Mike

