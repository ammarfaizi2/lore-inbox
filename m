Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWEVGH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWEVGH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 02:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWEVGH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 02:07:28 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:46932 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932460AbWEVGH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 02:07:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ohFMdMXoOiEuQlQKe6ULrIJefLQANArSFnm5aAunnKatRmVkRVgsZVx6ZTcDc7u1EGBfCr+bV4tPyjwScWk8OaOiuq29laIGW2VXLcVTUylY0LcLG/nqpvr5GOs19VvZ0OOHHyGHS7i3d3XhHgIlX19Y0gORanBWSOXP2Hy3U/I=  ;
Message-ID: <4471551B.1070701@yahoo.com.au>
Date: Mon, 22 May 2006 16:07:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: __vmalloc with GFP_ATOMIC causes 'sleeping from invalid context'
References: <20060522013648.6FCEAEE9EE@wolfe.lmc.cs.sunysb.edu>	<447119B3.7000506@yahoo.com.au> <20060522055852.63940EE9EE@wolfe.lmc.cs.sunysb.edu>
In-Reply-To: <20060522055852.63940EE9EE@wolfe.lmc.cs.sunysb.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giridhar Pemmasani wrote:
> On Mon, 22 May 2006 11:53:55 +1000, Nick Piggin <nickpiggin@yahoo.com.au> said:
> 
>    > Giridhar Pemmasani wrote:
>   >> If __vmalloc is called in atomic context with GFP_ATOMIC flags,
>   >> __get_vm_area_node is called, which calls kmalloc_node with
>   >> GFP_KERNEL flags. This causes 'sleeping function called from
>   >> invalid context at mm/slab.c:2729' with 2.6.16-rc4 kernel. A
>   >> simple solution is to use
> 
>    > I can't see what would cause this in either 2.6.16-rc4 or
>    > 2.6.17-rc4.  What is the line?
> 
> If someone calls __vmalloc in atomic context (with GFP_ATOMIC flags):

OK I misunderstood your comment. I was looking for the caller.
Hmm, page_alloc.c does, but I don't know that it needs to be
atomic -- what happens if we just make that allocation GFP_KERNEL?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
