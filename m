Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261910AbSIYEWT>; Wed, 25 Sep 2002 00:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbSIYEWT>; Wed, 25 Sep 2002 00:22:19 -0400
Received: from relay1.pair.com ([209.68.1.20]:38158 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S261910AbSIYEWT>;
	Wed, 25 Sep 2002 00:22:19 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3D913D58.49D855DB@kegel.com>
Date: Tue, 24 Sep 2002 21:36:40 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel call chain search tool?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<prelude>
I have a large multithreaded program that has a habit of using too
much memory, and as a safeguard, I want to kill it before it makes
the system unstable.  The OOM killer often guesses wrong, and RLIMIT_AS
kills too soon because of the address space used up by the many thread
stacks.
So I'd like an RLIMIT_RSS that just kills the fat process.

There have been a couple patches to implement RLIMIT_RSS, e.g.
Peter Chubb's
http://marc.theaimsgroup.com/?l=linux-kernel&m=97892951101598&w=2
and the two from Rik, all of which are too complex for my needs
(and which only swap out instead of kill), so I guess I have to roll my
own.
</prelude>

Rik's patch checks rss in handle_mm_fault(); Peter's
checked it in do_swap_page() and do_anonymous_page().
As a kernel newbie, I don't have a feel for how
those calls relate to each other.  Is there a tool 
somewhere that will take a set of function names and 
list all the kernel call chains that start in one of
the functions and end in another?

- Dan
