Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131763AbRCOPyk>; Thu, 15 Mar 2001 10:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131764AbRCOPya>; Thu, 15 Mar 2001 10:54:30 -0500
Received: from clev-max1-cs-8.dial.bright.net ([209.143.46.10]:53889 "EHLO
	skylab.winds.org") by vger.kernel.org with ESMTP id <S131763AbRCOPyQ>;
	Thu, 15 Mar 2001 10:54:16 -0500
Date: Thu, 15 Mar 2001 10:53:02 -0500 (EST)
From: Byron Stanoszek <gandalf@skylab.winds.org>
To: <linux-kernel@vger.kernel.org>
Subject: Need help with allocating a 2M buffer size
Message-ID: <Pine.LNX.4.31.0103151040280.2983-100000@skylab.winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a real picky tape drive (DLT series) that likes to be fed large chunks
of data at once, otherwise after every 2-4KB of data it halts and rewinds
itself because its cache for writing to the tape is empty.

My best solution to this problem was to use 'tar -b 4096', which sends 4096 x
512-byte blocks at once for a total of a 2MB buffer size. This worked fine for
several weeks, until 2 days ago I got this message (and the backup fails):

st: failed to enlarge buffer to 2097152 bytes.

Free memory shows:

             total       used       free     shared    buffers     cached
Mem:        517036     514468       2568     751908      47804     189488
-/+ buffers/cache:     277176     239860
Swap:       136544        452     136092

Unfortunately, all of the "free" memory right now is eaten up using cache. Is
there a way I can just tell the kernel to allocate memory from the cache for
the buffer? I'm sure there's gotta be a 2MB-sized chunk in that 189MB cache
-somewhere-.

Why doesn't the kernel's get_free_pages() function support moving data around
in memory to get larger chunks for what it needs? I see this same problem
happening in SVGATextMode where allocating space for a NxM character screen
(where NxM >= 16384) fails because there is no contiguous memory space. I think
at least it should be able to use some cache.

Suggestions?
 -Byron

--
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

