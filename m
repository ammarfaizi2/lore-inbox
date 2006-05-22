Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWEVBx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWEVBx7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 21:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWEVBx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 21:53:59 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:854 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964983AbWEVBx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 21:53:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=EKFcoWVn1DQ7TxnZY7G0DRM+KOonP217QXzHkhA4zQ95LCdn2qIKf5eg5mD2DIDYdVRCWkKchArCttRF46VS7AZZI/gJbIqBQEM8rt49qhrWwfMtbI6GspWnB7UUKtCgJh+cq5vkKcmCzS2xfERVnsxW8CEicAeutBdsnmIxhjA=  ;
Message-ID: <447119B3.7000506@yahoo.com.au>
Date: Mon, 22 May 2006 11:53:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: __vmalloc with GFP_ATOMIC causes 'sleeping from invalid context'
References: <20060522013648.6FCEAEE9EE@wolfe.lmc.cs.sunysb.edu>
In-Reply-To: <20060522013648.6FCEAEE9EE@wolfe.lmc.cs.sunysb.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giridhar Pemmasani wrote:
> If __vmalloc is called in atomic context with GFP_ATOMIC flags,
> __get_vm_area_node is called, which calls kmalloc_node with GFP_KERNEL
> flags. This causes 'sleeping function called from invalid context at
> mm/slab.c:2729' with 2.6.16-rc4 kernel. A simple solution is to use

I can't see what would cause this in either 2.6.16-rc4 or 2.6.17-rc4.
What is the line?

> proper flags in __get_vm_area_node, depending on the context:

I don't think that always works, you might pass in GFP_ATOMIC due to
having hold of a spinlock, for example.

Also, vmlist_lock isn't interrupt safe, so it still kind of goes
against the spirit of GFP_ATOMIC (which is to allow allocation from
interrupt context).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
