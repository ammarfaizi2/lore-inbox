Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318249AbSG3MqQ>; Tue, 30 Jul 2002 08:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318250AbSG3MqQ>; Tue, 30 Jul 2002 08:46:16 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:31733 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318249AbSG3MqP>; Tue, 30 Jul 2002 08:46:15 -0400
Date: Tue, 30 Jul 2002 08:49:39 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29
Message-ID: <20020730084939.A8978@redhat.com>
References: <20020730054111.GA1159@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020730054111.GA1159@dualathlon.random>; from andrea@suse.de on Tue, Jul 30, 2002 at 07:41:11AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 07:41:11AM +0200, Andrea Arcangeli wrote:
> instead of separate syscalls for the various async_io
> PREAD/PREADX/PWRITE/FSYNC/POLL operations there is just a single entry
> point and a parameters specify the operation. But this is what the
> current userspace expects and I wouldn't have too much time to change it
> anyways because then I would break all the userspace libs too (I just
> break them because of the true syscalls instead of passing through the
> /proc/libredhat that calls into the dynamic syscall, but that's not
> too painful to adapt). And after all even the io_submit isn't too bad
> besides the above slowdown in the multiplexing (at least it's sharing
> some icache for top/bottom of the functionality).

What would you suggest as an alternative API?  The main point of multiplexing 
is that ios can be submitted in batches, which can't be done if the ios are 
submitted via individual syscalls, not to mention the overlap with the posix 
aio api.

> checked that it still compiles fine on x86 (all other archs should keep
> compiling too). available also from here:
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.5/2.5.29/aio-api-1
> 
> Comments are welcome, many thanks.

That's the old cancellation API.  Anyways, the core is pretty much ready, so 
don't bother with this patch.

		-ben
