Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132425AbRDWWUg>; Mon, 23 Apr 2001 18:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132421AbRDWWR3>; Mon, 23 Apr 2001 18:17:29 -0400
Received: from colorfullife.com ([216.156.138.34]:19467 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132422AbRDWWQl>;
	Mon, 23 Apr 2001 18:16:41 -0400
Message-ID: <004201c0cc40$07c79ef0$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <ebiederman@lnxi.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Longstanding elf fix (2.4.3 fix)
Date: Mon, 23 Apr 2001 23:54:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well looking a little more closely than I did last night it looks like
> access_process_vm (called from ptrace) can cause what amounts to a
> page fault at pretty arbitrary times.

It's also used for several /proc/<pid> files.

I remember that I got crashes with concurrent exec+cat
/proc/<pid>/cmdline until down(mmap_sem) was added into
setup_arg_pages().

> I'm actually a little curious what the big kernel lock in ptrace buys
> us. I suspect it could be a performance issue with user mode linux.
> Where you have multiple processes being ptraced at the same time.

I checked it a few months ago, and the lock is only required to prevent
multiple concurrent attaches to the same process and concorrent
ptrace/suid exec (in fs/exec.c, compute_creds)

--
    Manfred





