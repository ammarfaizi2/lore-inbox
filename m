Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319226AbSIKQsP>; Wed, 11 Sep 2002 12:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319227AbSIKQsP>; Wed, 11 Sep 2002 12:48:15 -0400
Received: from [217.167.51.129] ([217.167.51.129]:50651 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S319226AbSIKQsO>;
	Wed, 11 Sep 2002 12:48:14 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Jens Axboe" <axboe@suse.de>, "Paul Mackerras" <paulus@samba.org>
Cc: <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] highmem I/O for ide-pmac.c
Date: Wed, 11 Sep 2002 20:53:15 +0200
Message-Id: <20020911185315.530@192.168.4.1>
In-Reply-To: <20020911130209.GL1089@suse.de>
References: <20020911130209.GL1089@suse.de>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>BTW, it would be ok to export that from ide-dma.c instead of duplicating
>it in ide-pmac.

It isn't. ide-pmac doesn't use the sg_table & other DMA related
fields in HWIF, but it's own copies in the "pmif" which is a
parallel data structure.

It sucks, I know, but I have to do that with the current IDE code
as the common code would make assumption about the format of these
things and it's right to dispose them in ide_unregister.

Also, Jens is right, Paul, you never call pmac_ide_toggle_bounce()
to actually enable high IOs. Add that to the ide_dma_on/check: case,
with an if (drive->using_dma) (as enabling DMA may have failed)

Or just wait for me to finish fixing my 6xx power save on idle
stuff and I'll send an updated patch to Marcelo along with other
pmac stuffs. (I'm implementing your suggestion of comparing SRR0
content in transfer_to_handler, but so far, the comparison never
seem to match, I'll find that out soon enough though).

Ben.




