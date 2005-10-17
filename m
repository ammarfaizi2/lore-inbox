Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVJQJxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVJQJxr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVJQJxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:53:47 -0400
Received: from cantor.suse.de ([195.135.220.2]:906 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932236AbVJQJxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:53:46 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Date: Mon, 17 Oct 2005 11:53:54 +0200
User-Agent: KMail/1.8
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, torvalds@osdl.org,
       shai@scalex86.org
References: <20051017093654.GA7652@localhost.localdomain> <20051017025007.35ae8d0e.akpm@osdl.org>
In-Reply-To: <20051017025007.35ae8d0e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171153.56063.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 11:50, Andrew Morton wrote:

>
> This is an ia64 patch - what point was there in testing it on an x460?
>
> Is something missing here?

x86-64 shares that code with ia64.

The patch is actually not quite correct - in theory node 0 could be too small 
to contain the full swiotlb bounce buffers.

The real fix would be to get rid of the pgdata lists and just walk the 
node_online_map on bootmem.c. The memory hotplug guys have
a patch pending for this.

-Andi
