Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVANQjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVANQjv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 11:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVANQif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 11:38:35 -0500
Received: from alog0347.analogic.com ([208.224.222.123]:17536 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261756AbVANQiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 11:38:15 -0500
Date: Fri, 14 Jan 2005 11:37:47 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Peter Kruse <pk@q-leap.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Random packets loss under x86_64 - routing?
In-Reply-To: <41E7E6D7.10303@q-leap.com>
Message-ID: <Pine.LNX.4.61.0501141129260.5840@chaos.analogic.com>
References: <41E7E6D7.10303@q-leap.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005, Peter Kruse wrote:

> kernel: 2.4.28 smp x86_64
>
> Hello,
>
> We experience a problem in our amd64 beowulf clusters and could need
> some help.
> When ping'ing other machines in a cluster on the same
> subnet, it fails for some machines.  But only right after boot
> and after a day or so of idle time.  After some time (a few minutes) the
> ping packets go through.
>
> Other things we observed:
>
> 1. it is not always the same machines that fail
> 2. if it fails then no packets are sent or received (checked with
>   tcpdump on sending and target host) although all hosts are up.
> 3. There is no difference if using a 64bit or 32bit ping
> 4. It does not depend on the network adapter or other hardware, we have
>   machines with different NICs connected to different switches with the
>   same problem.
> 5. It does however only happen on amd64 (biarch) systems and not on
>   pure i386 systems so it looks like related to the kernel.
> 6. I have to reboot to reproduce the problem, it's not enough to
>   unload and load the network module.
> 7. It only happens with ping, not with ssh.
>
> The ping always succeeds when running with the "-r" switch,
> that bypasses "the normal routing tables and send directly to a host
> on an attached interface".  This makes us think that it indeed it is
> related to routing - but how?
>
> I can provide an strace output if you think that could help.
> What else can I do to gather more information?
>
> Please cc to me, as I'm not subscribed, thanks.
>
> 	Peter
>

When they 'disappear', use `arp -d hostname` to delete the
entry from the ARP tables. Then see if you can ping it.
It is possible that the destination machine got re-routed
and the new router's HW address wasn't updated in the
ARP tables. If this is the case, I don't know hot to 'fix'
it, but it's a new data-point. When you have dynamic routing,
there needs to be some way to update the ARP tables even though
they eventually expire.

The fact that `ping -r` works seems to show that the ARP table
has stale entries in it.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
