Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbTBDLVJ>; Tue, 4 Feb 2003 06:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267229AbTBDLVJ>; Tue, 4 Feb 2003 06:21:09 -0500
Received: from [213.86.99.237] ([213.86.99.237]:27333 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267227AbTBDLVI>; Tue, 4 Feb 2003 06:21:08 -0500
Subject: Re: Compactflash cards dying?
From: David Woodhouse <dwmw2@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20030204112406.GB737@atrey.karlin.mff.cuni.cz>
References: <20030202223009.GA344@elf.ucw.cz>
	 <20030203073028.B4C2920BD9@dungeon.inka.de>
	 <20030203125449.GB480@elf.ucw.cz>
	 <1044313953.28406.44.camel@imladris.demon.co.uk>
	 <20030204112406.GB737@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044358231.3291.10.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 04 Feb 2003 11:30:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-04 at 11:24, Pavel Machek wrote:
> Well, if their translation layer at least *worked*, I'd be happy with
> it.

Would you? You fill up your FAT or EXT2 file system, then delete all
your files. There are lots and lots of sectors with now-unused data.

Then start filling it up again. 

To accommodate your writes, the underlying translation layer is busily
garbage-collecting all those blocks which are _unused_, copying them
from one part of the flash to another to collect 'fresh' copies of data
together while reclaiming space from 'obsoleted' copies of changed
sectors.

Or you manage to find a vendor who sells reliable cards, hence decide
it's actually usable for real medium-term storage and start using EXT3
on it. You write out all your metadata (or even all your data) twice to
the device, and it hits the flash twice, because you can't tie in to the
_underlying_ journalling which it's already doing.

I wouldn't be happy. 

-- 
dwmw2
