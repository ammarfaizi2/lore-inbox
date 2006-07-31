Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWGaSW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWGaSW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWGaSW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:22:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030302AbWGaSW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:22:28 -0400
Date: Mon, 31 Jul 2006 11:22:20 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel hangs when trying to remove a bridge
Message-ID: <20060731112220.0c14d1bc@localhost.localdomain>
In-Reply-To: <200607291642.05046.yoda@isr.ist.utl.pt>
References: <200607291642.05046.yoda@isr.ist.utl.pt>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2006 16:42:04 +0100
Rodrigo Ventura <yoda@isr.ist.utl.pt> wrote:

> 
> I'm using kernel 2.6.16 (-gentoo-r13 actually). A bridge iface br0 is setup 
> using eth1 and eth0.1 (VLAN) as slaves. To bring br0, what I do is to remove 
> the slaves from the bridge first, "ip link set dev br0 down" next, followed 
> by the brctl command to remove the bridge. What happens is that it seems it 
> tryes to destroy the bridge iface, and then hangs, with dmesg complaining, 
> periodically, about once a second, something like:
> 
> unregister_netdevice: waiting for br0 to become free. Usage count = 1
> unregister_netdevice: waiting for br0 to become free. Usage count = 1
> unregister_netdevice: waiting for br0 to become free. Usage count = 1
> ...
> 
> I say it partially hangs because commands like ifconfig hang (ps state=Disk 
> busy)...
> To reboot the machine, a HARD reset is required, since, the shutdown process 
> hangs... 
> 

Some broken protocol in the kernel, incremented a refcount but forgot
to cleanup when notified on device removal.

There was a bug in the VLAN code that did that, not sure which version
it was fixed in.

Do you have IPV6 installed (as a module)?
In some kernel versions, IPV6 has a problem with device ref counting, and
leaves a dangling reference.


-- 
