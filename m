Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280104AbRKNEtR>; Tue, 13 Nov 2001 23:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280118AbRKNEtI>; Tue, 13 Nov 2001 23:49:08 -0500
Received: from mnh-1-04.mv.com ([207.22.10.36]:38156 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S280114AbRKNEsy> convert rfc822-to-8bit;
	Tue, 13 Nov 2001 23:48:54 -0500
Message-Id: <200111140607.BAA06138@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.51-2.4.14
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Wed, 14 Nov 2001 01:07:59 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.14 is available.

The SIGIO now uses poll instead of select.  This is in preparation for
fixing the console driver's flow control problems.

Redid the task switching code so that the tracing thread is no longer 
involved.  This is in preparation for eliminating the tracing thread - it
doesn't actually speed anything up yet.  However, it does allow UML to be
^Z-ed and backgrounded.

UML now works on 3G/1G hosts when CONFIG_HOST_2G_2G is on. 

Every thread now has a private page of data which contains errno.  This is 
handy for people poking around the UML arch code with gdb.  Everything gdb
does is intercepted by the tracing thread, which makes (mostly successful)
system calls which set errno to 0.  This is at least an annoyance when stepping
through the code, and it could be bad if it causes the code flow to change.
With thread-private errnos, this is no longer a problem.

Some context switching optimizations from Jörgen Cederlöf and me have been
made.  These noticably help the performance of workloads that switch 
frequently.

Fixed the process segfaults caused by Xnest and kernel builds.  The same
fix also makes gdb work better.  

Fixed a typo in arch/um/kernel/Makefile which caused modules not to load
into a profiled kernel.  

Restructured the uml_net sources to make them more modular. 

uml_net should now do proxy arp correctly. 

uml_mconsole can now take a command on its command line. 

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at 
	http://user-mode-linux.sourceforge.net/dl-sf.html

				Jeff

