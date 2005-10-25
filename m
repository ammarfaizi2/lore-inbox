Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVJYNaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVJYNaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 09:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVJYNaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 09:30:05 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22533 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751264AbVJYNaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 09:30:01 -0400
Date: Tue, 25 Oct 2005 15:29:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Badari Pulavarty <pbadari@gmail.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc5-mm1
Message-ID: <20051025132955.GB5329@stusta.de>
References: <20051024014838.0dd491bb.akpm@osdl.org> <1130168434.6831.1.camel@localhost.localdomain> <20051024154342.GA24527@stusta.de> <1130174497.12873.30.camel@localhost.localdomain> <20051025095441.GA5329@stusta.de> <1130245216.25191.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130245216.25191.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2005 at 02:00:15PM +0100, Alan Cox wrote:

> On Maw, 2005-10-25 at 11:54 +0200, Adrian Bunk wrote:
> > The other ones I know about on i386 are:
> >   drivers/char/stallion.c
> >   drivers/char/istallion.c
> >   drivers/char/riscom8.c
> >   drivers/char/rio/riointr.c
> 
> Looking at the code I doubt they worked anyway given the cli() use and
> the like but the patch is attached for them.
>...

This left the following compile error solved by the trivial patch below:

<--  snip  -->

...
  CC      drivers/char/riscom8.o
...
drivers/char/riscom8.c: In function 'rc_receive_exc':
drivers/char/riscom8.c:401: warning: implicit declaration of function 'tty_insert_flip_char'
drivers/char/riscom8.c: In function 'rc_receive':
drivers/char/riscom8.c:423: warning: implicit declaration of function 'tty_buffer_request_room'
...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `rc_interrupt':
riscom8.c:(.text+0x281817): undefined reference to `tty_insert_flip_char'
riscom8.c:(.text+0x28189e): undefined reference to `tty_insert_flip_char'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1/drivers/char/riscom8.c.old	2005-10-25 15:24:24.000000000 +0200
+++ linux-2.6.14-rc5-mm1/drivers/char/riscom8.c	2005-10-25 15:28:08.000000000 +0200
@@ -46,6 +46,7 @@
 #include <linux/major.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/tty_flip.h>
 
 #include <asm/uaccess.h>
 

