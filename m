Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWC3GaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWC3GaZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 01:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWC3GaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 01:30:25 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:48032 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932065AbWC3GaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 01:30:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=pbR1/8xIV8LnwT9+6Fcm6v7+eMWjNefBMqWPSsm7PLpTp2KUumawxMbHZR0V1piH9z78idt6qYB9Yj7vmWndhntsQFyvqWMm9eVdte8L6WVJ9jmpHoJIG/kLgzkCy3zVBOWpeQe4nS5XA53JmQGkwLK8npkr7L2iuTB+1BLCMqg=  ;
Message-ID: <442B4EEB.6020407@yahoo.com.au>
Date: Thu, 30 Mar 2006 14:22:19 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Luke Yang <luke.adi@gmail.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] nommu page refcount bug fixing
References: <489ecd0c0603291905m7ebffff2j83809cc3c93595f1@mail.gmail.com>
In-Reply-To: <489ecd0c0603291905m7ebffff2j83809cc3c93595f1@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Yang wrote:

>Hi all,
>
>   The previous "nommu use compound pages" patch has a problem: when
>the pages allocated is not compound page (eg: slab allocator), the
>refcount value of every page still need to be set, otherwise the
>get/put_page() would free a single page improperly, such as in
>access_process_vm().
>
>

Yep, sorry this slipped into the kernel. It's my fault for not giving
Andrew a fix for it.

As you might know, page refcounting in nommu was already broken, so
I'm working on a proper solution to fix it.

In the meantime though, this is a step backwards and reintroduces
NOMMU special-casing in page refcounting. As a temporary fix, what I
think should happen is simply for all slab allocations to ask for
__GFP_COMP pages.

Could you check that fixes your problem?

Thanks,
Nick

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
