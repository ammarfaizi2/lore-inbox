Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129445AbRA1RdQ>; Sun, 28 Jan 2001 12:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129235AbRA1RdG>; Sun, 28 Jan 2001 12:33:06 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:61957 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129445AbRA1Rc4>; Sun, 28 Jan 2001 12:32:56 -0500
Date: Sun, 28 Jan 2001 18:32:33 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Stefani Seibold <stefani@seibold.net>
Cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: patch for 2.4.0 disable printk
Message-ID: <20010128183233.E9106@pcep-jamie.cern.ch>
In-Reply-To: <01012723313500.01190@deepthought.seibold.net> <3A736B76.214D4193@uow.edu.au> <01012810272400.01202@deepthought.seibold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01012810272400.01202@deepthought.seibold.net>; from stefani@seibold.net on Sun, Jan 28, 2001 at 10:27:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefani Seibold wrote:
> The inline function is the best choice, because it it full compatible to old 
> old printk. No side effects are expeted.

What is the difference?
I can't think of any difference between:

  #define printk(format, args...) ((int) 0)

and:

  static inline int printk_inline (void) { return 0; }
  #define printk(format, args...) (printk_inline ())

If you wanted to be fully compatible in the sense of evaluating the
printk arguments, in case those have side effects, there would be:

  #define printk(format, args...) ((0 , ## args), (int) 0)

By the way, CONFIG_NO_PRINTK or CONFIG_DISABLE_PRINTK would be better
names.  CONFIG_PRINTK suggests that enabling that option enabled printk.

enjoy,
-- Jamie

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
