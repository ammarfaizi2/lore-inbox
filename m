Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315790AbSEJDyW>; Thu, 9 May 2002 23:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315791AbSEJDyV>; Thu, 9 May 2002 23:54:21 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:34754 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S315790AbSEJDyU>; Thu, 9 May 2002 23:54:20 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Peter Chubb <peter@chubb.wattle.id.au>
Date: Fri, 10 May 2002 13:53:45 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15579.17481.944696.129323@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, martin@dalecki.de
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: message from Peter Chubb on Friday May 10
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday May 10, peter@chubb.wattle.id.au wrote:
> 
> Hi,
> 	At present, linux is limited to 2TB filesystems even on 64-bit
> systems, because there are various places where the block offset on
> disc are assigned to unsigned or int 32-bit variables.
> 
> There's a type, sector_t, that's meant to hold offsets in sectors and
> blocks.  It's not used consistently (yet).
> 
> The patch at
>     http://www.gelato.unsw.edu.au/patches/2.5.14-largefile-patch

> 
> As this touches lots of places -- the generic block layer (Andrew?)
> the IDE code (Martin?) and RAID (Neil?) and minor changes to the scsi
> I've CCd a few people directly.
> 

Thanks.
MD part looks sane to me. However I would rather the
 
+#ifdef CONFIG_LFS
+#include <asm/div64.h>
+#else
+#undef do_div
+#define do_div(n, b)({ int _res; _res = (n) % (b); (n) /= (b); _res;})
+#endif
+

part went in linux/raid/md_k.h and defined "sector_div" (or similar)
as either do_div or ({ int _res; _res = (n) % (b); (n) /= (b); _res;})
as appropriate.

NeilBrown
