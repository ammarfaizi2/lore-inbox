Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312939AbSCZEFi>; Mon, 25 Mar 2002 23:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312942AbSCZEF2>; Mon, 25 Mar 2002 23:05:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33687 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312939AbSCZEFL>;
	Mon, 25 Mar 2002 23:05:11 -0500
Date: Mon, 25 Mar 2002 20:00:31 -0800 (PST)
Message-Id: <20020325.200031.118818331.davem@redhat.com>
To: bcrl@redhat.com
Cc: andrea@suse.de, marcelo@conectiva.com.br, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mmap bug with drivers that adjust vm_start
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020325230046.A14421@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Mon, 25 Mar 2002 23:00:47 -0500

   The patch below fixes a problem whereby a vma which has its vm_start 
   address changed by the file's mmap operation can result in the vma 
   being inserted into the wrong location within the vma tree.  This 
   results in page faults not being handled correctly leading to SEGVs, 
   as well as various BUG()s hitting on exit of the mm.  The fix is to 
   recalculate the insertion point when we know the address has changed.  
   Comments?  Patch is against 2.4.19-pre4.

Good catch.  Most of the time this happened to work because the driver
filled in the page tables completely (as is the case for most video
etc. drivers which use {io_,}remap_page_range et al..)

