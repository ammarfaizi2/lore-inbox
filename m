Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSIDRuh>; Wed, 4 Sep 2002 13:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSIDRuh>; Wed, 4 Sep 2002 13:50:37 -0400
Received: from lazir.toya.net.pl ([217.113.224.3]:45477 "HELO
	lazir.toya.net.pl") by vger.kernel.org with SMTP id <S312590AbSIDRuf>;
	Wed, 4 Sep 2002 13:50:35 -0400
Date: Wed, 4 Sep 2002 19:55:00 +0200 (CEST)
From: <airot@lazir.toya.net.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Weird module problem.
Message-ID: <Pine.LNX.4.33.0209041946580.23775-100000@lazir.toya.net.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Heya,

I`ve got some weird problem in one of my linux machines. I`m writing
simple module, that should catch some syscall which isn`t too hard.
My linux kernel version is 2.2.21 without any patches. The main problem is
that whenever i call the right syscall from user, my uid is always = 0.
The current is not NULL, but all current variables are.

the code is easy, and looks like this(for example of course)


extern void    *sys_call_table[];

uid_t             (*o_getuid) (void)

uid_t n_getuid(void)
{
printk("User uid: %d\n", current->uid);
return o_getuid();
}

int
init_module()
{
        unsigned long   flags;
        save_flags(flags);
        cli();
	o_getuid = sys_call_table[__NR_getuid];
	sys_call_table[__NR_getuid] = n_getuid;
        restore_flags(flags);
        return 0;
}

void
cleanup_module()
{
        unsigned long   flags;
        save_flags(flags);
        cli();
        sys_call_table[__NR_getuid] = o_getuid;
        restore_flags(flags);
}

Basicly the above example is trivial, and should work. But it doesn`t on
my linux box. The machine is smp. The module works on every other linux
that i`ve tested(all were single processors).

Any hints about this?

Best Regards,

airot...

