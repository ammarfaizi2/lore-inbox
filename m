Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132591AbRDHTl0>; Sun, 8 Apr 2001 15:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132592AbRDHTlQ>; Sun, 8 Apr 2001 15:41:16 -0400
Received: from ohiper1-238.apex.net ([209.250.47.253]:9732 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S132591AbRDHTlA>; Sun, 8 Apr 2001 15:41:00 -0400
Date: Sun, 8 Apr 2001 14:41:02 -0500
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: All processes hung under 2.4.3
Message-ID: <20010408144101.A6171@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 2:32pm  up  1:55,  1 user,  load average: 1.09, 1.02, 1.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier today, I tried to unlock xscreensaver on my desktop.  After
typing in the password, it said "Checking..." and then hung.  In
response, I hit Ctrl+Alt+Bksp, which killed X.  However, gdm did not
restart X.  I tried logging in on the console, but none of them were
responsive; characters would echo, but nothing else.

In hopes of finding the problem, I entered kdb, and did a bta.  All
processes were hung in exactly the same spot, schedule+0x268!  This code
is as follows:

0xc0110d50 <schedule+252>:	jne    0xc0110d7e <schedule+298>
0xc0110d52 <schedule+254>:	test   %eax,%eax
0xc0110d54 <schedule+256>:	jne    0xc0110d72 <schedule+286>
0xc0110d56 <schedule+258>:	mov    0xffffffe4(%ecx),%edx
0xc0110d59 <schedule+261>:	test   %edx,%edx
0xc0110d5b <schedule+263>:	je     0xc0110d7e <schedule+298>
0xc0110d5d <schedule+265>:	mov    0xfffffff0(%ecx),%eax
0xc0110d60 <schedule+268>:	cmp    0xfffffff0(%ebp),%eax
0xc0110d63 <schedule+271>:	je     0xc0110d69 <schedule+277>
0xc0110d65 <schedule+273>:	test   %eax,%eax
0xc0110d67 <schedule+275>:	jne    0xc0110d6a <schedule+278>
0xc0110d69 <schedule+277>:	inc    %edx
0xc0110d6a <schedule+278>:	add    $0x14,%edx
0xc0110d6d <schedule+281>:	sub    0x24(%esi),%edx
0xc0110d70 <schedule+284>:	jmp    0xc0110d7e <schedule+298>

Additionally, I did a "ps" in kdb and found dozens of "cron" and "sh"
started.  I suspect that these processes were somehow related to the
lockup, as the machine should've been idle for hours, and no cron jobs
were scheduled for the time.

The captured "bta" is availible if anyone is interested.  I don't know
of a way to reproduce this offhand.
-- 
-Steven
Freedom is the freedom to say that two plus two equals four.
