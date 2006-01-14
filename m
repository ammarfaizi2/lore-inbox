Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWANMsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWANMsD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 07:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWANMrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 07:47:51 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:48523 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751251AbWANMr3 (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sat, 14 Jan 2006 07:47:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=S0XAeDuT7xcA6ON33iL376u9KXXLnwImhZDBgNzc+vOBY1Ae3jqNLlUH5Cpa4roCC167N2H5FeUaExawnLmq72muqIhBiKxqMpRt/WBkBxR5Nqh+Jn37+KqMKm2bA5wie8yOXg1VEVy14hjVLJJjDP91+CbJ29QvLM9OGwx8F8s=  ;
Message-ID: <43C8F2DC.1090400@yahoo.com.au>
Date: Sat, 14 Jan 2006 23:47:24 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch] mm: cleanup bootmem
References: <43C8F198.3010609@yahoo.com.au>
In-Reply-To: <43C8F198.3010609@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Objections?
> 
> 
> ------------------------------------------------------------------------
> 
> The bootmem code added to page_alloc.c duplicated some page freeing code
> that it really doesn't need to because it is not so performance critical.
> 

... but actually it is possible that it ends up being faster with this
patch anyway, due to the old code freeing the pages as higher order
batches: they won't have to go through as many iterations in the buddy
allocator. This patch restores that behaviour as well.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
