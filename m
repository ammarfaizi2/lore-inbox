Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbTAPFnK>; Thu, 16 Jan 2003 00:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbTAPFnK>; Thu, 16 Jan 2003 00:43:10 -0500
Received: from newmail.somanetworks.com ([216.126.67.42]:39306 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S267033AbTAPFnJ>; Thu, 16 Jan 2003 00:43:09 -0500
Date: Thu, 16 Jan 2003 00:52:00 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Bret Indrelee <Bret.Indrelee@qlogic.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Forcing PCI-PCI bridge to have memory resources
In-Reply-To: <Pine.LNX.4.33.0301151709360.18997-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0301160044580.20085-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2003, Bret Indrelee wrote:

> I'm working with Linux version 2.4.18-xfs with hotswap support.
> 
> I'm trying to make a PCI-PCI bridge always have a minimum of 1MB of
> memory address space allocated to it. I know that the BIOS we are
> using always (correctly, by spec) sets a bridge with no devices behind 
> it to disable the memory window. It does this by setting the 
> MEM_LIMIT < MEM_BASE.
> 
> I've been going through the sources in drivers/pci, trying to figure
> out how things are set up. At the time of the pci scan, the resources
> are usually initialized (in bci_read_breidge_bases) by doing a read of 
> the bridge registers and setting the resource values appropropriately.
> 
> For the disabled bridges, the resources are copied from the parent
> which in this case results in 0 being set in flags, start and end.
> 
> It looks like I will want to call pci_assign_resource(dev, 1); in
> order to give it a memory window, but I'm not sure how to initialize
> the resources so they are assigned correctly.
> 
> Our situation is similiar to what a hotswap CPCI system should encounter
> when a hotswap device is inserted behind a previously empty PCI-PCI bridge.
> 
> Any help people can give would be greatly appreciated.

I've some functionality in my 2.4 cPCI code that allows manually 
specifying resource reservations for PCI bridges.  I'm about to start 
porting it forward to 2.5, but I'll dig out the bits and send you a
2.4.18 patch tomorrow.  If you're impatient, there should be a version
of it in the mailing archives of this list (search for PCI resource 
reservation), since I posted it for comment at the end of last summer 
sometime.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

