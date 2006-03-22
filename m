Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbWCVXle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbWCVXle (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbWCVXle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:41:34 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:52872 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932645AbWCVXld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:41:33 -0500
Subject: RE: [RFC, PATCH 5/24] i386 Vmi code patching
Date: Wed, 22 Mar 2006 18:41:06 -0500
MIME-Version: 1.0
To: arai@vmware.com, zach@vmware.com
Cc: xen-devel@lists.xensource.com, wim.coekaerts@oracle.com, chrisw@osdl.org,
       chrisl@vmware.com, jbeulich@novell.com, chrisw@sous-sol.org,
       virtualization@lists.osdl.org, torvalds@osdl.org, anne@vmware.com,
       jreddy@vmware.com, kmacy@fsmware.com, ksrinivasan@novell.com,
       leendert@watson.ibm.com, linux-kernel@vger.kernel.org
From: Volkmar Uhlig <vuhlig@us.ibm.com>
X-Mailer: Microsoft Outlook v 11.00.8000, MSOC v 2.00.4007.00
Message-ID: <OF6C9205F6.79606CB4-ON05257139.0080D734@us.ibm.com>
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0.1HF18 | February 28, 2006) at
 03/22/2006 18:41:10,
	Serialize complete at 03/22/2006 18:41:10
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: arai@vmware.com
> Sent: Wednesday, March 22, 2006 5:34 PM
>
> > The idea of in-tree ROM code doesn't make sense.  The entire point
> > of this layer of code is that it is modular, and specific to the
> > hypervisor, not the kernel.  Once you lift the shroud and combine
> > the two layers, you have lost all of the benefit that it was
> > supposed to provide.
> 
> To elaborate a bit more, the "ROM" layer is "published" by 
> the hypervisor.  This layer of abstraction will let you take 
> a VMI-compiled kernel and run it efficiently on any 
> hypervisor that exports a VMI interface - even one that you 
> didn't know about (or didn't exist) when you compiled your kernel.
> 
> [...]
> 
> Going forward, having the ROM layer published by the 
> hypervisor gives the hypervisor more flexibility than having 
> the code statically compiled into the kernel.  Consider when 
> hardware virtualization becomes more prevalent.  Perhaps 
> there are places where today hypercalls make sense, but with 
> hardware virtualization, you'd rather have the hardware just 
> take care of it.  CPUID is the only example I can come up 
> with at the moment, but there are certainly others.  VMI lets 
> the hypervisor decide that it doesn't actually need to 
> replace the CPUID instruction with a hypercall.  The 
> important factor here is that only the hypervisor, not the 
> kernel, knows about these performance tradeoffs.  

Very obvious other candidates are the shadowed system state registers
(cli, sti, CRx) provided by VT and the shadow page-table support as
defined by Pacifica.  In particular since these features are dependent on
the specific processor revision a hard-coded binary interface doesn't do
any good.  The ROM pretty much resembles Linux' system call interface as
provided today optimizing for the specific HW architecture.

- Volkmar
