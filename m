Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSEVDLV>; Tue, 21 May 2002 23:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316840AbSEVDLU>; Tue, 21 May 2002 23:11:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61136 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316838AbSEVDLT>;
	Tue, 21 May 2002 23:11:19 -0400
Date: Tue, 21 May 2002 19:57:16 -0700 (PDT)
Message-Id: <20020521.195716.84584338.davem@redhat.com>
To: torvalds@transmeta.com
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.17
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0205211933490.989-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Tue, 21 May 2002 19:40:08 -0700 (PDT)
   
   The early switch would at least on x86 be likely to result in the minimal
   amount of TLB flushing theoretically possible. Which I kind of like (if
   you can _prove_ that you cannot do better, you're in a good position ;).
   
Probably on sparc64 too.  The simplest way to kill off a TLB context
on sparc64 at exit_mmap() is to just mark it invalid (this means just
clearing the cpu_vm_mask of the mm_struct using that context PID).

It is even simpler than that, at exit_mmap() time we are destroying
the mm_struct anyways, nobody references it, and thus destroy_context
does all of the work.

Unfortunately, today mmdrop() (which is where destroy_context is
invoked) happens after exit_mmap().

Maybe some kind of "switch_from_dead_context()" type of thing?

