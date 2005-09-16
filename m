Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161216AbVIPR6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbVIPR6h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbVIPR6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:58:37 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:51659 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161216AbVIPR6h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:58:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tnYSXOII+CF6mXEBT3JnuR+wTdEU9spqXrDZ6RaoH0hooeSiJiCskAjJ1FZw/gKz9aDHJmqqFIhAhJ1sqGgsRazoWNj9mINuNwDA4NwuL4f4C+eqx0a1N9jyqR2xn/m3BTgDZlJtwoZ+gZyu+9BjxBPWRpMnafBdYBnoXa09vHI=
Message-ID: <1e62d137050916105843147c93@mail.gmail.com>
Date: Fri, 16 Sep 2005 22:58:36 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: fawadlateef@gmail.com
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Unusually long delay in the kernel
Cc: Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0509161236440.4523-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.44L0.0509161236440.4523-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/05, Alan Stern <stern@rowland.harvard.edu> wrote:
> This code excerpt is taken from the start of the control thread for the
> usb-storage driver in 2.6.14-rc1:
> 
> 
> static int usb_stor_control_thread(void * __us)
> {
>         struct us_data *us = (struct us_data *)__us;
>         struct Scsi_Host *host = us_to_host(us);
> 
> printk(KERN_INFO "Before thread start\n");
>         lock_kernel();
> 
>         /*
>          * This thread doesn't need any user-level access,
>          * so get rid of all our resources.
>          */
>         daemonize("usb-storage");
>         current->flags |= PF_NOFREEZE;
>         unlock_kernel();
> printk(KERN_INFO "After thread start\n");
> 
> 
> The code between the two printk's takes a long time to run.  I don't have
> precise numbers, but it feels like more than 1 second.
> 
> (1) Can anyone explain why, or indicate how to speed it up?
> 
> (2) Are the {un}lock_kernel calls really needed?
> 

AFAIR the article on the lwn.net in the driver porting porting to 2.6
kernel mentioned that big kernel locks lock_kernel and unlock_kernel
gone, but as I searched into the kernel's drivers directory for the
kernel_thread functions (drivers creating threads), I found some of
them using lock_kernel and some not .... So I also wants to know are
they really needed ??

By the way I havn't saw/felt any long delay when starting thread in
this way using lock_kernel !!!!


-- 
Fawad Lateef
