Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287936AbSAHGD2>; Tue, 8 Jan 2002 01:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287937AbSAHGDT>; Tue, 8 Jan 2002 01:03:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:136 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S287936AbSAHGDC>;
	Tue, 8 Jan 2002 01:03:02 -0500
Date: Mon, 07 Jan 2002 22:02:08 -0800 (PST)
Message-Id: <20020107.220208.23012783.davem@redhat.com>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: can we make anonymous memory non-EXECUTABLE?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200201080025.QAA26731@napali.hpl.hp.com>
In-Reply-To: <200201080025.QAA26731@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@hpl.hp.com>
   Date: Mon, 7 Jan 2002 16:25:10 -0800
   
   Also, as a practical matter, we currently have special hacks in the
   ia64 page fault handler that are needed to work around performance
   problems that arise from the fact that we map anonymous memory with
   EXECUTE rights by default.  Those hacks avoid having to flush the
   cache for memory that's mapped executable but never really
   executed.  So clearly there are technical advantages to not turning
   on EXECUTE permission, even if we ignore the security argument.
   
I assume this hack is "have a software EXECUTE bit, initially only
set the software one, when we take a fault on execute set the hardware
bit and maybe flush the Icache".  If so, what is the big deal? :-)

   What I'm wondering: how do others feel about this issue?  Since x86
   wont be affected by this, I'm especially interested in the opinion of
   the maintainers of non-x86 platforms.
   
   It seems to me that for portability reasons, dynamic code generators
   should always do an mmap() call to ensure that the generated code is
   executable.  If we can agree on this as the recommended practice, then
   I don't see much of a problem with not turning on the EXECUTE right by
   default.
   
   Opinions?

I think changing this behavior is going to silently break things on
many architectures.  Secondly, I do not see any real gain from any
of this and my ports are those that have I-cache coherency issues :-)

Franks a lot,
David S. Miller
davem@redhat.com
