Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315898AbSEGTCW>; Tue, 7 May 2002 15:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315952AbSEGTCV>; Tue, 7 May 2002 15:02:21 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:11524 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315898AbSEGTCU>;
	Tue, 7 May 2002 15:02:20 -0400
Date: Tue, 7 May 2002 11:02:37 -0700
From: Greg KH <greg@kroah.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020507180237.GA1396@kroah.com>
In-Reply-To: <20020507171946.29430@mailhost.mipsys.com> <Pine.LNX.4.33.0205071053070.6307-100000@segfault.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 09 Apr 2002 16:52:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 11:29:10AM -0700, Patrick Mochel wrote:
> 
> Which gives you a default name for the device. With /sbin/hotplug, simple 
> userspace policy, and symlinks in /dev, you can emulate the current device 
> hierarchy. So, you get a device naming solution that gives you only the 
> device names for the devices you have. 
> 
> This approach also de-emphasizes the dependency on major and minor 
> numbers. If device nodes are created in kernel space initially, userspace 
> doesn't need to know what the major/minor is for a particular device. The 
> symlink to the device node is all that's need to operate on the device. 
> 
> Without the need to coordinate between kernel and userspace, at least some 
> majors/minors can be dynamically allocated as the subsystems and devices 
> are registered with the core. (These can then be exported via files in 
> driverfs). (This is similar to the dynamic allocation of minor numbers in 
> the USB subsystem that showed up recently...)

And is exactly why this showed up in the USB subsystem :)

> Oh, and it's with a modern, clean filesystem, 1/5 the size of devfs. 

And it removes the dependency of devfsd and its interface, replacing it
with the existing /sbin/hotplug interface.  This allows different people
to implement different naming schemes if they so desire, moving naming
policy out of the kernel into userspace, where it belongs.

Yes, there will probably be a "default" naming scheme, matching what we
have today, but the ability to replace it with another one is _so_ much
easier than having to try to tie into devfsd (like the devreg
implementation does: http://www-124.ibm.com/devreg/ )


greg k-h
