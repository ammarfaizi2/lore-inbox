Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266270AbSKLGs1>; Tue, 12 Nov 2002 01:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbSKLGs1>; Tue, 12 Nov 2002 01:48:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:27835 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266270AbSKLGs0>;
	Tue, 12 Nov 2002 01:48:26 -0500
Date: Mon, 11 Nov 2002 22:53:33 -0800 (PST)
Message-Id: <20021111.225333.122204472.davem@redhat.com>
To: hugh@veritas.com
Cc: akpm@digeo.com, dmccr@us.ibm.com, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flush_cache_page while pte valid 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0211120648170.1427-100000@localhost.localdomain>
References: <20021111.151929.31543489.davem@redhat.com>
	<Pine.LNX.4.44.0211120648170.1427-100000@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hugh Dickins <hugh@veritas.com>
   Date: Tue, 12 Nov 2002 06:53:04 +0000 (GMT)
   
   Thanks for shedding light on that; but I'm still wondering if there
   might be data loss if userspace modifies the page in the tiny window
   between correctly positioned flush_cache_page and pte invalidation?

The flush merely writes back the data, a copy-back operation, fully L2
cache coherent.  All cpus will see correct data if an intermittant
store occurs.
