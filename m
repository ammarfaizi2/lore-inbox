Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291720AbSBHSmY>; Fri, 8 Feb 2002 13:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291718AbSBHSmP>; Fri, 8 Feb 2002 13:42:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39174 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291727AbSBHSmF>;
	Fri, 8 Feb 2002 13:42:05 -0500
Message-ID: <3C641BCE.196E1A37@zip.com.au>
Date: Fri, 08 Feb 2002 10:41:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@ns.caldera.de>
CC: Ingo Molnar <mingo@elte.hu>, yodaiken <yodaiken@fsmlabs.com>,
        Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        torvalds <torvalds@transmet.com>, rml <rml@tech9.net>,
        nigel <nigel@nrg.org>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <Pine.LNX.4.33.0202072305480.2976-100000@localhost.localdomain> <200202081231.g18CV7e31341@ns.caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> In article <Pine.LNX.4.33.0202072305480.2976-100000@localhost.localdomain> you wrote:
> > i think one example *could* be to turn inode->i_sem into a combi-lock. Eg.
> > generic_file_llseek() could use the spin variant.
> 
> No.  i_sem should be split into a spinlock for short-time accessed
> fields that get written to even if the file content is only read (i.e.
> atime) and a read-write semaphore.

I don't see any strong reason for taking i_sem in the generic seek
functions.  The only thing we seem to need to protect in there
is the non-atomic access to 64-bit i_size on 32-bit platforms,
for which a spinlock is appropriate.

I'd be interested in hearing more details on the regression which
Ingo has seen due to the introduction of i_sem locking in llseek.
Not just for "I told you so" value, but for the body of knowledge :)

-
