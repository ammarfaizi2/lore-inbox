Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278190AbRJLWzh>; Fri, 12 Oct 2001 18:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278191AbRJLWz0>; Fri, 12 Oct 2001 18:55:26 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:7781 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278190AbRJLWzR>; Fri, 12 Oct 2001 18:55:17 -0400
Date: Sat, 13 Oct 2001 00:55:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ortiz Samuel <sambaufr@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nr_local_pages and local_pages
Message-ID: <20011013005526.G714@athlon.random>
In-Reply-To: <20011012224527.14338.qmail@web12707.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011012224527.14338.qmail@web12707.mail.yahoo.com>; from sambaufr@yahoo.fr on Sat, Oct 13, 2001 at 12:45:27AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 12:45:27AM +0200, Ortiz Samuel wrote:
> Hi Andrea !                                           
>                                                       
>                                                       
>                                                       
>                                                       
>                                                       
>                                                       
>                                                       
> I spent some time reading the balance_classzone code,
> but there are still                                   
>                                                       
>                                                       
>  some stuff I can't get. The main ones are the meaning
> and use of the                                        
>                                                       
>                                                       
>  following fields in the task structure :             
>                                                       
>                                                       
>                                                       
> 
> - nr_local_pages                                      
>                                                       
>                                                       
>                                                       
> - local_pages
> 
> What are they for ? What do they mean ?

we're balancing memory synchronously because we need to recycle some
memory for ourself in order to succeed the allocation. Now if we succeed
in freeing some page we keep this page for ourself while we free the
next pages. So we work for ourself and not for somebody else. With the
"goto rebalance" this isn't required anymore to avoid failing
allocations, but still it should be good to provide better fariness, to
avoid somebody stuck freeing memory hard, and all other tasks eating the
free ram that such innocent task is producing in a starved loop.

Andrea
