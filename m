Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753553AbWKCVmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbWKCVmH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 16:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbWKCVmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 16:42:07 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:32707 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP
	id S1753553AbWKCVmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 16:42:04 -0500
Message-ID: <022601c6ff91$0bac2650$962e8d52@aldipc>
From: "roland" <devzero@web.de>
To: "Stephen Hemminger" <shemminger@osdl.org>
Cc: <greearb@candelatech.com>, <jesper.juhl@gmail.com>,
       <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
       <yoshfuji@linux-ipv6.org>
References: <1405740846@web.de> <20061103130451.47e70922@freekitty>
Subject: Re: unregister_netdevice: waiting for eth0 to become free
Date: Fri, 3 Nov 2006 22:43:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>You are also looking at 2.4 code which is OLD and probably broken in the
>device ref counting. Lots of work went into cleaning up the shutdown and 
>device
>ref counting for 2.6, and I'm not surprised if 2.4 has problems.

thanks. from what i found on different postings, it seems that this issue 
really has been adressed several times.
have seen it for 2.6 kernels though, vmware still recommending disabling 
ipv6 for suse 10.1 , but maybe this is just for "historical reason". 
furthermore jesper reported it for 2.6.18, but maybe that the problem now 
happens under very rare circumstances.
probably worth mentioning here, that two probably related bugs are in "not 
resolved" state at:
http://bugzilla.kernel.org/show_bug.cgi?id=6698 and 
http://bugzilla.kernel.org/show_bug.cgi?id=6197

i will keep an eye on our systems and report if i can see this on any more 
recent kernels.

thanks for your help!

roland

----- Original Message ----- 
From: "Stephen Hemminger" <shemminger@osdl.org>
To: <devzero@web.de>
Cc: <greearb@candelatech.com>; <jesper.juhl@gmail.com>; 
<linux-kernel@vger.kernel.org>; <linux-net@vger.kernel.org>; 
<yoshfuji@linux-ipv6.org>
Sent: Friday, November 03, 2006 10:04 PM
Subject: Re: unregister_netdevice: waiting for eth0 to become free


> On Fri, 03 Nov 2006 21:31:01 +0100
> devzero@web.de wrote:
>
>> >Vmware has there own pseudo ethernet device and unless you have the 
>> >source for it.
>> >It would be hard to tell if it correctly manages itself.
>>
>> VMware is able to emulate three different network card types:
>>
>> - AMD Am79C970A - PCnet LANCE PCI Ethernet Controller (linux pcnet32 
>> driver)
>> - Intel E1000 (e1000 driver)
>> - VMXNET - VMware PCI Ethernet Adapter (vmxnet, vmware`s own driver)
>>
>> so there are 3 different drivers being used inside the guest OS for 
>> networking virtual machines.
>>
>> rumours tell, that the vmxnet driver is sort of a mess, but i have seen 
>> the unregister_netdevice problem with pcnet32 AND with vmxnet - and all 
>> of the vmware readme`s are telling:
>>
>> "In many Linux distributions, if IPv6 is enabled, VMware Tools cannot be 
>> configured with vmware-config-tools.pl after installation. In this case, 
>> VMware Tools is unable to set the network device correctly for the 
>> virtual machine, and displays a message similar to
>> Unloading pcnet32 module
>> unregister_netdevice: waiting for eth0 to become free"
>>
>> so - this is the native linux driver for pcnet32 which fails get unloaded 
>> _before_ the driver being replaced by the vmware specific one and the 
>> virtual nic being switched to the VMXNET adapter.....
>>
>> anyway - i got that problem while shutting down a VM, not while 
>> installing vmware tools.
>>
>> btw - just came across this posting from jesper juhl:
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=115703768804826&w=2
>>
>> roland
>
> You are also looking at 2.4 code which is OLD and probably broken in the
> device ref counting. Lots of work went into cleaning up the shutdown and 
> device
> ref counting for 2.6, and I'm not surprised if 2.4 has problems. 

