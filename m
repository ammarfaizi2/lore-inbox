Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVEPUTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVEPUTR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVEPUQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:16:40 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:15238 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261854AbVEPUO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:14:26 -0400
Subject: Re: [PATCH] Factor in buddy allocator alignment requirements in
	node memory alignment
From: Dave Hansen <haveblue@us.ibm.com>
To: christoph <christoph@scalex86.org>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0505161204540.4977@ScMPusgw>
References: <Pine.LNX.4.62.0505161204540.4977@ScMPusgw>
Content-Type: text/plain
Date: Mon, 16 May 2005 13:14:11 -0700
Message-Id: <1116274451.1005.106.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 12:05 -0700, christoph wrote:
> Memory for nodes on i386 is currently aligned on 2 MB boundaries.
> However, the buddy allocator needs pages to be aligned on
> PAGE_SIZE << MAX_ORDER which is 8MB if MAX_ORDER = 11.

Why do you need this?  Are you planning on allowing NUMA KVA remap pages
to be handed over to the buddy allocator?  That would be a major
departure from what we do now, and I'd be very interested in seeing how
that is implemented before a infrastructure for it goes in.

BTW, how sure are you that those alignment restrictions really still
exist?  Some of them went away when we got rid of the buddy bitmap.  You
might want to check that you definitely need this.

-- Dave

