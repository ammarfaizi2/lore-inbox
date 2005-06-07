Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVFGL4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVFGL4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 07:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVFGL4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 07:56:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:31617 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261835AbVFGL4m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 07:56:42 -0400
Message-ID: <1118145394.42a58b728a15a@imap.linux.ibm.com>
Date: Tue,  7 Jun 2005 07:56:34 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: greg@kroah.com, linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Bodo Eggert <7eggert@gmx.de>, Dipankar Sarma <dipankar@in.ibm.com>,
       stern@rowland.harvard.edu, awilliam@fc.hp.com, bjorn.helgaas@hp.com
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.7
X-Originating-IP: 9.184.230.205
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Grant Grundler <grundler@parisc-linux.org>:

> On Mon, Jun 06, 2005 at 11:07:17PM -0400, Vivek Goyal wrote:
> >   So even if interrupts are disabled on PCI-PCI bridge, interrupts
> generated
> >   by PCI devices on secondary bus are not blocked and I hope device
> should
> >   be working fine.
> 
> How did you plan on disabling interrupts?
> Did you see the MSI discussion that going on now in linux-pci mailing list?

I am following the discussion now. Thanks. 

I am planning to disable only leagacy shared interrupts (irq pin assertion/INTx
emulation) because shared interrupts are a problem. MSI are
not shared but I am not sure can they lead to any other problem.

> 
> > But at the same time kdump kernels are not supposed to
> > do a great deal except capture and save the dump.
> 
> I'd think you want to stop DMA for all devices.
> Just to prevent them from messing more with memory
> that you want to dump - ie get a consistent snapshot.
> Leaving VGA devices alone should be safe.
> 

May be at some point of time. 

> > Disabling interrupts at PCI level should increase the reliability of
> capturing
> > the dump on newer machines with hardware compliant with PCI 2.3 or higher.
> 
> 
> *lots* of PCI devices predate PCI2.3. Possibly even the majority.


Ya, Some other solution is needed for hardware predating PCI2.3. May be Eric's
suggestion of polling the hardware.

Thanks
Vivek
