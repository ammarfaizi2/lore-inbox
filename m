Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRAAXPO>; Mon, 1 Jan 2001 18:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131160AbRAAXPC>; Mon, 1 Jan 2001 18:15:02 -0500
Received: from d168.as4.nwbl0.wi.voyager.net ([169.207.139.42]:1664 "EHLO
	giuseppe") by vger.kernel.org with ESMTP id <S131191AbRAAXOw>;
	Mon, 1 Jan 2001 18:14:52 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.4.0-pre compile err (pcxx)
In-Reply-To: <E14D9My-00017N-00@the-village.bc.nu>
From: apgarcia@uwm.edu (A. P. Garcia)
Date: 01 Jan 2001 22:41:49 +0000
In-Reply-To: Alan Cox's message of "Mon, 1 Jan 2001 18:07:38 +0000 (GMT)"
Message-ID: <87k88e3nf6.fsf@uwm.edu>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is a patch against the pcxx.c in the prerelease distribution
[clear thinkos.  brain ok now.]

anyhow, before it was awful close ;-)

thanks again


--- pcxx.c~	Fri Dec 29 22:35:47 2000
+++ pcxx.c	Mon Jan  1 22:30:00 2001
@@ -152,7 +152,7 @@
 DECLARE_TASK_QUEUE(tq_pcxx);
 
 static void pcxxpoll(unsigned long dummy);
-static void pcxxdelay(int);
+static void pcxxdelay(unsigned long);
 static void fepcmd(struct channel *, int, int, int, int, int);
 static void pcxe_put_char(struct tty_struct *, unsigned char);
 static void pcxe_flush_chars(struct tty_struct *);
@@ -1821,9 +1821,9 @@
 /*
  * pcxxdelay - delays a specified number of milliseconds
  */
-static void pcxxdelay(int msec)
+static void pcxxdelay(unsigned long ms)
 {
-	mdelay(mseconds);
+	mdelay(ms);
 }




Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > when i make bzimage with the pc/xx driver configured as a module, it
> > compiles ok.  configuring it as built-in gives the following error:
> 
> Im amazed it built as a module - thats why I missed the error
> 
> > pcxx.c:1826: `mseconds' undeclared (first use in this function)
> > pcxx.c:1826: (Each undeclared identifier is reported only once
> 
> 
> --- drivers/char/pcxx.c~	Sat Dec 30 01:07:21 2000
> +++ drivers/char/pcxx.c	Mon Jan  1 17:12:05 2001
> @@ -1823,7 +1823,7 @@
>   */
>  static void pcxxdelay(int msec)
>  {
> -	mdelay(mseconds);
> +	mdelay(msec);
>  }
>  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
