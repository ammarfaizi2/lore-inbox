Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265461AbRF1ArC>; Wed, 27 Jun 2001 20:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265462AbRF1Aqw>; Wed, 27 Jun 2001 20:46:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17556 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265461AbRF1Aqj>;
	Wed, 27 Jun 2001 20:46:39 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15162.32364.931688.672746@pizda.ninka.net>
Date: Wed, 27 Jun 2001 17:46:36 -0700 (PDT)
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: NIIBE Yutaka <gniibe@m17n.org>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swapin flush cache bug
In-Reply-To: <20010628012349.L1554@redhat.com>
In-Reply-To: <200106270051.f5R0pkl19282@mule.m17n.org>
	<Pine.LNX.4.21.0106270710050.1291-100000@freak.distro.conectiva>
	<200106280007.f5S07qQ04446@mule.m17n.org>
	<20010628012349.L1554@redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen C. Tweedie writes:
 > I really want somebody who has worked on weird caching architectures
 > to look at it too, but I don't see that the new code works well.
 > First, don't we want to do a flush_page_to_ram() *before* starting the
 > swap IO?  There's no point dma'ing the swap page to ram if old, dirty
 > cache data is then going to be written back on top of that.
 > 
 > Secondly, the flushing of icache/dcache only needs to be done by the
 > time we come to use the page, so can be performed any time, before or
 > after the IO.  We're not going to be accessing the page during IO so
 > if we flush first we won't risk having stale cache data by the time
 > the IO completes.
 > 
 > So, why not just do the flushing before the IO?  Adding an async trap
 > to flush the page after swap IO seems the wrong approach: this should
 > be possible to fix synchronously.

People are totally confusing two completely seperate issues here.

Flushing for I/O <--> CPU coherency.

Flushing for CPU <--> CPU coherency.

flush_page_to_ram and flush_dcache_page are _ONLY_ for the CPU<-->CPU
coherency issues, not for I/O<-->CPU issues.

The I/O<-->CPU issues need to be handled elsewhere, for example in the
PCI dma mapping interface implementation.

Later,
David S. Miller
davem@redhat.com
