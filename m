Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVGZEQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVGZEQH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 00:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVGZEQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 00:16:07 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:5571 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261620AbVGZEQD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 00:16:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Aiz9uvp/MLpe8vuIzZPHhhTHjV2+U2HBlc7jN9ViRARTmsDKnsoTbb9p+VWSHEM+Tmqim57xAuzcwyQo3j8g4RtZhDc0Vt5maW/uYVimqeoVCt8QYHUCyO7xmMO+pOYHfdclscaOfmtzyulc3BitE+BdxE3yDkdBZNF0IfmpRPA=
Message-ID: <b115cb5f050725211615cfab78@mail.gmail.com>
Date: Tue, 26 Jul 2005 13:16:02 +0900
From: Rajat Jain <rajat.noida.india@gmail.com>
Reply-To: Rajat Jain <rajat.noida.india@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Incorrect driver getting loaded for Qlogic FC-HBA
Cc: kernelnewbies@nl.linux.org, linux-scsi@vger.kernel.org,
       linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050726000600.GB23858@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b115cb5f0507241902653b6f72@mail.gmail.com>
	 <20050726000600.GB23858@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/05, Greg KH <greg@kroah.com> wrote:
> On Mon, Jul 25, 2005 at 11:02:39AM +0900, Rajat Jain wrote:
> > I'm using Kernel 2.6.9 and am having a Qlogic QLE2362 FC-HBA in my
> > system. I selected all the Qlogic SCSI drivers while buiding the
> > kernel. Now the problem is that every time I reboot, I have to
> > MANUALLY modprobe the qla2322.ko module in the kernel and only then my
> > HBA works. By default, the kernel loads qla2300.ko, which is not the
> > correct driver for the card, and hence the HBA does not work. Here is
> > the lspci output:
> 
> "by default" the kernel does not load any modules.  That's up to the
> hotplug system, or some other package.
> 
> thanks,
> 
> greg k-h
> 

Thanks. I just checked .. that is right. So let me put it this way.
When ever I hot-plug my HBA into the system, the driver "qla2300" gets
loaded. Where as the correct driver is "qla2322". This evident from
the output of "modules.pcimap" file and "lspci". The PCI device number
of HBA is 2322. and in modules.pcimap file, qla2322 is supposed to be
loaded when this HBA is hot-plugged. But module qla2300 is getting
loaded.

Any pointers on where could the problem be? Or how should I approach
this problem?

Thanks a lot.

Rajat

PS: For reference I am attaching the modules.pcimap file and lspci
output here again:

-----------------------------------------------------------------
0d:07.1 Fibre Channel: QLogic Corp.: Unknown device 2322 (rev 03)
       Subsystem: QLogic Corp.: Unknown device 0118
       Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 185
       I/O ports at 6400 [size=256]
       Memory at d0401000 (64-bit, non-prefetchable) [size=4K]
       Capabilities: [44] Power Management version 2
       Capabilities: [4c] PCI-X non-bridge device.
       Capabilities: [54] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
-------------------------------------------------------------------

Here is the relevant extract from modules.pcimap:
-------------------------------------------------------------------
#module  vendor     device     subvendor  subdevice  class  
class_mask driver_data
qla2300  0x00001077 0x00002300 0xffffffff 0xffffffff 0x00000000 0x00000000 0x0
qla2300  0x00001077 0x00002312 0xffffffff 0xffffffff 0x00000000 0x00000000 0x0
qla2322  0x00001077 0x00002322 0xffffffff 0xffffffff 0x00000000 0x00000000 0x0
-------------------------------------------------------------------
