Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135626AbRD1Ukp>; Sat, 28 Apr 2001 16:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135628AbRD1Ukf>; Sat, 28 Apr 2001 16:40:35 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:12430 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S135626AbRD1UkZ>; Sat, 28 Apr 2001 16:40:25 -0400
Message-ID: <3AEB2B18.F1EC31DE@kegel.com>
Date: Sat, 28 Apr 2001 13:42:00 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tmh@nothing-on.tv,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: just-in-time debugging?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Tony Hoyle (tmh@nothing-on.tv) wrote:
> Is there a way that gdb/ddd could be invoked when a program is about 
> to dump core...?

Yes, I use that to get a symbolic stack dump after a crash,
although I find that the gdb so invoked doesn't accept interactive
commands, and I have to use 'kill -9' afterwards.
Here's the code I use:

void dump_stack(int signum)
{
    (void) signum;
    char s[160];
    // The right command to execute depends on the program.  Adjust to taste.
    system("echo 'info threads\nbt\nthread 3\nbt\nthread 4\nbt\nthread 5\nbt\n' > gdbcmd");
 
    sprintf(s, "gdb -batch -x gdbcmd %s %d", argv0, (int) getpid());
    printf("Crashed!  Starting debugger to get stack dump.  You may need to kill -9 this process afterwards.\n");
    system(s);
    exit(1);
 
} 

main() {
   signal(SIGSEGV, dump_stack);
   signal(SIGBUS, dump_stack);   
...
