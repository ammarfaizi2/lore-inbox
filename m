Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265103AbUFWQvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265103AbUFWQvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 12:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266565AbUFWQvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 12:51:05 -0400
Received: from fmr06.intel.com ([134.134.136.7]:33714 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265103AbUFWQvB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 12:51:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]2.6.7 MSI-X Update
Date: Wed, 23 Jun 2004 09:49:29 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024057E5A85@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]2.6.7 MSI-X Update
Thread-Index: AcRY1Ivdj6tQO9r3QHGlRz6Yu4KObwAbEicA
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Roland Dreier" <roland@topspin.com>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
Cc: <ak@muc.de>, <akpm@osdl.org>, <greg@kroah.com>, <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>, <zwane@linuxpower.ca>,
       <eli@mellanox.co.il>
X-OriginalArrivalTime: 23 Jun 2004 16:49:31.0256 (UTC) FILETIME=[0E1AAF80:01C45942]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 22, 2004 Roland Dreier wrote: 
>I think this structure should be defined in a header in include/linux,
>probably <linux/pci.h>.  We could create a new <linux/msi.h> include
>but I don't think it's worth it at this point.  Also I don't see any
>reason to use bitfields or userspace types like __u32 (since no
>userspace code is going to use this include file).  I would just
>declare the type as
>
>struct msix_entry {
>       u16 vector;
>       u16 entry;
>};
>
>  > +int pci_enable_msix(struct pci_dev *dev, u32 *entries, int nvec)
>
>Since this function takes an array of struct msix_entry in its entries
>parameter, I think entries should be declared as struct msix_entry *
>rather than just u32 *.  That is, I would write the prototype as
>
>int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
>		    int nvec);
>

Agree. Thanks for your suggestion of defining struct msix_entry in
<linux/pci.h>.

>  > +		j = (entries + i)->entry;
>  > +		(entries + i)->vector = vector;
>
>Finally, this is a nitpick, but this just looks odd to me.  Why not
>write this as
>
>                j = entries[i].entry;
>                entries[i].vector = vector;
>

Agree. Thanks.

Thanks,
Long


