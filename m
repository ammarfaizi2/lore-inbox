Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277608AbRJHXaW>; Mon, 8 Oct 2001 19:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277607AbRJHXaN>; Mon, 8 Oct 2001 19:30:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12167 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277608AbRJHX3x>;
	Mon, 8 Oct 2001 19:29:53 -0400
Date: Mon, 08 Oct 2001 16:29:35 -0700 (PDT)
Message-Id: <20011008.162935.21930065.davem@redhat.com>
To: pmanolov@Lnxw.COM
Cc: linux-kernel@vger.kernel.org
Subject: Re: discontig physical memory
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BC23441.1EF944A2@lnxw.com>
In-Reply-To: <3BC22EA6.696604E7@lnxw.com>
	<20011008.160528.85686937.davem@redhat.com>
	<3BC23441.1EF944A2@lnxw.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Petko Manolov <pmanolov@Lnxw.COM>
   Date: Mon, 08 Oct 2001 16:18:25 -0700

   I already did that. I fixed MAX_DMA_ADDRESS and the
   kernel now reports:
   
   zone(0): 1024 pages
   zone(1): 7168 pages	/* this should be 4096 */
   ...
   
   Which is not true as we have a gap between 4 - 16MB
   phys memory. I also played with add_memory_region(),
   but the kernel still think we have 32MB ram instead
   of 20MB as is the case.
   
You need to setup bootmem correctly, earlier on, such that
you do not tell the kernel that there are any pages in this
4 - 16MB region.

Do something like this instead of whatever your bootmem
calls are doing now:

	bootmap_size = init_bootmem(0, (32 * 1024 * 1024));
	free_bootmem((4 * 1024 * 1024),
		     ((16 - 4) * 1024 * 1024));

Franks a lot,
David S. Miller
davem@redhat.com

