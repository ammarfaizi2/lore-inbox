Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130404AbRCBKyH>; Fri, 2 Mar 2001 05:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130403AbRCBKxZ>; Fri, 2 Mar 2001 05:53:25 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:49976 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130401AbRCBKxR>; Fri, 2 Mar 2001 05:53:17 -0500
Date: Fri, 2 Mar 2001 04:53:03 -0600
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rml@ufl.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2ac8 lost char devices
Message-ID: <20010302045303.A32397@mandrakesoft.mandrakesoft.com>
In-Reply-To: <983511748.3a9f32c4e5ca2@webmail.ufl.edu> <snkwhfir.wl@frostrubin.open.nm.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <snkwhfir.wl@frostrubin.open.nm.fujitsu.co.jp>; from tachino Nobuhiro on Fri, Mar 02, 2001 at 03:05:32PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2001 at 03:05:32PM +0900, tachino Nobuhiro wrote:
> 
> Hello, 
> 
> At Fri, 02 Mar 2001 00:42:28 -0500,
> <rml@ufl.edu> wrote:
> > 
> > actually, its not just ps/2 mice -- it seems to be something generic to char
> > devices. agpgartis failing to register itself, too.
> > 
> > what changed with char device handling from ac7 to ac8?
> > 
> > robert love
> > rml@ufl.edu
> > -
> 
>   misc_register() in drivers/char/misc.c seems to have a problem.

I guess it's too late now to pretend it's not my fault.  I foolishly assumed
if it would boot for me I couldn't have broken it too badly.

> +       c = misc_list.next;
> +               
> +       while ((c != &misc_list) && (c->minor != misc->minor))
> +               c = c->next;
> +       if (c == &misc_list) {
> 
>   This should be  (c != &misc_list)

Correct.  Alan,


diff -ur linux/drivers/char/misc.c linux-prumpf/drivers/char/misc.c
--- linux/drivers/char/misc.c	Fri Mar  2 02:48:04 2001
+++ linux-prumpf/drivers/char/misc.c	Fri Mar  2 02:49:43 2001
@@ -180,7 +180,7 @@
 
 	while ((c != &misc_list) && (c->minor != misc->minor))
 		c = c->next;
-	if (c == &misc_list) {
+	if (c != &misc_list) {
 		up(&misc_sem);
 		return -EBUSY;
 	}
