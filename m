Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317834AbSHCVO5>; Sat, 3 Aug 2002 17:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSHCVO5>; Sat, 3 Aug 2002 17:14:57 -0400
Received: from phobos.hpl.hp.com ([192.6.19.124]:24262 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317834AbSHCVOz>;
	Sat, 3 Aug 2002 17:14:55 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15692.18584.1391.30730@napali.hpl.hp.com>
Date: Sat, 3 Aug 2002 14:18:15 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>,
       <davidm@napali.hpl.hp.com>, <gh@us.ibm.com>, <frankeh@watson.ibm.com>,
       <Martin.Bligh@us.ibm.com>, <wli@holomorpy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd) 
In-Reply-To: <Pine.LNX.4.44.0208031240270.9758-100000@home.transmeta.com>
References: <15692.12093.514064.496253@napali.hpl.hp.com>
	<Pine.LNX.4.44.0208031240270.9758-100000@home.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 3 Aug 2002 12:43:47 -0700 (PDT), Linus Torvalds <torvalds@transmeta.com> said:

  >> You don't need separate system calls for that: with a transparent
  >> superpage framework and a privileged & reserved giant-page pool,
  >> it's trivial to set up things such that your favorite data base
  >> will always be able to get the giant pages (and hence the giant
  >> TLB mappings) it wants.  The only thing you lose in the
  >> transparent case is control over _which_ pages need to use the
  >> pinned giant pages.  I can certainly imagine cases where this
  >> would be an issue, but I kind of doubt it would be an issue for
  >> databases.

  Linus> That's _probably_ true. There aren't that many allocations
  Linus> that ask for megabytes of consecutive memory that wouldn't
  Linus> want to do it. However, there might certainly be non-critical
  Linus> maintenance programs (with the same privileges as the
  Linus> database program proper) that _do_ do large allocations, and
  Linus> that we don't want to give large pages to.

  Linus> Guessing is always bad, especially since the application
  Linus> certainly does know what it wants.

Yes, but that applies even to a transparent superpage scheme: in those
instances where an application knows what page size is optimal, it's
better if the application can express that (saves time
promoting/demoting pages needlessly).  It's not unlike madvise() or
the readahead() syscall: use reasonable policies for the ordinary
apps, and provide the means to let the smart apps tell the kernel
exactly what they need.

	--david
