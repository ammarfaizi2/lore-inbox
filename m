Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131680AbQKVWw6>; Wed, 22 Nov 2000 17:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131724AbQKVWws>; Wed, 22 Nov 2000 17:52:48 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:3338 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S131686AbQKVWwl> convert rfc822-to-8bit;
        Wed, 22 Nov 2000 17:52:41 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>
cc: Andries.Brouwer@cwi.nl,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: silly [< >] and other excess 
In-Reply-To: Your message of "Wed, 22 Nov 2000 14:42:05 BST."
             <3A1BCD2C.8F489FB3@vz.cit.alcatel.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Date: Thu, 23 Nov 2000 09:22:30 +1100
Message-ID: <3626.974931750@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000 14:42:05 +0100, 
Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr> wrote:
>Andries.Brouwer@cwi.nl a écrit :
>
>>  I also left something else
>> that always annoyed me: valuable screen space (on a 24x80 vt)
>> is lost by these silly [< >] around addresses in an Oops.
>> They provide no information at all, but on the other hand
>> cause loss of information because these lines no longer
>> fit in 80 columns causing line wrap and the loss of the
>> top of the Oops.]

You just broke ksymoops.  Removing the [< >] is a bad idea, they are
one of the few things that identifies the addresses in the log,
otherwise they just look like hex numbers.  ksymoops has to scan log
files which can contain anything and somehow pick out the interesting
lines, you need some identifier on the lines.

>Moreover, there is another problem in Oops:
>the dumped stack is limited to 3 or 4 lines to prevent loss of information
>but the call trace is unlimited and can loose all information,
>and sometimes is printing forever!
>--- arch/i386/kernel/traps.c.orig Mon Oct  2 20:57:01 2000
>+++ arch/i386/kernel/traps.c Sun Nov  5 14:33:52 2000
>@@ -142,11 +142,12 @@
>    * out the call path that was taken.
>    */
>   if (((addr >= (unsigned long) &_stext) &&
>+    (i<32) &&
>        (addr <= (unsigned long) &_etext)) ||
>       ((addr >= module_start) && (addr <= module_end))) {
>    if (i && ((i % 8) == 0))
>     printk("\n       ");
>-   printk("[<%08lx>] ", addr);
>+   printk("%08lx ", addr);
>    i++;
>   }
>  }

There should be no need to restrict the number of lines printed, it is
limited by the top of the kernel stack.  If there are more than 32
trace entries on the stack then they should be printed.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
