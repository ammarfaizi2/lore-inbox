Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266397AbRGKDyh>; Tue, 10 Jul 2001 23:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267086AbRGKDy1>; Tue, 10 Jul 2001 23:54:27 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:21510 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266397AbRGKDyX>;
	Tue, 10 Jul 2001 23:54:23 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Ed Tomlinson <tomlins@cam.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7-pre5 missing symbols?
In-Reply-To: Your message of "Tue, 10 Jul 2001 07:53:59 -0400."
             <20010710115400.5ED711C495@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 11 Jul 2001 13:54:18 +1000
Message-ID: <5194.994823658@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2001 07:53:59 -0400,
Ed Tomlinson <tomlins@cam.org> wrote:
>Is it just me or is there something missing?
>oscar# depmod -ae 2.4.7-pre5
>depmod: *** Unresolved symbols in /lib/modules/2.4.7-pre5/kernel/drivers/net/8139too.o
>depmod:         cpu_raise_softirq

Works for me.  Were you booted off the 2.4.7-pre5 kernel when you ran
depmod?  If you were booted off another kernel, you must run depmod
with -F 2.4.7-pre5/System.map.  If you were booted off the correct
kernel, cd to the top level 2.4.7-pre5 directory and run these
commands.

nm drivers/net/tulip/tulip.o | fgrep cpu_raise_softirq
nm vmlinux |
	egrep '__k[^_]*_cpu_raise_softirq|\<cpu_raise_softirq\>' |
	tee /dev/tty |
	awk '/__ks..tab/{ printf "objdump -s -j %s --start-addr=0x" $1 " vmlinux | head -10\n",
	  $3 ~ /__ksymtab/ ? "__ksymtab" : ".kstrtab"}' | sh

