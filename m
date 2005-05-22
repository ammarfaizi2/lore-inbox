Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVEVPvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVEVPvv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 11:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVEVPvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 11:51:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63498 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261819AbVEVPvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 11:51:08 -0400
Date: Sun, 22 May 2005 16:51:02 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Double 'block' link for floppy
Message-ID: <20050522165102.A25124@flint.arm.linux.org.uk>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20050521225454.B25980@flint.arm.linux.org.uk> <9a87484905052208336a50c658@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <9a87484905052208336a50c658@mail.gmail.com>; from jesper.juhl@gmail.com on Sun, May 22, 2005 at 05:33:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2005 at 05:33:55PM +0200, Jesper Juhl wrote:
> On 5/21/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > I'm seeing an oddity with floppy:
> > 
> > $ vdir /sys/devices/platform/floppy.0/
> > total 0
> > lrwxrwxrwx    1 root     root            0 May 21 22:43 block -> ../../../block/fd1
> > lrwxrwxrwx    1 root     root            0 May 21 22:43 block -> ../../../block/fd1
> > lrwxrwxrwx    1 root     root            0 May 21 22:43 bus -> ../../../bus/platform
> > -rw-r--r--    1 root     root         4096 May 21 22:43 detach_state
> > 
> > I suspect the first is actually supposed to be 'fd0' since:
> > 
> > $ vdir /sys/block/fd*/device
> > lrwxrwxrwx    1 root     root            0 May 21 22:52 /sys/block/fd0/device -> ../../devices/platform/floppy.0
> > lrwxrwxrwx    1 root     root            0 May 21 22:52 /sys/block/fd1/device -> ../../devices/platform/floppy.0
> > 
> 
> I just took a look here, and I don't see what you see : 

That'll be because your system is obviously configured for only one
floppy drive.  Configure it for two and see what happens.  (Naturally
the BIOS will complain if you don't actually have a second drive.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
