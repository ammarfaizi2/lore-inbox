Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTI1Tmc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 15:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTI1Tmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 15:42:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26640 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262687AbTI1Tma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 15:42:30 -0400
Date: Sun, 28 Sep 2003 20:42:24 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Bernardo Innocenti <bernie@develer.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030928204224.G1428@flint.arm.linux.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Bernardo Innocenti <bernie@develer.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org> <20030928184642.GA1681@mars.ravnborg.org> <20030928191622.GA16921@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030928191622.GA16921@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Sun, Sep 28, 2003 at 09:16:22PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 09:16:22PM +0200, Jörn Engel wrote:
> How about a check_headers target that roughly works like this:
> 
> for (all header files in include/linux and include/asm) {
> 	echo "#include <$HEADER>" > header.c
> 	make header.o
> 	rm header.c header.o
> }
> 
> Did a quick test for linux/fs.h in -test5 and it compiled fine, but
> broke after removing some random #include.
> 
> Another thing, Sam, "make header.o" causes make to call itself
> indefinitely.  Had to "make somedir/header.o".  Not sure if you
> consider this to be a bug, your decision.

I have a bad feeling about this, so I'll make the following comments
up front before all the reports start rolling in.  It may be a good
idea to document this somewhere.  (Coding style?)

If a header has something like these:

struct my_headers_struct {
	struct task_struct *tsk;
};

void my_function(struct task_struct *tsk);

and gcc warns that "struct task_struct" has not been declared, please
don't think about adding another header.  Just declare the structure
in the header file which needs it like this:

struct task_struct;

and that will prevent the #include maze of 2.4, which resulted in
everything being rebuilt just because one header file was touched.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
