Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291599AbSBAH6t>; Fri, 1 Feb 2002 02:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291600AbSBAH6j>; Fri, 1 Feb 2002 02:58:39 -0500
Received: from sun.fadata.bg ([80.72.64.67]:57361 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S291599AbSBAH60>;
	Fri, 1 Feb 2002 02:58:26 -0500
To: <mingo@elte.hu>
Cc: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>, John Stoffel <stoffel@casc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33.0202010958220.2111-100000@localhost.localdomain>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.LNX.4.33.0202010958220.2111-100000@localhost.localdomain>
Date: 01 Feb 2002 09:59:51 +0200
Message-ID: <87u1t1ws20.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ingo" == Ingo Molnar <mingo@elte.hu> writes:

Ingo> On Fri, 1 Feb 2002, Anton Blanchard wrote:

>> There were a few solutions (from davem and ingo) to allocate a larger
>> hash but with the radix patch we no longer have to worry about this.

Ingo> there is one big issue we forgot to consider.

Ingo> in the case of radix trees it's not only search depth that gets worse with

Hmm, worse, yes, the same way as page tables get "worse" with larger
address spaces.

Ingo> big files. The thing i'm worried about is the 'big pagecache lock' being
Ingo> reintroduced again. If eg. a database application puts lots of data into a

Yes, though I'd strongly suspect big database engines can/should/do
benefit from doing their application specific caching and indexing,
outperforming whatever cache implementation the OS has.

Ingo> single file (multiple gigabytes - why not), then the
mapping-> i_shared_lock becomes a 'big pagecache lock' again, causing
Ingo> serious SMP contention for even the read() case. Benchmarks show that it's
Ingo> the distribution of locks that matters on big boxes.

So, we can use a read-write spinlock instead ->i_shared_lock, ok ?

Regards,
-velco
