Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSEWRCg>; Thu, 23 May 2002 13:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316955AbSEWRCf>; Thu, 23 May 2002 13:02:35 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:4320 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316538AbSEWRCf>;
	Thu, 23 May 2002 13:02:35 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15597.8361.533679.563624@napali.hpl.hp.com>
Date: Thu, 23 May 2002 10:02:33 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, hugh@veritas.com,
        linux-kernel@vger.kernel.org, andrea@suse.de, torvalds@transmeta.com
Subject: Re: Q: PREFETCH_STRIDE/16
In-Reply-To: <20020523.093416.133929379.davem@redhat.com>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 23 May 2002 09:34:16 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  DaveM> I mentioned this 1 or 2 days ago in the TLB thread with
  DaveM> Linus, you pessimistically maintain a tiny bitmap per
  DaveM> mm_struct which keeps track of where mappings actually are.
  DaveM> You use some hash function on the virtual address to
  DaveM> determine the bit.  You clear it when the mm_struct is new,
  DaveM> and you just set bits when mappings are installed.  Very
  DaveM> simple.

  DaveM> Then all of these "walk all valid page tables" loops that
  DaveM> scan entire mostly empty pages of pgd/pmd/pte entries for no
  DaveM> reason can just check the bitmap instead.

  DaveM> Most of the exit overhead is in clear_page_tables walking
  DaveM> over entire pages.  It effectively flushes the cache unless
  DaveM> all you are doing is fork/exit/fork/exit

Sounds like something worth experimenting with.  I doubt you could
really avoid (effectively) flushing the caches, but even if there are
just a few zero bits in the bitmap at the time of the tear-down, a
fair amount of time could be saved.

	--david
