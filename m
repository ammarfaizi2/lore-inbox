Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbTBTROP>; Thu, 20 Feb 2003 12:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbTBTRNw>; Thu, 20 Feb 2003 12:13:52 -0500
Received: from mx1.elte.hu ([157.181.1.137]:10124 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S265402AbTBTRNp>;
	Thu, 20 Feb 2003 12:13:45 -0500
Date: Thu, 20 Feb 2003 18:23:28 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Alex Larsson <alexl@redhat.com>,
       <procps-list@redhat.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
In-Reply-To: <Pine.LNX.4.44.0302201810160.32017-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302201818060.32324-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


eg. with 16,000 threads in /proc, "ls /proc" is still fast:

     real:0m0.032s   user:0m0.007s   sys:0m0.024s

without those threads, it's:

     real:0m0.014s user:0m0.004s sys:0m0.010s

15 msecs difference. Even simple 'ls' reads the full /proc directory (all
16K+ entries). So performance-wise there's not a big difference.

architecture-wise there is a difference, and i'd be the last one arguing
against a tree-based approach to thread groups. It's much easier to find
threads belonging to a single 'process' via /proc this way - although no
functionality in procps has or requires such a feature currently.

	Ingo

