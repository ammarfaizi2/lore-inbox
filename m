Return-Path: <linux-kernel-owner+w=401wt.eu-S965132AbXAEJ1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbXAEJ1m (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 04:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbXAEJ1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 04:27:42 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:49105 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965132AbXAEJ1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 04:27:41 -0500
X-Greylist: delayed 1225 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 04:27:41 EST
Message-ID: <459E1535.5020105@vandrovec.name>
Date: Fri, 05 Jan 2007 01:07:01 -0800
From: Petr Vandrovec <petr@vandrovec.name>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.9) Gecko/20061219 Iceape/1.0.7 (Debian-1.0.7-1)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: jeff@garzik.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Unbreak MSI on ATI devices
References: <20061221075540.GA21152@vana.vc.cvut.cz> <ada4pr61mie.fsf@cisco.com>
In-Reply-To: <ada4pr61mie.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jan 2007 09:07:01.0640 (UTC) FILETIME=[DC8FD080:01C730A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>  > So my question is - what is real reason for disabling INTX when in MSI mode?
>  > According to PCI spec it should not be needed, and it hurts at least chips
>  > listed below:
>  > 
>  > 00:13.0 0c03: 1002:4374 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
>  > 00:13.1 0c03: 1002:4375 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
>  > 00:13.2 0c03: 1002:4373 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller 
> 
> heh... I'm not gloating or anything... but I am glad that some ASIC
> designer was careless enough to prove me right when I said going
> beyond what the PCI spec requires is dangerous.

Hi,
   unfortunately it is not everything :-(

I cannot get MSI to work on IDE interface under any circumstances - in 
legacy mode it always uses IRQ14/15 regardless of whether MSI is enabled 
or not (that's probably correct), but in native mode as soon as I enable 
MSI it either does not deliver interrupts at all (definitely not through 
IRQ14/15, and, if I got routing right, also not through its INTA#), or 
it delivers them somewhere else than where programmed.  As my boot 
device is connected to this adapter, and it is a notebook, it is not 
easy to debug what's really going on :-(

00:14.1 0101: 1002:4376  IDE interface: ATI Technologies Inc Standard 
Dual Channel PCI IDE Controller ATI  (prog-if 8f [Master SecP SecO PriP 
PriO])
         Subsystem: Rioworks Unknown device 2043
         Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 18
         I/O ports at 01f0 [size=8]
         I/O ports at 03f4 [size=4]
         I/O ports at 0170 [size=8]
         I/O ports at 0374 [size=4]
         I/O ports at 8410 [size=16]
         Capabilities: [70] Message Signalled Interrupts: Mask- 64bit- 
Queue=0/0 Enable-


							Petr
