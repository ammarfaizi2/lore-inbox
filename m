Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289104AbSAVAhK>; Mon, 21 Jan 2002 19:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289106AbSAVAgv>; Mon, 21 Jan 2002 19:36:51 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29792 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289104AbSAVAgq>; Mon, 21 Jan 2002 19:36:46 -0500
Date: Tue, 22 Jan 2002 01:37:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: reid.hekman@ndsu.nodak.edu, linux-kernel@vger.kernel.org, akpm@zip.com.au,
        alan@lxorg.ukuu.org
Subject: Re: Athlon PSE/AGP Bug
Message-ID: <20020122013743.M8292@athlon.random>
In-Reply-To: <1011610422.13864.24.camel@zeus> <20020121.053724.124970557.davem@redhat.com> <20020121175410.G8292@athlon.random> <20020121.141931.105134927.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020121.141931.105134927.davem@redhat.com>; from davem@redhat.com on Mon, Jan 21, 2002 at 02:19:31PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 02:19:31PM -0800, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Mon, 21 Jan 2002 17:54:10 +0100
>    
>    correct, furthmore it cannot even trigger if you invlpg with an address
>    page aligned (4mbyte aligned in this case) like we would always do in
>    linux anyways, we never use invlpg on misaligned addresses, no matter if
>    the page is a 4M or a 4k page.
> 
> That's not true, see the ptrace() helper code.  Russell King pointed
> this out to me last week and it's on my TODO list to fix it up.

Where? :) ptrace doesn't change pagetables, no need to flush any tlb in
ptrace.

Anyways if the problem is in the nvidia driver they may be really doing
an invlpg on a misaligned 4M page address for no good reason, this
sounds unlikely though.  What's certain is that the stuff into the
mainline kernel shouldn't really be affected for the reason you also
said previously (we never invalidate 4M pages with invlpg). In the very
worst case nvidia guys just need to mask the lower (not significant)
bits before passing the address to invlpg, which is going to be a one
liner.

Andrea
