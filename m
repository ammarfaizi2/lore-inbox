Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318880AbSHSNXe>; Mon, 19 Aug 2002 09:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318881AbSHSNXe>; Mon, 19 Aug 2002 09:23:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7439 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318880AbSHSNXd>; Mon, 19 Aug 2002 09:23:33 -0400
Date: Mon, 19 Aug 2002 14:27:34 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: klibc and logging
Message-ID: <20020819142734.B17471@flint.arm.linux.org.uk>
References: <3D58B14A.5080500@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D58B14A.5080500@zytor.com>; from hpa@zytor.com on Tue, Aug 13, 2002 at 12:12:10AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 12:12:10AM -0700, H. Peter Anvin wrote:
> However, I'm wondering what to do about logging.

While writing my scripts for initramfs, the following thought occurred:

1. We only need the fd for initramfs.
2. We want to log the output from commands executed in initramfs.

Currently with an initrd, we set fd 0, 1, 2 to point to /dev/console.
Is there any reason we couldn't set fd 0 to /dev/console (maybe from
inside initramfs) but always setup fd 1 and 2 from the kernel to point
at a special "translate this into printk" fd ?

This has several advantages:

1. No need for another "special" device.
2. Once the fd is closed, its gone for good - no security concerns with
   apps in userland after boot dumping copious amounts of data into the
   kernel message buffer.
3. initramfs programs/scripts don't need to be aware of any special
   logging facilities

The disadvantages:

1. We need some way to open fd 1 and 2 in the first place; this is
   likely to be a special case, and initramfs is supposed to remove
   special cases from the kernel.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

