Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131143AbRA0PAK>; Sat, 27 Jan 2001 10:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131341AbRA0PAA>; Sat, 27 Jan 2001 10:00:00 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:48317 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131143AbRA0O7x>; Sat, 27 Jan 2001 09:59:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: David Ford <david@linux.com>
Subject: VM breakdown, 2.4.0 family
Date: Sat, 27 Jan 2001 09:59:32 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01012709593200.27226@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford Wrote:

>Since the testN series and up through ac12, I experience total loss of
>control when memory is nearly exhausted.
>
>I start with 256M and eat it up with programs until there is only about
>7 megs left, no swap.  From that point all user processes stall and the
>disk begins to grind nonstop.  It will continue to grind for about 25-30
>minutes until it goes completely silent.  No processes get killed, no VM
>messages are emitted.
>
>The only recourse is the magic key.  If I reboot before the disk goes
>silent I can cleanly kill X with sysrq-E and restart.
>
>If I wait until it goes silent, all is lost.  I have to sysrq-SUB.

You might want to try:

http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.1pre10/bg_page_aging.patch

or

ftp://ftp.cam.org/users/tomlins/pte_aging_limit_swaps.diff

The first patch from Marcelo fixes a problem with aging the wrong pages.  The 
second patch is sort of a 'best of Marcelo' patch.  It contains the aging fix 
and adds conditional bg pte aging (if with activate fast than we age 
down...).  It also has code to trottle swapouts when under preasure - it only
swaps out as much as we need now.

I have fives days of uptime with it here (on test9 and test10).

Feedback Welcome,

Ed Tomlinson <tomlins@cam.org>





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
