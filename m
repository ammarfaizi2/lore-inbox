Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTIZR0a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 13:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbTIZR03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 13:26:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39333 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261380AbTIZR0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 13:26:21 -0400
Date: Fri, 26 Sep 2003 19:24:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] updated exec-shield patch, 2.4/2.6 -G3 
In-Reply-To: <200309261713.h8QHDwXL002422@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.56.0309261919190.25578@localhost.localdomain>
References: <Pine.LNX.4.56.0309261410130.14571@localhost.localdomain>
 <200309261713.h8QHDwXL002422@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 26 Sep 2003 Valdis.Kletnieks@vt.edu wrote:

> On Fri, 26 Sep 2003 14:28:54 +0200, Ingo Molnar <mingo@elte.hu>  said:
> 
> > against vanilla 2.6.0-test5:
> > 
> > 	redhat.com/~mingo/exec-shield/exec-shield-2.6.0-test5-G2
> 
> Ingo, you rock. ;)  I'm using a fairly current Rawhide here (within last 2
> weeks or so).
> 
> Applied with 2 or 3 minor conflicts and a few fuzz/delta messages
> against -test5-mm4 (I have a refactored patch if anybody is interested).  
> It booted OK, seems to be working well enough that e-mail and XFree
> (even with the evil binary NVidia driver) are functional.

btw., i have a patch against Linus' latest, -bk12 too:

  redhat.com/~mingo/exec-shield/exec-shield-2.6.0-test5-bk12-G2

> I'm assuming it's this GCC change in Rawhide:
> 
> * Wed Jun 04 2003 Jakub Jelinek  <jakub@redhat.com> 3.3-4
> 
> - mark object files with .note.GNU-stack notes whether they
>   need or don't need executable stack

yes. The kernel ELF loader now detects this PT_GNU_STACK program header
entry and acts upon it. (when using the setting of 1.)

> (and another at 3.3-5).  Has the current Rawhide been recompiled with this
> support, or should I stick with '2' and use setarch for things that fail?

it's quit easy to check: with a setting of 1, does 'cat /proc/self/maps'
show a randomized layout, while 'setarch i386 cat /proc/self/maps' shows a
regular layout? If /bin/cat defaults to exec-shield even with a setting of
1 then everything's recompiled.

in fact with glibc-2.3.2-92 and later ld.so will revert a non-executable
stack to executable if a binary loads a DSO that needs an executable
stack. 'tuxracer' is one such very important example :-)

> Now to go build a testcase program and try to shellcode it. ;)

i see the smiley - but it would truly be interesting to try to find the
boundaries of exec-shield and try to exploit it.

	Ingo
