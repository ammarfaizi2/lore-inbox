Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTI1UAp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 16:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbTI1UAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 16:00:45 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:45242 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262703AbTI1UAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 16:00:43 -0400
Date: Sun, 28 Sep 2003 22:00:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Bernardo Innocenti <bernie@develer.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030928200001.GC16921@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org> <20030928184642.GA1681@mars.ravnborg.org> <20030928191622.GA16921@wohnheim.fh-wedel.de> <20030928204224.G1428@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030928204224.G1428@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 September 2003 20:42:24 +0100, Russell King wrote:
> 
> I have a bad feeling about this, so I'll make the following comments
> up front before all the reports start rolling in.  It may be a good
> idea to document this somewhere.  (Coding style?)
> 
> If a header has something like these:
> 
> struct my_headers_struct {
> 	struct task_struct *tsk;
> };
> 
> void my_function(struct task_struct *tsk);
> 
> and gcc warns that "struct task_struct" has not been declared, please
> don't think about adding another header.  Just declare the structure
> in the header file which needs it like this:
> 
> struct task_struct;
> 
> and that will prevent the #include maze of 2.4, which resulted in
> everything being rebuilt just because one header file was touched.

Ok, how about this:

for each header file {
	make header.o
1)	if it doesn't build {
		print out a warning
		continue
	}
	for each #include line {
		remove the #include line
		make header.o
2)		if it build {
			print out a warning
		}
3)		if there are less than x gcc warnings {
			print out a warning
		}
	}
}

1) is my old proposal.  2) is the natural counterpart.  3) could be
what you want.  If some header is only needed for something like your
example, we may be able to catch it this way.

Would this work?  Would something else work even better?

Jörn

-- 
Rules of Optimization:
Rule 1: Don't do it.
Rule 2 (for experts only): Don't do it yet.
-- M.A. Jackson 
