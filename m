Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311897AbSCOBeI>; Thu, 14 Mar 2002 20:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311896AbSCOBd7>; Thu, 14 Mar 2002 20:33:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64518 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311897AbSCOBdm>; Thu, 14 Mar 2002 20:33:42 -0500
Subject: Re: [PATCH-RFC] POSIX Event Logging, kernel 2.5.6 & 2.4.18y
To: kessler@us.ibm.com (Larry Kessler)
Date: Fri, 15 Mar 2002 01:49:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3C914BC3.2B05C62E@us.ibm.com> from "Larry Kessler" at Mar 14, 2002 05:17:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lgqT-0002Vv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am absolutely open to suggestions for making printk messages better
> and more useful--we just haven't figured-out how yet.

What you don't want to do is break printk. In AberMUD I used macros for
something similar

#define Module  static char *Mod_Name=
#define Version static char *Ver_Name=
#define Author  static char *Aut_Name=

#define Error(x)        ErrFunc((x),Mod_Name,Ver_Name,__LINE__,__FILE__)

And drivers started

Module  "System";
Version "1.28";
Author  "----*(A)";


However that doesn't work for varargs. Nevertheless something of a similar
approach might let you avoid breaking printk in most old code. If you can
avoid a grand replacement of printk you win lots of friends. If you can
do it in a way that people can do automated parsing of kernel messages
for translation tables in klogd/initlog/dmesg you also win lots of friends.

