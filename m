Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130361AbRA1J2y>; Sun, 28 Jan 2001 04:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130429AbRA1J2o>; Sun, 28 Jan 2001 04:28:44 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:43530 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130361AbRA1J2c>; Sun, 28 Jan 2001 04:28:32 -0500
From: Stefani Seibold <stefani@seibold.net>
Date: Sun, 28 Jan 2001 10:27:24 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, Stefani@seibold.net
To: Andrew Morton <andrewm@uow.edu.au>
In-Reply-To: <01012723313500.01190@deepthought.seibold.net> <3A736B76.214D4193@uow.edu.au>
In-Reply-To: <3A736B76.214D4193@uow.edu.au>
Subject: Re: patch for 2.4.0 disable printk
MIME-Version: 1.0
Message-Id: <01012810272400.01202@deepthought.seibold.net>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

thanks for your feddback, but... you are not right. Because i override the 
printk with a macro thats call a inline function printk_inline with no 
paramters and only return 0. So the compiler sill removes the paramters.
If you try this patch, you will see, that none of the parameters appear in 
the output.
The inline function is the best choice, because it it full compatible to old 
old printk. No side effects are expeted.
Thanks also for the link. I had a look on it and i think i will add a extrac 
option to disable also the panic messages.

Greetings,
Stefani

> Stefani Seibold wrote:
> > Second, i had change the macro so it calls now a inline funciton
> > printk_inline which always return 0. So it should be now compatibel to
> > the standard printk funciton.
>
> A #define is better.
>
> You see, even if printk is a null inline function,
>
> 	printk("foo");
>
> will still cause "foo" to appear in your output. Apparently
> very recent versions of gcc have fixed this.
>
> BTW: Graham Stoney prepared a similar patch for 2.2 last year.
> You may be able to borrow some ideas from that work, and the
> followup discussion.
>
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0004.2/0709.html
>
> -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
