Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262731AbREOLPm>; Tue, 15 May 2001 07:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262734AbREOLPc>; Tue, 15 May 2001 07:15:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51390 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262731AbREOLPR>;
	Tue, 15 May 2001 07:15:17 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15105.4031.414577.452451@pizda.ninka.net>
Date: Tue, 15 May 2001 04:15:11 -0700 (PDT)
To: Andrew Morton <andrewm@uow.edu.au>
Cc: kuznet@ms2.inr.ac.ru, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: NETDEV_CHANGE events when __LINK_STATE_NOCARRIER is modified
In-Reply-To: <3B010C64.556758D8@uow.edu.au>
In-Reply-To: <3B006F84.C1427EB3@uow.edu.au>
	<200105150902.NAA29079@ms2.inr.ac.ru>
	<3B010C64.556758D8@uow.edu.au>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton writes:
 > > Again, BKL has nothing to do with this (and ioctl does not hold it)
 > 
 > asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 > {       
 >         struct file * filp;
 >         unsigned int flag;
 >         int on, error = -EBADF;
 > 
 >         filp = fget(fd);
 >         if (!filp)
 >                 goto out;
 >         error = 0;
 >         lock_kernel();
 > 
 > The CPU running ifconfig spins here.

Alexey's brain is going through net/socket.c:sock_ioctl() :-)

There we drop the kernel lock...

Later,
David S. Miller
davem@redhat.com
