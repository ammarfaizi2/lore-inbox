Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbULODGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbULODGn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 22:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbULODGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 22:06:42 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:28615 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261807AbULODGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 22:06:39 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [PATCH] add legacy I/O and memory access routines to /proc/bus/pci API
Date: Tue, 14 Dec 2004 19:06:26 -0800
User-Agent: KMail/1.7.2
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
References: <200412140941.56116.jbarnes@engr.sgi.com> <200412141655.04416.bjorn.helgaas@hp.com> <200412141611.32417.jbarnes@engr.sgi.com>
In-Reply-To: <200412141611.32417.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412141906.26809.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 14, 2004 4:11 pm, Jesse Barnes wrote:
> > In this example, the particular device ("01/01.0") you open
> > makes no difference, right?  The I/O port routing is determined
> > by the chipset, not by which /proc/bus/pci/... file you open.
>
> But the chipset can be programmed to route things correctly or remap the
> correct legacy I/O port domain in the callback routine.

I should clarify here, the device *does* matter, since the legacy I/O port 
space mapping will point at different addresses depending on the device.  
Generally, devices on the same bus will get the same address, but two devices 
on different busses will have different addresses mapped (at least on Altix).  
In your case, where you can route I/O ports to arbitrary busses, you could do 
the routing at the time of the call and return -EBUSY if another device was 
already using the route and hadn't released it yet.

Jesse
