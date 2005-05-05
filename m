Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVEENNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVEENNv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 09:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVEENNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 09:13:51 -0400
Received: from alog0047.analogic.com ([208.224.220.62]:38880 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262096AbVEENNs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 09:13:48 -0400
Date: Thu, 5 May 2005 09:13:34 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: linux <kernel@wired-net.gr>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: copy_to_user question
In-Reply-To: <001d01c5516f$b5f37c20$0101010a@dioxide>
Message-ID: <Pine.LNX.4.61.0505050909440.25004@chaos.analogic.com>
References: <20050425165826.GB11938@redhat.com> <20050429040104.GB9900@redhat.com>
 <1114815509.18352.200.camel@ibm-c.pdx.osdl.net> <200504300509.24887.phillips@istop.com>
 <1115295930.1988.229.camel@sisko.sctweedie.blueyonder.co.uk>
 <001d01c5516f$b5f37c20$0101010a@dioxide>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2005, linux wrote:

> Hi all, i have a question about copy_to_user function.
> I have a module which declares a struct test { int size; char *name; int
> value_add };
> I like to transfer that struct to userspace through an ioctl command like
> that:
>
> struct test test_struct;
> memset(&test_struct,0,sizeof(test_struct);
> test_struct.size= 100;
> test_struct.name = "test name";
> test_struct.value_add = 2;
> copy_to_user((void __user *)arg,&test_struct,sizeof(struct test));
>
>
> When i use the ioctl command in user-space and try to get the name item a
> segfault occurs.Can u tell me why??
> Can we transfer from kernel-space to user-space pointers like the one i use
> or this is a fault approach???
>
>
> Best regards,
> Chris.

Accessing a kernel pointer from user-space isn't going to work.
But you can transfer data to/from user-space/kernel-space so
just don't use a pointer, do...

struct test struct {
      char name[BIG_ENOUGN];
      int size;
      ....
      };


Write your strings to the name[] buffer-member and everybody is happy.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
