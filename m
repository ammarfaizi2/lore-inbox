Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131369AbRAWXu6>; Tue, 23 Jan 2001 18:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131206AbRAWXur>; Tue, 23 Jan 2001 18:50:47 -0500
Received: from tech1.nameservers.com ([216.46.160.19]:48646 "EHLO
	tech1.nameservers.com") by vger.kernel.org with ESMTP
	id <S130163AbRAWXul>; Tue, 23 Jan 2001 18:50:41 -0500
Message-Id: <200101232350.PAA14448@tech1.nameservers.com>
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>
Subject: Re: Turning off ARP in linux-2.4.0 
In-Reply-To: Your message of "Tue, 23 Jan 2001 10:08:03 +0100."
             <20010123100803.A24145@gruyere.muc.suse.de> 
Date: Tue, 23 Jan 2001 15:50:36 -0800
From: Pete Elton <elton@iqs.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 23, 2001 at 01:50:27AM +0100, Bernd Eckenfels wrote:
> > Another option is to ifconfig -arp the eth0 interface. I browsed through t
>     he
> > IPv4 code and did not find any other goto out which can be configured besi
>     des
> > the input FIB, which messing with is a bad thing since it wont accept the
> > packet at all.
> > 
> > so ifconfig -arp is the only option i could find which will help you. You 
>     need
> > to hardcode the arp entries for the real ip's of those web servers to reac
>     h
> > them.
> 
> -arp means that the kernel will not put in link layer to the packets.
> It's probably not what you want. Yes the option is misnamed.
> 
> 2.2 has arpfilter, which will hopefully end up in 2.4 soon too. Here is a 
> patch. It allows to filter ARP replies based on the routing table.
> 
> 
> -Andi

Thanks for the patches.  I patched the kernel and tried it and it
still is reponding to arps even after I issued:

echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
echo 1 > /proc/sys/net/ipv4/conf/lo/arp_filter

I do not know what the hidden interface did exactly and I am still
unsure why it no longer shows up in the 2.4.0 kernel.
Here is a clip from the TurboLinux ClusterServer manual that explains
how to turn off the arping.  Maybe it will clear up what I am trying to
accomplish:

	Next you have to turn off ARP replies on the interface. How you 
	accomplish that depends upon which Linux kernel version you are using. 
	On UNIX systems and Linux 2.0 kernels, you can supply the -arp option 
	to the ifconfig command when you bring up the interface. (Note that 
	some UNIX and Linux systems may use a slightly different syntax, such 
	as using noarp instead of -arp.) So in our example, we would use this 
	command to configure the interface:

		# ifconfig lo:1 10.0.0.99 netmask 255.255.255.255 -arp

	Unfortunately, this method does not work in any Linux kernels more 
	recent than the 2.0 series. For systems running kernel 2.2.14 and higher 
	the -arp option does not work. Instead, you will have to use the /proc 
	filesystem to turn off ARP replies. To do this, echo a 1 to the hidden 
	file in /proc/sys/net/ipv4/conf/all and the hidden file for the 
	interface you are using. Here is an example that will turn off ARP 
	replies on the loopback interface:

		# echo 1 > /proc/sys/net/ipv4/conf/all/hidden
		# echo 1 > /proc/sys/net/ipv4/conf/lo/hidden

Is there something that the arp_filter can do that will mirror this
functionality?  The modification that you made to the documentation 
was pretty straight forward in that the arp_filter was BOOLEAN, so 
I think I implemented it right.

Any other ideas?

Thanks for your help.

Pete 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
