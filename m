Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSJATLm>; Tue, 1 Oct 2002 15:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262240AbSJATLl>; Tue, 1 Oct 2002 15:11:41 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15748 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262224AbSJATLh>; Tue, 1 Oct 2002 15:11:37 -0400
Date: Tue, 1 Oct 2002 15:20:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: immortal1015 <immortal1015@hotpop.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: compiling errors
In-Reply-To: <20021001185127.AA2C21B85AA@smtp-2.hotpop.com>
Message-ID: <Pine.LNX.3.95.1021001151801.857A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2002, immortal1015 wrote:

> I tried to compile the very simple kernel module code as following.
> I compile this code using gcc -c hello.c, but gcc tell me:
>  /usr/include/linux	/module.h:60 parse error before 'atomic_t'
> 
> What is the error? My gcc version is 2.96 and Redhat Linux 7.3


Script started on Tue Oct  1 15:15:14 2002
# cat >zzz.c
#ifndef __KERNEL__
#  define __KERNEL__
#endif
#ifndef MODULE
#  define MODULE
#endif
#include <linux/version.h>
#include <linux/config.h>
#include <linux/module.h>

#include <linux/kernel.h> /* printk */

int init_module(void)
{
	printk("<1>Hello the world\n");
	return 0;
}

void cleanup_module(void)
{
	printk("<1>Goodbye the world\n");	
}
# gcc -Wall -O2 -c -o zzz.o zzz.c
# insmod zzz.o
# rmmod zzz
# tail /var/s log/messages
Oct  1 01:02:36 chaos sendmail[26509]: g9152V126509: <pine.lnx.3.95.1010126095653.762a-100000@chaos.analogic.com>... User unknown
Oct  1 07:23:15 chaos login: ROOT LOGIN ON tty1
Oct  1 07:28:23 chaos sendmail[27618]: g91BSK127618: <100000@chaos.analogic.com>... User unknown
Oct  1 07:31:32 chaos sendmail[27648]: alias database /etc/mail/aliases rebuilt by root
Oct  1 08:16:18 chaos login: ROOT LOGIN ON tty2
Oct  1 11:13:46 chaos sendmail[30538]: g91FDf130538: <Pine.LNX.3.95.971112180225.1589A-100000@chaos.analogic.com>... User unknown
Oct  1 15:15:53 chaos kernel: Hello the world 
Oct  1 15:16:01 chaos kernel: Goodbye the world 
# exit
exit

Script done on Tue Oct  1 15:16:30 2002



Works here. You may have to always used -O2 to get in-lines to
work correctly.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

