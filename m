Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263879AbUEXDrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbUEXDrz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 23:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263881AbUEXDrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 23:47:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:51609 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263879AbUEXDry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 23:47:54 -0400
Date: Sun, 23 May 2004 20:47:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <1085369393.15315.28.camel@gaston>
Message-ID: <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 May 2004, Benjamin Herrenschmidt wrote:
> 
> There is a subtle race which can cause set_pte to be called on ppc64 on
> a PTE that is already present (that normally doesn't happen for us) and
> which itself, in the proper race condition, can trigger a duplicate hash
> entry to be added to the hash table (very bad).

So how exactly can the pte already be present? It's definitely illegal, 
since if that actually happened, that would imply a memory leak (whatever 
previous page was there just got silently dropped). 

		Linus
