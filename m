Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbTIPHcZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 03:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTIPHcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 03:32:25 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:50100 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261793AbTIPHcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 03:32:19 -0400
Date: Tue, 16 Sep 2003 09:32:09 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030916073209.GC12329@wohnheim.fh-wedel.de>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU> <20030916065553.GA12329@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030916065553.GA12329@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 September 2003 08:55:53 +0200, Jörn Engel wrote:
> On Mon, 15 September 2003 21:35:46 -0700, David Yu Chen wrote:
> > 
> > [FILE:  2.6.0-test5/drivers/mtd/chips/cfi_cmdset_0020.c]
> > [FUNC:  cfi_staa_setup]
> > [LINES: 191-211]
> > [VAR:   mtd]
> >  186:	struct mtd_info *mtd;
> >  187:	unsigned long offset = 0;
> >  188:	int i,j;
> >  189:	unsigned long devsize = (1<<cfi->cfiq->DevSize) * cfi->interleave;
> >  190:
> > START -->
> >  191:	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);
> >  192:	//printk(KERN_DEBUG "number of CFI chips: %d\n", cfi->numchips);
> >  193:
> >  194:	if (!mtd) {
> >  195:		printk(KERN_ERR "Failed to allocate memory for MTD device\n");
> >  196:		kfree(cfi->cmdset_priv);
> >         ... DELETED 9 lines ...
> >  206:	mtd->eraseregions = kmalloc(sizeof(struct mtd_erase_region_info) 
> >  207:			* mtd->numeraseregions, GFP_KERNEL);
> >  208:	if (!mtd->eraseregions) { 
> >  209:		printk(KERN_ERR "Failed to allocate memory for MTD erase region info\n");
> >  210:		kfree(cfi->cmdset_priv);
> > END -->
> >  211:		return NULL;
> >  212:	}
> >  213:	
> >  214:	for (i=0; i<cfi->cfiq->NumEraseRegions; i++) {
> >  215:		unsigned long ernum, ersize;
> >  216:		ersize = ((cfi->cfiq->EraseRegionInfo[i] >> 8) & ~0xff) * cfi->interleave;
> 
> Valid.

This should be fixed by finally taking the time and merging the
command sets 0001 and 0020.  Maybe someone who cares will come up with
a patch.

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra
