Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270750AbRHNS4x>; Tue, 14 Aug 2001 14:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270746AbRHNS4o>; Tue, 14 Aug 2001 14:56:44 -0400
Received: from web13608.mail.yahoo.com ([216.136.175.119]:30981 "HELO
	web13608.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S270745AbRHNS42>; Tue, 14 Aug 2001 14:56:28 -0400
Message-ID: <20010814132956.94720.qmail@web13608.mail.yahoo.com>
Date: Tue, 14 Aug 2001 06:29:56 -0700 (PDT)
From: Ivan Kalvatchev <iive@yahoo.com>
Subject: DoS tmpfs,ramfs, malloc, saga continues
To: kernelbug <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Alan Cox pointed me, tmpfs bug is a VM bug. I was
able to reproduce the bug with a simple memory
"eating" program. (for the lazy ones copy-paste from
bottom).
As oom_kill.c says:
"...
*If we run out of memory, we have the choice between
either
 * killing a random task (bad), letting the system
crash (worse)
 * OR try to be smart about which process to kill.
Note that we
 * don't have to be perfect here, we just have to be
good.
 *
..."
Oh, how dumb. Now the system kills random tasks and
hangs with 50% probability. Just run the sample
program twice. Oh, system hangs while waiting for kill
(I wont wait for months). 
Good job for Alan Cox, with his patch i could run the
sample program 20 times before it crashed the system.
I cannot belive that instead of keeping this
masskiller for deathlocks, no way out situation, and
as last resort, You The Great Kernel Hackers use it
for every day and every body solution. Is it so hard
to make more memory checks for user level malloc?
Windows does. Every other OS does. Why linux doesn't? 
Fix it in the next kernel!

//-------------------eatmem.c-------------------
#include <stdio.h>
#include <stdlib.h>
int main()
{
int i;
void *p;
	for(i=0;;i++)
	{
		p=malloc(4096);
		printf("malloc #%d (%p)\n",i,p);
		if(p==NULL) break;
	}
	printf("I can't free mem:)");
return 0;
}


__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
