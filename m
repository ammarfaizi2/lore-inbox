Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285085AbRLFJpp>; Thu, 6 Dec 2001 04:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285084AbRLFJpg>; Thu, 6 Dec 2001 04:45:36 -0500
Received: from ns0.dhm-systems.de ([195.126.154.163]:46602 "EHLO
	ns0.dhm-systems.de") by vger.kernel.org with ESMTP
	id <S285074AbRLFJpZ> convert rfc822-to-8bit; Thu, 6 Dec 2001 04:45:25 -0500
Message-ID: <3C0F3E2C.D3B7D3C7@web-systems.net>
Date: Thu, 06 Dec 2001 10:45:16 +0100
From: Heinz-Ado Arnolds <Ado.Arnolds@dhm-systems.de>
Reply-To: Ado.Arnolds@dhm-systems.de
Organization: DHM GmbH & Co. KG
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en, fr, ru
MIME-Version: 1.0
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16: running *really* short on DMA buffers
In-Reply-To: <20011205182528.D1831-100000@gerard>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gérard Roudier wrote:
> 
> On Wed, 5 Dec 2001, Heinz-Ado Arnolds wrote:
> 
> > Hi all,
> >
> > I get the message "kernel: Warning - running *really* short on DMA
> > buffers" frequently with medium to heavy disk i/o (running several
> > tar and/or moving huge directories).
...
> So, they are the allocations internal to the scsi layer that may well
> exhaust the ISA DMA pool. This pool is divided into 512 bytes chunks.
> Under heavy reordering of IOs, it can get very fragmented and much memory
> being wasted as a result.
> 
> An immediate solution might be to hack the scsi code for it to allocate
> more memory.

I'm not an experienced kernel hacker. Please help me: would it be right
to increase the constant 2 in

   new_dma_sectors = 2 * SECTORS_PER_PAGE;
                     ^
in drivers/scsi/scsi_dma.c, scsi_resize_dma_pool() to 3 or 4 as a first
solution. Or is there an other place I should start?

> The error string in well known since years, so you shouldn't have missed
> it from sources. :-)
Sorry, my stupid fault. For sure, it's in drivers/scsi/scsi_merge.c.

Thanks for your attention

Ado

-- 
------------------------------------------------------------------------
  Heinz-Ado Arnolds                        Ado.Arnolds@web-systems.net
  Websystems GmbH                              +49 2234 1840-0 (voice)
  Max-Planck-Strasse 2, 50858 Koeln, Germany   +49 2234 1840-40  (fax)
