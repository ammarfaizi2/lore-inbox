Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbSKLErh>; Mon, 11 Nov 2002 23:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbSKLErh>; Mon, 11 Nov 2002 23:47:37 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:35069 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP
	id <S266200AbSKLErg>; Mon, 11 Nov 2002 23:47:36 -0500
Message-ID: <004701c28a07$915c88c0$6401a8c0@stafford>
From: "Kermit Tensmeyer" <kermit.tensmeyer.nospam@verizon.net>
To: <linux-kernel@vger.kernel.org>
Subject: compile error 2.4.19   linux/arch/kernel/traps.c
Date: Mon, 11 Nov 2002 22:54:22 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a compile time error, not a bug per se

2.4.19 source as delivered in suse 8.1

 inside the code is an ifdef'ed section that depends on
either DPROBES_CORE being defined or KDB being defined.

 Somehow the first time, I had KDB as undefined, and DPROBES_CORE
set. The make process generated a compile error because the function
'kdb' had not been defined.
  It may well be the case that there is a simple fix (but I am unaware of
other consequences) that the logical 'or' of the two conditions should
be replaced by a logical 'and' of the conditions.

 The lines under consideration are in the range of 640-650.

 After I fixed the configuration (make xconfig), it was a 'clean' compile.
I was able to recreate the configuration error by selecting the last
menu from the main menu form and set the first menu line to 'Y'
and not setting any other option. I checked the config file and
in fact  CONFIG_KDB was undef and CONFIG_DPROBES_CORE
was set to '1'.   In the presentation menu, the DPROBES_CORE entry
had been 'grayed' out, but the code set the value anyway.

 I checked the code, and when the entire option page had
been deselected  all the configuration options including KDB
and DPROBES_CORE had been undefined.

 as an aside, I thought I read that (at an IBM site for the
DPROBES_CORE project), that code had been intended
for architectures other than i386.
 These set of modification did not exist (that I saw) (i could be
wrong about this..) in the traps.c code in the 2.4.17 code
set. This appears to have been a recent change, and may
not have been the subject of a code walk thru...


