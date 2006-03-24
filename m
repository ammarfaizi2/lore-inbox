Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWCXPfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWCXPfW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWCXPfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:35:22 -0500
Received: from mail.cs.umn.edu ([128.101.36.202]:59010 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S1750874AbWCXPfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:35:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17444.4455.240044.724257@hound.rchland.ibm.com>
Date: Fri, 24 Mar 2006 09:33:59 -0600
To: Jeff Garzik <jeff@garzik.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>, ian.pratt@cl.cam.ac.uk,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
In-Reply-To: <4423F91F.4060007@garzik.org>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>
	<4421D943.1090804@garzik.org>
	<1143202673.18986.5.camel@localhost.localdomain>
	<4423E853.1040707@garzik.org>
	<4423F60B.6020805@garzik.org>
	<1143207657.2882.65.camel@laptopd505.fenrus.org>
	<4423F91F.4060007@garzik.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
From: boutcher@cs.umn.edu (Dave C Boutcher)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik wrote:
>Arjan van de Ven wrote:
>> On Fri, 2006-03-24 at 08:37 -0500, Jeff Garzik wrote:
>>> Jeff Garzik wrote:
>>>> In fact, SCSI should make a few things easier, because the notion of 
>>>> host+bus topology is already present, and notion of messaging is already 
>>>> present, so you don't have to recreate that in a Xen block device 
>>>> infrastructure.
>>> Another benefit of SCSI:  when an IBM hypervisor in the Linux kernel 
>>> switched to SCSI, that allowed them to replace several drivers (virt 
>>> disk, virt cdrom, virt floppy?) with a single virt-SCSI driver.
>
>> but there's a generic one for that: iSCSI
>> so in theory you only need to provide a network driver then ;)
>
>Talk about lots of overhead :)
>
>OTOH, I bet that T10 is acting at high speed, right this second, to form 
>a committee, and multiple sub-committees, to standardize SCSI 
>transported over XenBus.  SXP anyone?  :)

Actually SRP (which T10 has now stopped working on) fits the bill very
nicely.

I have to say that moving the IBM virtual drivers from a random
collection of unique drivers (viodisk, viotape, viocd) to a single
virtual SCSI HBA made life much easier.

There is a group (actually, at least two groups) working on SCSI
target infrastructures...once that is in place, I would expect we
could start hacking a Xen virtual HBA.

We looked at iSCSI as a transport (instead of SRP) but we felt that 
the added complexity made it unlikely that the average human could
successfully boot their virtual machine

Dave B
