Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267913AbTBVUq1>; Sat, 22 Feb 2003 15:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267914AbTBVUq1>; Sat, 22 Feb 2003 15:46:27 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:14290 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S267913AbTBVUq0>; Sat, 22 Feb 2003 15:46:26 -0500
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
From: Albert Cahalan <albert@users.sf.net>
To: procps-list@redhat.com, mingo@elte.hu
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Alex Larsson <alexl@redhat.com>, Alexander Viro <viro@math.psu.edu>
In-Reply-To: <Pine.LNX.4.44.0302201818060.32324-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0302201818060.32324-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 Feb 2003 15:52:50 -0500
Message-Id: <1045947170.19445.57.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-20 at 12:23, Ingo Molnar wrote:

> architecture-wise there is a difference, and i'd be
> the last one arguing against a tree-based approach to
> thread groups. It's much easier to find threads belonging
> to a single 'process' via /proc this way - although no
> functionality in procps has or requires such a feature currently.

Nope, the /proc/123/threads/246/stat approach is required.
Without this, procps is forced to read _all_ tasks to
group threads together. This is slow, prone to race conditions,
more vulnerable to kernel bugs, and a memory hog.

FYI, thread grouping is required even if whole-process
information is available. Many "ps" output formats need
grouping, and it is desirable for many more.

I might as well mention that whole-process information
includes the four fault counters and some indication
that wchan data is multi-valued (a '*' must be displayed
in that case). There may be more I haven't spotted yet.

Note that the recent /proc/*/wchan addition was botched.
Caching is prevented due to race conditions. This could
be fixed by changing the file format to contain:
    number, function name
with optional:
    function address, file name, module name
(next time, discuss such changes with an experienced
procps developer first)


