Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRDWQEd>; Mon, 23 Apr 2001 12:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131484AbRDWQEO>; Mon, 23 Apr 2001 12:04:14 -0400
Received: from portraits.wsisiz.edu.pl ([195.205.208.34]:8745 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S130038AbRDWQED>; Mon, 23 Apr 2001 12:04:03 -0400
Date: Mon, 23 Apr 2001 18:03:30 +0200
Message-Id: <200104231603.f3NG3Uo01954@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with "su -" and kernels 2.4.3-ac11 and higher
In-Reply-To: <20010422102234.A1093@ulthar.internal.mclure.org>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: E233 4EB2 BC46 44A7 C5FC  14C7 54ED 2FE8 FEB9 8835
X-Key-ID: 829B1533
User-Agent: tin/1.5.9-20010328 ("Blue Water") (UNIX) (Linux/2.4.4-pre6 (i586))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010422102234.A1093@ulthar.internal.mclure.org> you wrote:
> I'm having a problem with "su -" on ac11/ac12. ac5 doesn't show the
> problem.
> The problem is easy to reproduce - go to a console, log in as root, do an
> "su -" (this will succeed) and then another "su -". The second "su -"
> should hang - ps shows it started bash and that the bash process is
> sleeping. You need to "kill -9" the bash to get your prompt back.

> Distribution is Red Hat 7.1, running on an Athlon Thunderbird 900MHz on a
> MSI K7T Turbo R motherboard.

I have tested it on 2.4.4pre6, here is result:

[root@lt /root]# su - test

[root@lt /root]# ps xaf
 1372 tty1     S      0:00 login -- root
 1373 tty1     S      0:00  \_ -bash
 1819 tty1     S      0:00      \_ su - test
 1820 tty1     S      0:00          \_ -bash
 1846 tty1     T      0:00              \_ stty erase ?


Last 10 lines from gdb su

Loaded symbols for /lib/security/pam_env.so
Reading symbols from /lib/security/pam_unix.so...done.
Loaded symbols for /lib/security/pam_unix.so
Reading symbols from /lib/security/pam_cracklib.so...done.
Loaded symbols for /lib/security/pam_cracklib.so
Reading symbols from /usr/lib/libcrack.so.2...done.
Loaded symbols for /usr/lib/libcrack.so.2
Reading symbols from /lib/security/pam_limits.so...done.
Loaded symbols for /lib/security/pam_limits.so
0x401156c9 in __wait4 () from /lib/libc.so.6
(gdb)

but:

[lukasz@lt lukasz]$ su -
Password:
[root@lt /root]#

It's looks OK :)


[lukasz@lt lukasz]$ su --version
su (GNU sh-utils) 2.0

[lukasz@lt lukasz]$ bash --version
GNU bash, version 2.04.21(1)-release (i386-redhat-linux-gnu)
Copyright 1999 Free Software Foundation, Inc.

[lukasz@lt lukasz]$ stty --version
stty (GNU sh-utils) 2.0


Kernel 2.4.4-pre6, 2.2.2-10, 0.74-22  - RedHat 7.1
AMD-K6 300 Mhz,


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
