Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265465AbRF1AsM>; Wed, 27 Jun 2001 20:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265464AbRF1AsC>; Wed, 27 Jun 2001 20:48:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19348 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265462AbRF1Ars>;
	Wed, 27 Jun 2001 20:47:48 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15162.32433.598824.599520@pizda.ninka.net>
Date: Wed, 27 Jun 2001 17:47:45 -0700 (PDT)
To: NIIBE Yutaka <gniibe@m17n.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swapin flush cache bug
In-Reply-To: <200106280041.f5S0fDr05278@mule.m17n.org>
In-Reply-To: <200106270051.f5R0pkl19282@mule.m17n.org>
	<Pine.LNX.4.21.0106270710050.1291-100000@freak.distro.conectiva>
	<200106280007.f5S07qQ04446@mule.m17n.org>
	<20010628012349.L1554@redhat.com>
	<200106280041.f5S0fDr05278@mule.m17n.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NIIBE Yutaka writes:
 > (2) Page got swapped in asynchronously, possibly by read-ahead
 > 
 >            Swap in
 >    [ Page ] <---- [ Disk ]
 > 	   K
 > 
 >    The I/O from disk goes through kernel virtual address K.
 >    We have cache entries indexed by K.

The I/O completion must flush the cache, not the VM subsystem.

You must implement cache flushing at the DMA tranfer end point
to fix the problem you are describing.

Later,
David S. Miller
davem@redhat.com
