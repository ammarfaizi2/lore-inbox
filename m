Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285021AbRLFGxM>; Thu, 6 Dec 2001 01:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285022AbRLFGxC>; Thu, 6 Dec 2001 01:53:02 -0500
Received: from [24.112.107.70] ([24.112.107.70]:21495 "EHLO jolt.dmgware.ca")
	by vger.kernel.org with ESMTP id <S285021AbRLFGwm>;
	Thu, 6 Dec 2001 01:52:42 -0500
Date: Thu, 6 Dec 2001 01:52:53 -0500
From: Damian M Gryski <dgryski@uwaterloo.ca>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 + strace 4.4 + setuid programs
Message-ID: <20011206065253.GA1295@dmgware.dhs.org>
Reply-To: Damian M Gryski <dgryski@uwaterloo.ca>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0112060104140.32509-100000@behemoth.hobitch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0112060104140.32509-100000@behemoth.hobitch.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Dec 2001, Keith Warno wrote:
> Hmm.  Is strace supposed to be capable of tracing setuid programs (ie,
> su) when executed by mortal users?  I always thought this was a big
> no-no.

   Seems to me it drops permissions instead of not allowing the trace.

--- 8< --- cut here --- 8< ---
dmg@jolt:[pts/4]:~$ cat euid.c
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main() { printf("euid=%d\n", geteuid()); }

dmg@jolt:[pts/4]:~$ ls -l ./euid
-rwsr-sr-x    1 root     root         5039 Dec  6 01:46 ./euid
dmg@jolt:[pts/4]:~$ ./euid
euid=0
dmg@jolt:[pts/4]:~$ strace -o /dev/null ./euid
euid=1000
dmg@jolt:[pts/4]:~$
--- 8< --- cut here --- 8< ---

   Damian

-- 
Damian Gryski ==> dgryski@uwaterloo.ca | Linux, the choice of a GNU generation
512 pt Hacker Test score = 37%         | 500 pt Nerd Test score = 56% 
                   geek / linux zealot / coder / juggler
