Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129823AbQLWPbq>; Sat, 23 Dec 2000 10:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130155AbQLWPbh>; Sat, 23 Dec 2000 10:31:37 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:23436 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129823AbQLWPb2>; Sat, 23 Dec 2000 10:31:28 -0500
Message-ID: <3A44BF57.B01C2097@uow.edu.au>
Date: Sun, 24 Dec 2000 02:05:59 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Q: netdevice interface change
In-Reply-To: <3A44B324.1E1E9AF1@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred wrote:
> 
> Hi Andrew,
> 
> I have 2 questions about your netdevice2.txt:
>    http://www.uow.edu.au/~andrewm/linux/netdevice2.txt
> 
> * is withdraw_netdevice() really required, can't unregister_netdev
> check "hidden", and notify the protocols/hotplug based on that value?

Yes, it's basically the same thing and yes, it could be done
this way.  The only difference is that withdraw_netdev()
will blurt out a warning if it is called on an unhidden device.
This is useful now, but less so later.   I guess it could be
#defined onto unregister_netdev later..


> * I don't like the backward compatibility section:
> 
> <<<<<<<<
> Other things:
> 
>      #define HAVE_PUBLISH_NETDEV
> 
>           This is for 2.2-compatible drivers.  They can do this:
> 
>           #ifdef HAVE_PUBLISH_NETDEV
>           #define init_etherdev prepare_etherdev
>           #define publish_netdev(dev) do {} while (0)
>           #define withdraw_netdev unregister_netdev
>           #endif
> >>>>>>>>
> 
> As far as I know Linus prefers backward compatibility the other way
> around:
> 
> <<<<<<
> A 2.4 driver that must remain compatible with 2.2 should use
> the new interface and add these lines to their source file:
> 
>        #ifndef HAVE_PUBLISH_NETDEV
>        #define prepare_etherdev init_etherdev
>        #define publish_netdev(dev) do {} while (0)
>        #define withdraw_netdev unregister_netdev
>        #endif
> >>>>>>

You are correct, and that is in fact how I did it in rrunner.c.
I'll do eepro100 and acenic that way too.  The manual is wrong :)

BTW: I just finished the ethernet devices, so my request for
help can be ignored.  Fixed a truckload of unchecked kmallocs
and error-path memory leaks while I was at it.  Sigh.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
