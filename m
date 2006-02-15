Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWBOKyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWBOKyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 05:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWBOKyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 05:54:40 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:30087 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751124AbWBOKyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 05:54:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=mzgE1lLHY+jXG8xTn72FzX04x5cAR9UBdw+qx/PZbbKIyfTSLqEbrMyavT0KdJwEmMs+PskJt8+EpAwI2PQKrL33/dHrGbiW2aQ0MpjsuWrxHi8lKcAsK4I9D4JeED1LaMBzIvSLxPh0pL8IB41uQcAhkgNOQ2juxid8lJgVX4k=  ;
Message-ID: <43F2EDD6.7000204@yahoo.com.au>
Date: Wed, 15 Feb 2006 20:01:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] make sysctl_overcommit_memory enumeration sensible
References: <20060215085456.GA2481@localhost.localdomain>
In-Reply-To: <20060215085456.GA2481@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> I see system admins often confused when they sysctl vm.overcommit_memory.
> This patch makes overcommit_memory enumeration sensible.
> 

What's the point? The current has been there for a long time, and
is well documented.

> 0 - no overcommit
> 1 - always overcommit
> 2 - heuristic overcommit (default)
> 
> I don't feel this would break any userspace scripts.

You mean, except for the ones that go `echo 0 > /proc/sys/vm/overcommit_memory`;
or `echo 2 > /proc/sys/vm/overcommit_memory` ?

And those sysctl configuration files that get set at bootup?

> If it seems OK, I'll
> update the documents.
> 
> Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
> ---
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index 18a5689..e50f5ad 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -10,9 +10,9 @@
>  #define MREMAP_MAYMOVE	1
>  #define MREMAP_FIXED	2
>  
> -#define OVERCOMMIT_GUESS		0
> +#define OVERCOMMIT_NEVER		0
>  #define OVERCOMMIT_ALWAYS		1
> -#define OVERCOMMIT_NEVER		2
> +#define OVERCOMMIT_GUESS		2
>  extern int sysctl_overcommit_memory;
>  extern int sysctl_overcommit_ratio;
>  extern atomic_t vm_committed_space;
> 


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
