Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280033AbRKDRJ2>; Sun, 4 Nov 2001 12:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280034AbRKDRJS>; Sun, 4 Nov 2001 12:09:18 -0500
Received: from cogito.cam.org ([198.168.100.2]:3855 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S280033AbRKDRJJ>;
	Sun, 4 Nov 2001 12:09:09 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [RFC][PATCH] vm_swap_full
To: linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Sun, 04 Nov 2001 12:04:35 -0500
In-Reply-To: <Pine.LNX.4.33L.0111041436020.2963-100000@imladris.surriel.com>
Organization: me
User-Agent: KNode/0.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20011104170436.5721DC4E8@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> On Sun, 4 Nov 2001, Ed Tomlinson wrote:
> 
>> -/* Swap 50% full? Release swapcache more aggressively.. */
>> -#define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
>> +/* Free swap less than inactive pages? Release swapcache more
>> aggressively.. */ +#define vm_swap_full() (nr_swap_pages <
>> nr_inactive_pages)
> 
>> Comments?
> 
> Makes absolutely no sense for systems which have more
> swap than RAM, eg. a 64MB system with 200MB of swap.

My thinking was allong these lines.  At a given instant in time the max we
have that might get swapped out is the inactive list.  So if we start 
aggressive swapping when we have less swap than the size of the inactive 
list we should be ok.  The premise being that leaving swap mapped can be
a win for pages swapped in but not changed.

Ed Tomlinson


