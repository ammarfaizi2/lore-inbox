Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314500AbSECQTr>; Fri, 3 May 2002 12:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314511AbSECQTq>; Fri, 3 May 2002 12:19:46 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:60181 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314500AbSECQTq>; Fri, 3 May 2002 12:19:46 -0400
Date: Fri, 3 May 2002 18:20:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
Message-ID: <20020503182028.C14505@dualathlon.random>
In-Reply-To: <20020503103813.K11414@dualathlon.random> <4055279713.1020413842@[10.10.2.3]> <E173fVi-0002Ic-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 06:02:18PM +0200, Daniel Phillips wrote:
> and solves 75% of the problem.  It's not just ia32 numa that will benefit
> from it.  For example, MIPS supports 16K pages in software, which will

the whole change would be specific to ia32, I don't see the connection
with mips. There would be nothing to share between ia32 2M pages and
mips 16K pages. You can do mips 16K just now indipendently from the
page_size of ia32. 16K should work without surprises because other archs
have pages of this size and even bigger. Nobody has pages large as much
as 2M yet, that's an order of magnitude bigger. 16K for example is just
fine for the read()/pagein/pageout I/O, DMA is usually done in larger
chunks anyways with readahead and async-flushing to be faster (but never
as big as 2M, the highest limit is 512k per scsi command).

Andrea
