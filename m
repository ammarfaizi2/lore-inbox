Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291559AbSBHMcw>; Fri, 8 Feb 2002 07:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291560AbSBHMcm>; Fri, 8 Feb 2002 07:32:42 -0500
Received: from ns.caldera.de ([212.34.180.1]:35021 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S291559AbSBHMcb>;
	Fri, 8 Feb 2002 07:32:31 -0500
Date: Fri, 8 Feb 2002 13:31:07 +0100
Message-Id: <200202081231.g18CV7e31341@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: mingo@elte.hu (Ingo Molnar)
Cc: Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@zip.com.au>,
        torvalds <torvalds@transmet.com>, rml <rml@tech9.net>,
        nigel <nigel@nrg.org>
To: yodaiken <yodaiken@fsmlabs.com>
Subject: Re: [RFC] New locking primitive for 2.5
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.33.0202072305480.2976-100000@localhost.localdomain>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0202072305480.2976-100000@localhost.localdomain> you wrote:
> i think one example *could* be to turn inode->i_sem into a combi-lock. Eg.
> generic_file_llseek() could use the spin variant.

No.  i_sem should be split into a spinlock for short-time accessed
fields that get written to even if the file content is only read (i.e.
atime) and a read-write semaphore.

