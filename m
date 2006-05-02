Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWEBQ7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWEBQ7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWEBQ7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:59:07 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:39620 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964927AbWEBQ7H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:59:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eP4+et4vv8deqGu/8QYz/PQGOs7y/96X3OGmaB5MiVB4NndQv7ICAjVvoxq8Xt9Zx43Xa2yQJr8XPSCblvUJq8dOGnPlow8uqd1Q8rFxB9BZHLU/CfapAxe8Derzx8XMgdDL7XywX/XMkgyPndUuA04rJBnIj5EiWxwI12eGgGE=
Message-ID: <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com>
Date: Tue, 2 May 2006 12:59:06 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, airlied@linux.ie, pjones@redhat.com,
       akpm@osdl.org
In-Reply-To: <44578C92.1070403@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <9e4733910605020938h6a9829c0vc70dac326c0cdf46@mail.gmail.com>
	 <44578C92.1070403@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> > An alternate way to fix this problem is to write a device driver that
> > attaches to hardware with PCI class VGA.
>
> and then that sucks too because in linux only 1 driver can bind to a device,
> AND you're limited to only vga devices.
>

There are many other ways to solve this problem. There are two rules
that need to be followed.
1) One driver per device
2) Stop mucking with hardware without having a driver loaded.

There are many other solutions to this problem that follow the Linux
driver model. For example build skeleton fbdev drivers for all of the
VGA device PCI IDs (they are enumerated in the X code). These drivers
can just be empty fbdev drivers, the fbdev core will supply the
open/enable logic. DRM already knows how to coordinate with fbdev so
that there aren't multiple drivers binding to the hardware.

You could do the generic VGA class binding after all of the other
drivers are loaded. And only bind to the free devices.

We could modify the driver system to allow a PCI class binding and a
device specific binding. The device specific binding would override
the class binding.

All of these have been proposed before. In my opinion an 'enable'
attribute is the worst solution in the bunch.

--
Jon Smirl
jonsmirl@gmail.com
