Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266962AbSKLVky>; Tue, 12 Nov 2002 16:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266966AbSKLVky>; Tue, 12 Nov 2002 16:40:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:48832 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266962AbSKLVkx>;
	Tue, 12 Nov 2002 16:40:53 -0500
Date: Tue, 12 Nov 2002 13:45:52 -0800 (PST)
Message-Id: <20021112.134552.04696764.davem@redhat.com>
To: riel@conectiva.com.br
Cc: hugh@veritas.com, akpm@digeo.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flush_cache_page while pte valid 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44L.0211121248540.3817-100000@imladris.surriel.com>
References: <20021111.225333.122204472.davem@redhat.com>
	<Pine.LNX.4.44L.0211121248540.3817-100000@imladris.surriel.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Tue, 12 Nov 2002 12:49:50 -0200 (BRST)

   On Mon, 11 Nov 2002, David S. Miller wrote:
   > The flush merely writes back the data, a copy-back operation, fully L2
   > cache coherent.  All cpus will see correct data if an intermittant
   > store occurs.
   
   The CPUs will, but the harddisk might not.
   
   We really need to get this right in the swapout path.

We do get it right, watch:

1) remove last mapping instance of page

   -> MM level cache flush pushes it permanently to ram
      in full view of DMA activity

2) remove last mapping, but new one appears as we swap out

   -> no problem we'll see one of several instances of the
      page and we'll need to reswap it out later anyways
      if someone currently writes to it

I know this because I tested this extensively ages ago on sparc32
where it really mattered.
