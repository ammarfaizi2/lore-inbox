Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263672AbUCUQYF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 11:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263674AbUCUQYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 11:24:05 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:28434 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263672AbUCUQYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 11:24:02 -0500
Date: Sun, 21 Mar 2004 16:24:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-aa1
Message-ID: <20040321162401.A8778@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20040321145547.GA3649@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040321145547.GA3649@dualathlon.random>; from andrea@suse.de on Sun, Mar 21, 2004 at 03:55:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A bunch of rather cosmetic comments while looking over the patch:

 - all the binfmt handler seems to copy exactly the same vma setup,
   maybe we should add a helper for that?
 - the struct anon_vma_s / anon_vma_t naming is awkward, why not just
   struct anon_vma *insert reference to Documentation/CodingStyle here*
 - the inclusion guards in objrmap.h are wrong
 - why is PG_swapcache bit 21?  You removed PG_direct so bit 16 is free now
 - I don't really like the swapper space special case in ___add_to_page_cache,
   IIRC there's only one caller of it for the swapper space and IMHO you're
   better off opencoding it
 - dito for __remove_from_page_cache 
 - is renaming rmap.c to objrmap.c really nessecary?  It contains about
   the same functions, and keeping the old, implementation-agnostic name
   makes it easiert to follow the radical changes..
