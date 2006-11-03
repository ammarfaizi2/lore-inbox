Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753533AbWKCVE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbWKCVE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 16:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbWKCVE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 16:04:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753523AbWKCVE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 16:04:56 -0500
Date: Fri, 3 Nov 2006 13:04:51 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: devzero@web.de
Cc: greearb@candelatech.com, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: unregister_netdevice: waiting for eth0 to become free
Message-ID: <20061103130451.47e70922@freekitty>
In-Reply-To: <1405740846@web.de>
References: <1405740846@web.de>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Nov 2006 21:31:01 +0100
devzero@web.de wrote:

> >Vmware has there own pseudo ethernet device and unless you have the source for it.
> >It would be hard to tell if it correctly manages itself.
> 
> VMware is able to emulate three different network card types:
> 
> - AMD Am79C970A - PCnet LANCE PCI Ethernet Controller (linux pcnet32 driver)
> - Intel E1000 (e1000 driver)
> - VMXNET - VMware PCI Ethernet Adapter (vmxnet, vmware`s own driver)
> 
> so there are 3 different drivers being used inside the guest OS for networking virtual machines.
> 
> rumours tell, that the vmxnet driver is sort of a mess, but i have seen the unregister_netdevice problem with pcnet32 AND with vmxnet - and all of the vmware readme`s are telling:
> 
> "In many Linux distributions, if IPv6 is enabled, VMware Tools cannot be configured with vmware-config-tools.pl after installation. In this case, VMware Tools is unable to set the network device correctly for the virtual machine, and displays a message similar to
> Unloading pcnet32 module
> unregister_netdevice: waiting for eth0 to become free"
> 
> so - this is the native linux driver for pcnet32 which fails get unloaded _before_ the driver being replaced by the vmware specific one and the virtual nic being switched to the VMXNET adapter.....
> 
> anyway - i got that problem while shutting down a VM, not while installing vmware tools.
> 
> btw - just came across this posting from jesper juhl:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=115703768804826&w=2
> 
> roland

You are also looking at 2.4 code which is OLD and probably broken in the
device ref counting. Lots of work went into cleaning up the shutdown and device
ref counting for 2.6, and I'm not surprised if 2.4 has problems.
