Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbSJUNFn>; Mon, 21 Oct 2002 09:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSJUNEr>; Mon, 21 Oct 2002 09:04:47 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:28327 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S261370AbSJUNEM>;
	Mon, 21 Oct 2002 09:04:12 -0400
Date: Mon, 21 Oct 2002 09:02:48 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: David Woodhouse <dwmw2@infradead.org>
cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: rtnetlink interface state monitoring problems.
In-Reply-To: <27964.1035199084@passion.cambridge.redhat.com>
Message-ID: <Pine.GSO.4.30.0210210852130.17911-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Oct 2002, David Woodhouse wrote:

> I'm playing with userspace applications which want to monitor the status of
> IrDA and Bluetooth devices. Rather than polling for the interface state
> (this is a handheld device and polling wastes CPU and battery), I want to
> use netlink.
>
> I have two problems:
>
>  1. I appear to need CAP_NET_ADMIN to bind to the netlink groups which give
> 	me this  information. I can poll for it just fine, but need
> 	elevated privs to be notified. Why is this, and is there a workaround?
>

Alexey should be able to give you a better comment.
If you can get the status via ioctl there should be no reason why you
shouldnt get it via netlink. The change maybe a little involved
(look at:net/netlink/af_netlink.c::netlink_bind()) since
there are some valid reasons to block non-admin from receiving certain
messages. I think the LSM people may have been trying to do this, cant
remember details.

>  2. Even root doesn't get notification of state changes for Bluetooth
> 	interfaces, because they're not treated as 'normal' network devices
> 	like IrDA devices are. I can see the logic behind that -- by why
> 	is it done differently from IrDA? Is there a way to get notification
> 	of BT interface state changes?

I cant see anything on netlink and irda; i am also not very familiar with
either IrDA or Bluetooth.
Regardless,  you dont need to be a net device to use netlink. Its a
messaging system and you can use it both within the kernel as well as
kernel<->userspace. If you get stuck writting the interface ping me
privately.

cheers,
jamal

