Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289849AbSBOPC3>; Fri, 15 Feb 2002 10:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289844AbSBOPCU>; Fri, 15 Feb 2002 10:02:20 -0500
Received: from zeke.inet.com ([199.171.211.198]:62442 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S289832AbSBOPCL>;
	Fri, 15 Feb 2002 10:02:11 -0500
Message-ID: <3C6D22E2.F708A646@inet.com>
Date: Fri, 15 Feb 2002 09:01:54 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: copy_from_user returns a positive value?
In-Reply-To: <3C6C6E0C.6000309@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> 
> I have an IOCTL defined something like this:
> 
>         _IOWR (0xfe, (30<<3 + 0), __u8 [696])
> 
> I'm really passing in a structure of size 696 (does that matter)?
> 
> When I make the copy from user call:
> 
>        if ((ret = copy_from_user(&reqconf, arg, sizeof(reqconf)))) {
>           printk("ERROR: copy_from_user returned: %i, sizeof(reqconf): %i\n",
>                  ret, sizeof(reqconf));
>           return ret;
>        }
> 
> I see this printed out:
> 
> ERROR: copy_from_user returned: 696, sizeof(reqconf): 696
> 
> According to some docs I saw on the web, it should return 0, or the
> number it has left to copy.  So, why does it have 696 bytes left
> to copy??

Because it couldn't copy any of the data?  The code I have seen
generally returns -EFAULT in that case.
Could you be trying to copy data from somewhere that the user does not
have permission to read? Can you verify that both pointers are valid? 
&reqconf should be in the kernel's memory space and arg should be a
pointer provided by the user-space app pointing to memory in userland.

You might want to get the Linux Device Drivers book... the 2nd ed. is
out.

HTH,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------
