Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUDLNUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 09:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUDLNUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 09:20:17 -0400
Received: from post1.dk ([62.242.36.44]:61712 "EHLO post1.dk")
	by vger.kernel.org with ESMTP id S262897AbUDLNUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 09:20:10 -0400
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
To: Axel Weiss <aweiss@informatik.hu-berlin.de>
Subject: Re: kernelversion distinction
From: sam@ravnborg.org
Reply-To: sam@ravnborg.org
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=iso-8859-1
X-Mailer: acmemail <URL:http://www.astray.com/acmemail/>
Message-Id: <20040412132009.0D15415C20@post1.dk>
Date: Mon, 12 Apr 2004 15:20:09 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Man, 12 Apr 2004 12:21:44 +0200 skrev Axel Weiss <aweiss@informatik.hu-berlin.de> : 

>Ok, maybe there's some misunderstanding due to copy-n-paste-mistakes
>I made in my former mail.
>
>As I suppose my device drivers will not become part of the official
>kernel, I 
>keep them with my project. My opinion now is to use one Makefile for
>both, 
>2.2-2.4 and 2.6 kernels, and to keep this Makefile simple.

I have never looked at 2.2 so here I cannot help you.
But my original questions remains:
Why you cannot use the same Makefile for 2.4 and 2.6?

A simple Makefile like you outline:
>EXTRA_CFLAGS := -I/usr/include
>obj-m	       += <my_module>.o
><my_module>-objs = <my module object files>

Will work flawlessly with both 2.4 and 2.6.
I know people for a long time have hardcoded the gcc commandline
to build modules for 2.4 - but thats just wrong.
In this way you do not catch differences in gcc options.
For 2.4 we have seen only few of these config related flags to gcc,
in 2.6 we have a lot.

Please next time post the full Makefile.

Btw, a module that is dependent on /usr/include looks wrong...

I have no knowledge of a documented way to distingush between 2.4
and 2.6 in the Makefiles.

>Maybe, I'm not the first one who tries this, or maybe others would
>find it 
>useful - that's the reason why I want to discuss this topic here.
>(If I'm OT, 
>please let me know).
Not OT - please continue.

>
>all:
>	 $(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
>
>clean:
>	 rm -f *.o *.ko .*.cmd <my_module>.mod.c

For the new external module support implemented in -mc4 you
do not have to hardcode the clean: target, and no attempts will
be made to update the kernel stuff.
Documentation soon to arrive...

     Sam
