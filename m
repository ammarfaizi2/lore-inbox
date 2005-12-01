Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVLANof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVLANof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 08:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVLANof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 08:44:35 -0500
Received: from magic.adaptec.com ([216.52.22.17]:163 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932226AbVLANoe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 08:44:34 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
Date: Thu, 1 Dec 2005 08:44:15 -0500
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3E318@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
Thread-Index: AcX2ah5JPoCeAYzVQGOrlrUKrBbaMAADfx9A
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Christoph Hellwig" <hch@infradead.org>,
       "Darrick J. Wong" <djwong@us.ibm.com>
Cc: "Chris McDermott" <lcm@us.ibm.com>,
       "Luvella McFadden" <luvella@us.ibm.com>,
       "AJ Johnson" <blujuice@us.ibm.com>,
       "Kevin Stansell" <kstansel@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>, <Mauelshagen@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig sez:
> NACK.  We're not going to support attaching broken propritary drivers.

Understood and expected.

The word 'broken' is hardly chosen for scientific reasons, bespeaks an
agenda ;-> Just because you can not see the code, does not mean it is
broken.

I have on numerous attempts tried to contact Heinz Mauelshagen to
fortify dmraid in support of the HostRAID adapters. He has yet to
respond to my emails to start a dialogue with Adaptec.

Justin Gibbs had provided the community the emd driver, soundly rejected
and never ported to dm because there were features that Justin held dear
in md that do not translate to dm. An unfortunate waste of considerable
resources.

Without the timely agenda and cooled temperaments to close the gap, the
solution should be temporarily to support the proprietary HostRAID
driver when the Adapter is in HostRAID mode and we continue to work to
close that gap on dmraid.

Could you agree with that to help the users today?

[ You are on record as not giving a fig for the users, what if I showed
them as starving children in a third world nation, would that melt your
heart? ;-} ]

> Sepcially as these "HostRAID" cards are plain SCSI HBAs.

They are plain SCSI HBAs, but are designated as a RAID card rather than
a Host Bus Adapter in the PCI config space when in 'HostRAID' mode. The
fact that is designated in the PCI space should be enough reason *not*
to attach a simplified LLD.

The HostRAID driver has a specialized (ok, yes, also proprietary) CHIM
and sequencer where attention can be focused on techniques of
performance improvement and OS agnostics. In addition, the RAID code in
that driver understands the hardware, CHIM & sequencer and takes
advantage of features that just can not be performed by an abstracted dm
or an LLD. RAID1 is handled under some conditions, for instance, with
one DMA operation over the PCI bus rather than two duplicated for each
target, greatly increasing the performance.

Linux is not about performance first, it is about doing it the Linux
way. I believe we can understand that. And in turn, do not consider it
harmful if a group of individuals trying to make a living see a chance
to acquire a competitive edge.

Sincerely -- Mark Salyzyn
