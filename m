Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287421AbSAUQxc>; Mon, 21 Jan 2002 11:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287425AbSAUQxW>; Mon, 21 Jan 2002 11:53:22 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31504 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287421AbSAUQxU>; Mon, 21 Jan 2002 11:53:20 -0500
Date: Mon, 21 Jan 2002 17:54:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: reid.hekman@ndsu.nodak.edu, linux-kernel@vger.kernel.org, akpm@zip.com.au,
        alan@lxorg.ukuu.org
Subject: Re: Athlon PSE/AGP Bug
Message-ID: <20020121175410.G8292@athlon.random>
In-Reply-To: <1011610422.13864.24.camel@zeus> <20020121.053724.124970557.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020121.053724.124970557.davem@redhat.com>; from davem@redhat.com on Mon, Jan 21, 2002 at 05:37:24AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 05:37:24AM -0800, David S. Miller wrote:
>    From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
>    Date: 21 Jan 2002 04:53:39 -0600
>    
>    As I have a couple systems that may/may not be affected, I'm seeking
>    some clarification. Is this an effect of the errata published by AMD in
>    the Athlon models 4 & 6 revision guides as "INVLPG Instruction Does Not
>    Flush Entire Four-Megabyte Page Properly with Certain Linear Addresses"?
>    That errata lists all Athlon Thunderbirds as affected and all Athlon
>    Palominos except for stepping A5. 
>    
>    Regardless of specific errata listings, will future workarounds be
>    enabled based on cpuid or via a test for the bug itself?
> 
> The funny part is, if this published errata is the problem, it cannot
> be a problem under Linux since we never invalidate 4MB pages.  We
> create them at boot time and they never change after that.

correct, furthmore it cannot even trigger if you invlpg with an address
page aligned (4mbyte aligned in this case) like we would always do in
linux anyways, we never use invlpg on misaligned addresses, no matter if
the page is a 4M or a 4k page.  And I guess with PAE enabled it cannot
even trigger in first place (it speaks only about 4M pages, pae only
provides 2M pages instead).

I think this is a very very minor issue, I doubt anybody ever triggered
it in real life with linux.

And Gentoo is shipping a kernel with preempt and rmaps included, so it
can crash anytime anyways, no matter how good the cpu is, so if they
got crashes with such a kernel (maybe even with nvidia driver) that's
normal. I was speaking today with a trusted party doing vm benchmarking
and rmap crashes the kernel reproducibly under a stright calloc while
swapping heavily, so clearly the implementation is still broken. preempt
additionally will mess up all the locking into the nvidia driver as
well. so if the combination of the two runs for some time without any
lockup that's pure luck IMHO.

Andrea
