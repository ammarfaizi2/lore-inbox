Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVHBVSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVHBVSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVHBVPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:15:36 -0400
Received: from mail.emacinc.com ([208.248.202.76]:40081 "EHLO mail.emacinc.com")
	by vger.kernel.org with ESMTP id S261800AbVHBVNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:13:20 -0400
From: NZG <ngustavson@emacinc.com>
Organization: EMAC.Inc
To: comedi@comedi.org
Date: Tue, 2 Aug 2005 16:12:15 -0500
User-Agent: KMail/1.7.2
Cc: Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org
References: <200508010817.59676.ngustavson@emacinc.com> <42EF74C1.6020909@mev.co.uk>
In-Reply-To: <42EF74C1.6020909@mev.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508021612.15183.ngustavson@emacinc.com>
X-SA-Exim-Connect-IP: 208.248.202.77
X-SA-Exim-Mail-From: ngustavson@emacinc.com
Subject: Re: 2.6VMM, uClinux, & Comedi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Spam-Relay: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running comedi-0.7.70, but the issue is seems be be coming from the fact 
that I'm using a nommu arch.
grepping through my arch and include/asm, these symbols are indeed not 
defined.
This makes sense because uClinux has no true virtual memory, vmalloc is just a 
wrapper for kmalloc.
The implementation of these functions is probably trivial, but It's taking me 
a bit since I didn't really understand the VM code before (now I have a small 
inkling)
I'll get there, I'm just surprised this hasn't been attempted before.

NZG.

On Tuesday 02 August 2005 08:27, Ian Abbott wrote:
> On 01/08/05 14:17, NZG wrote:
> > I managed to successfully cross-compile Comedi for the Coldfire uClinux
> > 2.6, however it has several unresolved symbols when I try to load it.
> >
> > comedi: Unknown symbol pgd_offset_k
> > comedi: Unknown symbol pmd_none
> > comedi: Unknown symbol remap_page_range
> > comedi: Unknown symbol pte_present
> > comedi: Unknown symbol pte_offset_kernel
> > comedi: Unknown symbol VMALLOC_VMADDR
> > comedi: Unknown symbol pte_page
>
> It's probably coming to grief in Comedi's Linux compatibility headers
> somewhere, but as this stuff has changed a few times, which version of
> Comedi and which kernel version are you using exactly?
