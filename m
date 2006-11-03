Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753527AbWKCUbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbWKCUbH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753530AbWKCUbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:31:07 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:6322 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP
	id S1753524AbWKCUbD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:31:03 -0500
Reveived: from web.de 
	by fmmailgate05.web.de (Postfix) with SMTP id A61C4282FFD;
	Fri,  3 Nov 2006 21:31:02 +0100 (CET)
Date: Fri, 03 Nov 2006 21:31:01 +0100
Message-Id: <1405740846@web.de>
MIME-Version: 1.0
From: devzero@web.de
To: Stephen Hemminger <shemminger@osdl.org>
Cc: greearb@candelatech.com, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: unregister_netdevice: waiting for eth0 to become free
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Vmware has there own pseudo ethernet device and unless you have the source for it.
>It would be hard to tell if it correctly manages itself.

VMware is able to emulate three different network card types:

- AMD Am79C970A - PCnet LANCE PCI Ethernet Controller (linux pcnet32 driver)
- Intel E1000 (e1000 driver)
- VMXNET - VMware PCI Ethernet Adapter (vmxnet, vmware`s own driver)

so there are 3 different drivers being used inside the guest OS for networking virtual machines.

rumours tell, that the vmxnet driver is sort of a mess, but i have seen the unregister_netdevice problem with pcnet32 AND with vmxnet - and all of the vmware readme`s are telling:

"In many Linux distributions, if IPv6 is enabled, VMware Tools cannot be configured with vmware-config-tools.pl after installation. In this case, VMware Tools is unable to set the network device correctly for the virtual machine, and displays a message similar to
Unloading pcnet32 module
unregister_netdevice: waiting for eth0 to become free"

so - this is the native linux driver for pcnet32 which fails get unloaded _before_ the driver being replaced by the vmware specific one and the virtual nic being switched to the VMXNET adapter.....

anyway - i got that problem while shutting down a VM, not while installing vmware tools.

btw - just came across this posting from jesper juhl:
http://marc.theaimsgroup.com/?l=linux-kernel&m=115703768804826&w=2

roland




> -----Ursprüngliche Nachricht-----
> Von: Stephen Hemminger <shemminger@osdl.org>
> Gesendet: 03.11.06 20:57:54
> An: "roland" <devzero@web.de>
> CC: <yoshfuji@linux-ipv6.org>, <linux-net@vger.kernel.org>,   <linux-kernel@vger.kernel.org>
> Betreff: Re: unregister_netdevice: waiting for eth0 to become free


> On Fri, 3 Nov 2006 20:53:09 +0100
> "roland" <devzero@web.de> wrote:
> 
> > > The ipv6 module cannot be unloaded once it has been
> > > loaded.
> > 
> > sorry,  i thought i could rmmod evey module which was insmod/modprobe'd 
> > before and i didn`t know that there are exceptions
> > 
> > > I'm not sure what is happened with vmware.
> > 
> > i think this is not completely related to vmware - but maybe this is being 
> > triggered more often by vmware ?
> > http://www.google.de/search?hl=de&q=%22unregister_netdevice%3A+waiting+for+eth0+to+become+free
> > 
> > it`s really strange, but after taking a look,  vmware seems to recommend 
> > disabling ipv6 for _every_ linux based guest OS in general:
> > http://pubs.vmware.com/guestnotes/wwhelp/wwhimpl/common/html/wwhelp.htm?context=gos_ww5_output&file=choose_install_guest_os.html
> > 
> > since there are already running millions of  linux based VMs in this world, 
> > i think this isn`t very good "promotion" for ipv6, if vmware recommending 
> > disabling it.
> > ok, there are not that much people already needing ipv6 NOW, but the later 
> > they are running it and the later outstanding bugs being fixed, the harder 
> > it will be to convert from ipv4 to ipv6....
> > 
> > roland
> > 
> > 
> 
> Vmware has there own pseudo ethernet device and unless you have the source for it.
> It would be hard to tell if it correctly manages itself.
> 
> 
> -- 
> Stephen Hemminger <shemminger@osdl.org>


______________________________________________________________________
XXL-Speicher, PC-Virenschutz, Spartarife & mehr: Nur im WEB.DE Club!		
Jetzt gratis testen! http://freemail.web.de/home/landingpad/?mc=021130

