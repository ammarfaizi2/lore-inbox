Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131472AbRDWHpb>; Mon, 23 Apr 2001 03:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131479AbRDWHpW>; Mon, 23 Apr 2001 03:45:22 -0400
Received: from ash.lnxi.com ([207.88.130.242]:37620 "EHLO DLT.linuxnetworx.com")
	by vger.kernel.org with ESMTP id <S131472AbRDWHpK>;
	Mon, 23 Apr 2001 03:45:10 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Longstanding elf fix (2.4.3 fix)
In-Reply-To: <m31yqk8oas.fsf@DLT.linuxnetworx.com> <15075.40500.408470.152332@pizda.ninka.net>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 23 Apr 2001 01:44:57 -0600
In-Reply-To: "David S. Miller"'s message of "Sun, 22 Apr 2001 20:15:00 -0700 (PDT)"
Message-ID: <m3snj0giva.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> Eric W. Biederman writes:
>  > In building a patch for 2.4.3 I also discovered that we are not taking 
>  > the mmap_sem around do_brk in the exec paths.
> 
> Does that really matter?  

In the library loader I can certainly see it making a difference.

> Who else can get at the address space?
>  We are a singly referenced address space at that point... perhaps ptrace?

In practice I don't see it being a big deal.  But reliable code is
made by closing all of the little loop holes.  

It also improves consistency as all of the calls to do_mmap are
already protected in the exec paths. 

And of course since much of the code in the kernel is built on the
copy a good example neglecting the locking without a big comment,
invites trouble elsewhere like in elf_load_library.  Where we could
have multiple threads running.  

Eric
