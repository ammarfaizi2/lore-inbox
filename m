Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263129AbTCWR33>; Sun, 23 Mar 2003 12:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263130AbTCWR33>; Sun, 23 Mar 2003 12:29:29 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47523
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263129AbTCWR31>; Sun, 23 Mar 2003 12:29:27 -0500
Subject: Re: Need help for pci driver on powerpc
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christian Jaeger <christian.jaeger@ethlife.ethz.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030323171955Z263126-25575+35740@vger.kernel.org>
References: <20030323171955Z263126-25575+35740@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048445586.10727.58.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2003 18:53:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 17:30, Christian Jaeger wrote:
> - What does pci_resource_start return, a phys/virt/bus address?

Normally a pci bus address, but its really a cookie 

> - What does ioremap expect?

The same cookie

> - do I need pci_set_master? Which other PCI calls are important?

You need enable_device, and before you touch the others. That should
ensure the hardware is in D0 (active) not powersaving or some other
inconvenience


Basically the logic goes

Ask the pci layer for pci register values
Feed values to ioremap
Get a cookie for use with readb/readw/readl etc

The return of ioremap may be a physical mapping, it might be the
cpu view of the bus address, or something else. 


