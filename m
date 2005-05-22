Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVEVWBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVEVWBX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 18:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVEVWBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 18:01:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:20939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261724AbVEVWBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 18:01:21 -0400
Date: Sun, 22 May 2005 15:00:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [bugfix] try_to_unmap_cluster() passes out-of-bounds pte to
 pte_unmap()
Message-Id: <20050522150031.7a4058a2.akpm@osdl.org>
In-Reply-To: <20050522212734.GF2057@holomorphy.com>
References: <20050516021302.13bd285a.akpm@osdl.org>
	<20050522212734.GF2057@holomorphy.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> try_to_unmap_cluster() does:
>          for (pte = pte_offset_map(pmd, address);
>                          address < end; pte++, address += PAGE_SIZE) {
>  		...
>  	}
> 
>  	pte_unmap(pte);
> 
>  It may take a little staring to notice, but pte can actually fall off
>  the end of the pte page in this iteration,

That's about the third place we've had this bug.  Whoever keeps adding it
really should stop.

Thanks.
