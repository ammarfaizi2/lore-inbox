Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315817AbSEJGfT>; Fri, 10 May 2002 02:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315818AbSEJGfS>; Fri, 10 May 2002 02:35:18 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:60119 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315817AbSEJGfR>;
	Fri, 10 May 2002 02:35:17 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15579.27172.621514.289282@napali.hpl.hp.com>
Date: Thu, 9 May 2002 23:35:16 -0700
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: maximum block size in buffer_head
In-Reply-To: <3CDB5CC5.2621C68C@zip.com.au>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 09 May 2002 22:38:13 -0700, Andrew Morton <akpm@zip.com.au> said:

  Andrew> Sounds OK to me for 2.5.

Will you make the change then?  I'd appreciate that.

  Andrew> For 2.4, a 32-bit b_size would push sizeof(buffer_head) from
  Andrew> 96 up to 100 bytes, which does not pack as well into the
  Andrew> slab.  This would be an intensely unpopular move.  So you'd
  Andrew> have to ifdef it.  Which makes it an ia64-only problem,
  Andrew> which greatly improves your merge chances ;)

For 2.4, I suspect I need to keep this in the ia64 patch anyhow
because it is also necessary to fix scsi_dma.c so it can deal with
allocation bitmaps that are bigger than 32 bits.

I believe ia64 is currently the only platform that supports 64KB
pages.  If so, there is probably not much point trying to get this
past Marcelo (and the patch is large enough to have the potential for
introducing new bugs).  If another platform cares about this, please
speak up.

  >> - does anyone know of any other code paths where the block size
  >> is assumed to fit into 16 bits?

  Andrew> Not off the top, but they're probably there.

I'll keep an eye on it.  It's working fine so far, but that doesn't
replace a code audit.  If you happen to bump into something during
your normal work, please let me know.

Thanks,

	--david
