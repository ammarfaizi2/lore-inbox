Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289973AbSAWTIE>; Wed, 23 Jan 2002 14:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289974AbSAWTHy>; Wed, 23 Jan 2002 14:07:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:9600 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289973AbSAWTHj>;
	Wed, 23 Jan 2002 14:07:39 -0500
Date: Wed, 23 Jan 2002 11:06:24 -0800 (PST)
Message-Id: <20020123.110624.93021436.davem@redhat.com>
To: riel@conectiva.com.br
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH *] rmap VM, version 12
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0201231650450.32617-100000@imladris.surriel.com>
In-Reply-To: <20020123.104438.71552152.davem@redhat.com>
	<Pine.LNX.4.33L.0201231650450.32617-100000@imladris.surriel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Wed, 23 Jan 2002 16:57:58 -0200 (BRST)

   On Wed, 23 Jan 2002, David S. Miller wrote:
   
   > The problem is that when vmalloc() or whatever kernel mappings change
   > you have to update all the quicklist page tables to match.
   
   Actually, this is just using the pte_free_fast() and
   {get,free}_pgd_fast() functions on non-pae machines.
   
Rofl, you can't just do that.  The page tables cache caches the kernel
mappings and if you don't update them properly on SMP you die.

I am seeing reports of SMP failing with rmap12 but not previous
patches.  You need to revert this I think.
