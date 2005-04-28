Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVD1Qih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVD1Qih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 12:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVD1Qih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 12:38:37 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:63699 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262166AbVD1Qia convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 12:38:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kLguILe/sK7cAcM3eExqz8ERi8SDegP6GQiXZVVXODARFIME96WsTlRxgl7BFiu3B/e0xpNUfw5+purSJifN50oW+BFJTF3z+5t4EqwgROxWjR391pUTAITuDIm64BMaekaIj4FzdjQooJmR7eFJ51By0HGzFe/uHPjFh6RXxnY=
Message-ID: <2cd57c90050428093851785879@mail.gmail.com>
Date: Fri, 29 Apr 2005 00:38:24 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Cc: Ruben Puettmann <ruben@puettmann.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050428084313.1e69f59d.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050427140342.GG10685@puettmann.net>
	 <20050427152704.632a9317.rddunlap@osdl.org>
	 <20050428090539.GA18972@puettmann.net>
	 <20050428084313.1e69f59d.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/05, Randy.Dunlap <rddunlap@osdl.org> wrote:
> On Thu, 28 Apr 2005 11:05:40 +0200
> Ruben Puettmann <ruben@puettmann.net> wrote:
> 
> > On Wed, Apr 27, 2005 at 03:27:04PM -0700, Randy.Dunlap wrote:
> >  Looks like this code in init/main.c:
> > >
> > >     if (late_time_init)
> > >             late_time_init();
> > >
> > > sees a garbage value in late_time_init (garbage being
> > > %eax == 0x00307974.743d656c, which is "le=tty0\n",
> > > as in "console=tty0").
> > >
> > > How long is your kernel boot/command line?
> > > Please post it.
> >
> > It was boot over pxe here is the append line from the
> > pxelinux.cfg/default
> >
> > APPEND vga=normal rw  load_ramdisk=0 root=/dev/nfs nfsroot=192.168.112.1:/store/rescue/sarge-amd64,rsize=8192,wsize=8192,timo=12,retrans=3,mountvers=3,nfsvers=3
> 
> Hm, no "console=tty...." at all.  That didn't help (me) much.

Could that boot loader pxe append console=tty implicitly?

>From the vmlinux Ruben gave me,
ffffffff807980d8 A __bss_start
ffffffff807980d8 A _edata
ffffffff80798100 B boot_cpu_stack
ffffffff8079c100 B boot_exception_stacks
ffffffff807a1100 B system_state
ffffffff807a1120 B saved_command_line
ffffffff807a1220 B late_time_init
ffffffff807a1228 b execute_command
ffffffff807a1230 b panic_later
ffffffff807a1238 b panic_param
...

It seems possible to luckily skip the garbage. Comment out the two
lines and see if it works.

/*     if (late_time_init)
             late_time_init(); */

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
