Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSHCDQt>; Fri, 2 Aug 2002 23:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317424AbSHCDQt>; Fri, 2 Aug 2002 23:16:49 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:8434 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317399AbSHCDQs>;
	Fri, 2 Aug 2002 23:16:48 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15691.19423.265864.413887@napali.hpl.hp.com>
Date: Fri, 2 Aug 2002 20:19:59 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Hubertus Franke <frankeh@watson.ibm.com>,
       <Martin.Bligh@us.ibm.com>, <wli@holomorpy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd) 
In-Reply-To: <Pine.LNX.4.33.0208021219160.2229-100000@penguin.transmeta.com>
References: <E17ahdi-0001RC-00@w-gerrit2>
	<Pine.LNX.4.33.0208021219160.2229-100000@penguin.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 2 Aug 2002 12:34:08 -0700 (PDT), Linus Torvalds <torvalds@transmeta.com> said:

  Linus> We may well expand the FS layer to bigger pages, but "bigger"
  Linus> is almost certainly not going to include things like 256MB
  Linus> pages - if for no other reason than the fact that memory
  Linus> fragmentation really means that the limit on page sizes in
  Linus> practice is somewhere around 128kB for any reasonable usage
  Linus> patterns even with gigabytes of RAM.

  Linus> And _maybe_ we might get to the single-digit megabytes. I
  Linus> doubt it, simply because even with a good buddy allocator and
  Linus> a memory manager that actively frees pages to get large
  Linus> contiguous chunks of RAM, it's basically impossible to have
  Linus> something that can reliably give you that big chunks without
  Linus> making normal performance go totally down the toiled.

The Rice people avoided some of the fragmentation problems by
pro-actively allocating a max-order physical page, even when only a
(small) virtual page was being mapped.  This should work very well as
long as the total memory usage (including memory lost due to internal
fragmentation of max-order physical pages) doesn't exceed available
memory.  That's not a condition which will hold for every system in
the world, but I suspect it is true for lots of systems for large
periods of time.  And since superpages quickly become
counter-productive in tight-memory situations anyhow, this seems like
a very reasonable approach.

	--david
