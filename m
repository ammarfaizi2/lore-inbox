Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269803AbUJGLup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269803AbUJGLup (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 07:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269804AbUJGLup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 07:50:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:56966 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269803AbUJGLun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 07:50:43 -0400
Date: Thu, 7 Oct 2004 07:50:03 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stephen Hemminger <shemminger@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Probable module bug in linux-2.6.5-1.358
In-Reply-To: <1097104924.26149.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0410070747160.9988@chaos.analogic.com>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
 <1097104924.26149.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004, Stephen Hemminger wrote:

> On Wed, 2004-10-06 at 18:08 -0400, Richard B. Johnson wrote:
>> The attached script shows that an attempt to open a device
>> after its module was removed, will seg-fault the kernel.
>>
>> Cheers,
>> Dick Johnson
>> Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
>>              Note 96.31% of all statistics are fiction.
>
>
>
> Oct  6 17:03:30 chaos kernel: Analogic Corp Datalink Driver : Module
> removed
>
> The bug is in that driver. It needs to unregister the character device
> in it's module remove routine.  It doesn't appear to be in the main
> kernel source tree so bug Redhat or the vendor.
>


It certainly does unregister the device.........

     if((ret =  unregister_chrdev(MAJOR_NR, devname)) < 0)
     {
         printk(KERN_ALERT"%s : Can't unregister major number %d (%d)\n",
                                devname, MAJOR_NR, ret);
         return;
     }
     free_resources();
     printk(KERN_INFO"%s : Module removed\n", devname);
}

.... and this works fine in 2.4.x




Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

