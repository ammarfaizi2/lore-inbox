Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbVI3SkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVI3SkF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbVI3SkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:40:05 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:60572 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S965070AbVI3SkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:40:03 -0400
Subject: RE: I request inclusion of SAS Transport Layer and AIC-94xx into
	the kernel
From: Andrew Patterson <andrew.patterson@hp.com>
Reply-To: andrew.patterson@hp.com
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: "Tuikov, Luben" <Luben_Tuikov@adaptec.com>, dougg@torque.net,
       Linus Torvalds <torvalds@osdl.org>, Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 12:39:54 -0600
Message-Id: <1128105594.10079.109.camel@bluto.andrew>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 13:07 -0400, Salyzyn, Mark wrote:
> At the SAS BOF, I indicated that it would not be much trouble to
> translate the CSMI handler in the aacraid driver to a similar sysfs
> arrangement. If such info can be mined from a firmware based RAID card,
> every driver should be able to do so. The spec writers really need to
> consider rewriting SDI for sysfs (if they have not already) and move
> away from an ABI.

SDI is supposed to be a cross-platform spec, so mandating sysfs would
not work.  I suggested to the author to use a library like HPAAPI (used
by Fibre channel), so you could hide OS implementation details.  I am in
fact working on such a beasty (http://libsdi.berlios.de).  He thinks
that library solutions tend to not work, because the library version is
never in synch with the standard/LLDD's. Given Linux vendor lead-times,
he does have a valid point.

Note that a sysfs implementation has problems.  Binary attributes are
discouraged/not-allowed.  There is no atomic request/response
operations, buffers limited to page size, etc. Other alternatives are
configfs, SG_IO, and the above mentioned character device.  None are a
complete replacement for the transactional nature of IOCTL's.  A group
of us are looking into this.  We probably should be taking it to
linux-scsi, but didn't want to get it caught up in the current flamewar.

Andrew

> 
> Sincerely -- Mark Salyzyn
> 
> -----Original Message-----
> From: Tuikov, Luben
> Sent: Friday, September 30, 2005 12:47 PM
> To: andrew.patterson@hp.com
> Cc: dougg@torque.net; Linus Torvalds; Luben Tuikov; SCSI Mailing List;
> Linux Kernel Mailing List
> Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx
> into the kernel
> 
> On 09/30/05 12:26, Andrew Patterson wrote:
> > 
> > I talked to one of the authors of these specs.  SDI is an attempt to 
> > create an open standard for the somewhat proprietary CSMI spec 
> > developed by HP.  It is currently languishing in t10 due to the IOCTL 
> > problem you describe below (the "no new IOCTL's" doctrine caught them 
> > by surprise). There is some thought to going to a write()/read() on a 
> > character device model, but this has various problems as well.
> 
> I think that read/write from a char device is going away too.
> 
> For this reason I showed the whole picture of the SAS
> domain in sysfs _and_ created a binary file attr to send/receive SMP
> requests/responses to control the domain and get attributes
> ("smp_portal" binary attr of each expander).
> 
> It is completely user space driven and a user space library
> is simple to write.
> 
> See drivers/scsi/sas/expander_conf.c which is a user
> space utility.  For the output see Announcement 3:
> http://linux.adaptec.com/sas/Announce_2.txt or here:
> http://marc.theaimsgroup.com/?l=linux-scsi&m=112629509318354&w=2
> 
> The code which implements it is very tiny, at the bottom
> of drivers/scsi/sas/sas_expander.c
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

