Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317494AbSFDNTt>; Tue, 4 Jun 2002 09:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317496AbSFDNTs>; Tue, 4 Jun 2002 09:19:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40100 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317494AbSFDNTs>;
	Tue, 4 Jun 2002 09:19:48 -0400
Date: Tue, 04 Jun 2002 06:16:40 -0700 (PDT)
Message-Id: <20020604.061640.118624496.davem@redhat.com>
To: jasonp@boo.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page coloring for 2.4.18 kernel
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3.0.6.32.20020407110100.007c2b70@boo.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jason Papadopoulos <jasonp@boo.net>
   Date: Sun, 07 Apr 2002 11:01:00 -0400

   Hello. This is a re-diff of the 2.4.17 patch I posted
   previously.
   
   www.boo.net/~jasonp/page_color-2.2.20-20020108.patch
   www.boo.net/~jasonp/page_color-2.4.17-20020113.patch
   www.boo.net/~jasonp/page_color-2.4.18-20020323.patch
   
   I'm not subscribed to LKML, so please cc responses
   to this email address.

Hi Jason.  I noticed that your code assumes zones begin on well
aligned physical addresses.  This is not true.

For example, in page_color_start you use the raw
(page - zone->zone_mem_map) index as the color.  This
is wrong, what if the zone starts at page 1?  In such
a case all of your colors will be computed incorrectly
and pages with different colors in different zones can actually be of
the same color.
