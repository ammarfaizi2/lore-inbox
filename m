Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWDXX6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWDXX6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 19:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWDXX6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 19:58:36 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:49278 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932133AbWDXX6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 19:58:35 -0400
In-Reply-To: <20060424165252.1282e0f0.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
MIME-Version: 1.0
Subject: Re: [patch 5/13] s390: qdio memory allocations.
X-Mailer: Lotus Notes Release 6.5.1IBM February 19, 2004
From: Andreas Herrmann <AHERRMAN@de.ibm.com>
Message-ID: <OFC48E751F.153A4DE1-ON4225715A.008357F1-4225715A.0083847B@de.ibm.com>
Date: Tue, 25 Apr 2006 01:59:36 +0200
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 25/04/2006 01:59:38,
	Serialize complete at 25/04/2006 01:59:38
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.2006 01:52 Andrew Morton <akpm@osdl.org> wrote:
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> >
> > -   ssqd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> > +   ssqd_area = mempool_alloc(qdio_mempool_scssc, GFP_ATOMIC);

> I assume the loss of GFP_DMA was intentional?

Yes, and it is done in the alloc routine of the mempool:

  static void *qdio_mempool_alloc(gfp_t gfp_mask, void *size)
  {
          return (void *) get_zeroed_page(gfp_mask|GFP_DMA);
  }


Regards,

Andreas

