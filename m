Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318894AbSHSNzL>; Mon, 19 Aug 2002 09:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318893AbSHSNzL>; Mon, 19 Aug 2002 09:55:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43268 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318894AbSHSNzK>; Mon, 19 Aug 2002 09:55:10 -0400
Message-ID: <3D60F9A6.6020304@zytor.com>
Date: Mon, 19 Aug 2002 06:59:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: klibc and logging
References: <3D58B14A.5080500@zytor.com> <20020819142734.B17471@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Tue, Aug 13, 2002 at 12:12:10AM -0700, H. Peter Anvin wrote:
> 
>>However, I'm wondering what to do about logging.
> 
> 
> While writing my scripts for initramfs, the following thought occurred:
> 
> 1. We only need the fd for initramfs.
> 2. We want to log the output from commands executed in initramfs.
> 
> Currently with an initrd, we set fd 0, 1, 2 to point to /dev/console.
> Is there any reason we couldn't set fd 0 to /dev/console (maybe from
> inside initramfs) but always setup fd 1 and 2 from the kernel to point
> at a special "translate this into printk" fd ?
> 
> This has several advantages:
> 
> 1. No need for another "special" device.
> 2. Once the fd is closed, its gone for good - no security concerns with
>    apps in userland after boot dumping copious amounts of data into the
>    kernel message buffer.
> 3. initramfs programs/scripts don't need to be aware of any special
>    logging facilities
> 
> The disadvantages:
> 
> 1. We need some way to open fd 1 and 2 in the first place; this is
>    likely to be a special case, and initramfs is supposed to remove
>    special cases from the kernel.
> 

I really think this is a bad idea.  The kmsg device has different 
properties -- for example, you're supposed to tag things with the 
message importance.  It really matches the syslog(3) interface better. 
Also, the special case makes me nervous.

The "DoS opportunity" is a complete and utter red herring.  If you have 
permission to write /dev/kmsg then you have permission to write 
/dev/kmem too!

	-hpa

