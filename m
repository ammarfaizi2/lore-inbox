Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWEHFSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWEHFSV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWEHFSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:18:21 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:7263 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932308AbWEHFSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:18:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xZ16G6ZGxNQE4to/Z9ndbGhdE6NNXe7SHR3OJwvItaApJbj58rmX/T3ufi1Zs0xaCztpILdxxH1LbTnQtnLfIhtlhtmkefJQvhP530cvD+CfmmMpFzQwtSYGgvKUDyBfAC3gnX7eLtUkZB4j0sTuwzZvd2EmR7kHx9FWC2BRwKk=  ;
Message-ID: <445ED495.3020401@yahoo.com.au>
Date: Mon, 08 May 2006 15:18:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Hua Zhong <hzhong@gmail.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] fix can_share_swap_page() when !CONFIG_SWAP
References: <Pine.LNX.4.64.0605071525550.2515@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0605071525550.2515@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong wrote:

>Hi,
>
>can_share_swap_page() is used to check if the page has the last reference. This avoids allocating a new page for COW if it's the last page.
>
>However, if CONFIG_SWAP is not set, can_share_swap_page() is defined as 0, thus always causes a copy for the last COW page. The below simple patch fixes it.
>
>I'm not sure if it's the best fix. Maybe we should rename can_share_swap_page() and move it out of swapfile.c. Comments?
>

Looks like a good patch, nice catch. You should run it past Hugh but tend to
agree it would be nice to reuse the out of line can_share_swap_page, 
which would
fold beautifully with PageSwapCache a constant 0.

Nick
--

Send instant messages to your online friends http://au.messenger.yahoo.com 
