Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132028AbRCYPDQ>; Sun, 25 Mar 2001 10:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131999AbRCYPDG>; Sun, 25 Mar 2001 10:03:06 -0500
Received: from storm.ca ([209.87.239.69]:14756 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S132035AbRCYPDD>;
	Sun, 25 Mar 2001 10:03:03 -0500
Message-ID: <3ABE086B.1CAF28FA@storm.ca>
Date: Sun, 25 Mar 2001 10:02:03 -0500
From: Sandy Harris <sandy@storm.ca>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en,fr
MIME-Version: 1.0
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010322124727.A5115@win.tue.nl> <Pine.LNX.4.30.0103231721480.4103-100000@dax.joh.cam.ac.uk> <20010325013241.F2274@garloff.casa-etp.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff wrote:

> Kernel related questions IMHO are:
> (1) Why do we get into OOM?

There was a long thread about this a few months back. We get into OOM because
malloc(), calloc() etc. can allocate more memory than is actually available.

e.g. Say you have machine with 64 RAM + 64 swap = 128 megs with 40 megs in use,
so 88 free. Now two processes each malloc() 80 megs. Both succeed. If both
processes then use that memory, someone is likely to fail later.

> Can we avoid it?

The obvious solution is to consider the above behaviour a bug and fix it.
The second malloc() should fail. The process making that call can then look
at the return value and decide what to do about the failure.

However, this was extensively discussed here last year, and that solution was
quite firmly rejected. I never understood the reasons. See the archives.

Someone did announce they were working on patches implementing a sane malloc().
What happened to that project?
