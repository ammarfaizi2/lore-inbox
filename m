Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVLARoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVLARoR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVLARoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:44:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30099 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932366AbVLARoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:44:15 -0500
Date: Thu, 1 Dec 2005 17:44:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Luvella McFadden <luvella@us.ibm.com>, AJ Johnson <blujuice@us.ibm.com>,
       Kevin Stansell <kstansel@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Mauelshagen@redhat.com
Subject: Re: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
Message-ID: <20051201174411.GA13002@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	Chris McDermott <lcm@us.ibm.com>,
	Luvella McFadden <luvella@us.ibm.com>,
	AJ Johnson <blujuice@us.ibm.com>,
	Kevin Stansell <kstansel@us.ibm.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, Mauelshagen@redhat.com
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3E318@otce2k03.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3E318@otce2k03.adaptec.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 08:44:15AM -0500, Salyzyn, Mark wrote:
> Christoph Hellwig sez:
> > NACK.  We're not going to support attaching broken propritary drivers.
> 
> Understood and expected.
> 
> The word 'broken' is hardly chosen for scientific reasons, bespeaks an
> agenda ;-> Just because you can not see the code, does not mean it is
> broken.

there's various bugreports all over.  Having no source to disprove that
it's broken I call it broken for now.

> I have on numerous attempts tried to contact Heinz Mauelshagen to
> fortify dmraid in support of the HostRAID adapters. He has yet to
> respond to my emails to start a dialogue with Adaptec.

What about just sending him patches?

> Without the timely agenda and cooled temperaments to close the gap, the
> solution should be temporarily to support the proprietary HostRAID
> driver when the Adapter is in HostRAID mode and we continue to work to
> close that gap on dmraid.

No.  we're not going to do anything to make life for binary module easier,
quite contrary.

> > Sepcially as these "HostRAID" cards are plain SCSI HBAs.
> 
> They are plain SCSI HBAs, but are designated as a RAID card rather than
> a Host Bus Adapter in the PCI config space when in 'HostRAID' mode. The
> fact that is designated in the PCI space should be enough reason *not*
> to attach a simplified LLD.

No. 

> 
> The HostRAID driver has a specialized (ok, yes, also proprietary) CHIM
> and sequencer where attention can be focused on techniques of
> performance improvement and OS agnostics. In addition, the RAID code in
> that driver understands the hardware, CHIM & sequencer and takes
> advantage of features that just can not be performed by an abstracted dm
> or an LLD. RAID1 is handled under some conditions, for instance, with
> one DMA operation over the PCI bus rather than two duplicated for each
> target, greatly increasing the performance.

If you contributed that sequencer code and sent me a card I'm pretty sure
I'd love into adding support for this to a special DM module.  In fact we'd
need somthing similar for Certain SATA boards aswell.

OTOH the raid flag would be useless aswell there, because we'd of course
support this on identical cards without the raid bios aswell :)

