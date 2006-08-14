Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWHNAyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWHNAyQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 20:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWHNAyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 20:54:15 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:28976 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750719AbWHNAyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 20:54:15 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@osdl.org>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-netdev <netdev@vger.kernel.org>
Subject: Re: 2.6.18-rc3-mm2 (+ hotfixes): GPF related to skge on suspend 
In-reply-to: Your message of "Sun, 13 Aug 2006 17:35:03 MST."
             <20060813173503.e009583c.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Aug 2006 10:54:21 +1000
Message-ID: <17555.1155516861@ocs10w.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (on Sun, 13 Aug 2006 17:35:03 -0700) wrote:
>On Mon, 14 Aug 2006 10:21:55 +1000
>Keith Owens <kaos@ocs.com.au> wrote:
>
>> ksymoops -VKLMO -t elf64-x86-64 -a i386:x86-64
>
>box:/home/akpm> ksymoops -VKLMO -t elf64-x86-64 -a i386:x86-64 < x
>ksymoops 2.4.11 on x86_64 2.6.17-rc5.  Options used
>     -V (specified)
>     -K (specified)
>     -L (specified)
>     -O (specified)
>     -M (specified)
>     -t elf64-x86-64 -a i386:x86-64
>
>Warning (merge_maps): no symbols in merged map
>CPU 0
>...
> [<ffffffff80471e5b>] _spin_unlock_irq+0x2b/0x60
> [<ffffffff8020a2c0>] restore_args+0x0/0x30
> [<ffffffff80243620>] kthread+0x0/0x110
> [<ffffffff8020a6fe>] child_rip+0x0/0x12
>Code: 44 8b 28 c7 45 d0 00 00 00 00 45 85 ed 0f 89 29 fb ff ff e9
>Error (Oops_bfd_perror): /tmp/ksymoops.0lrVNY Invalid bfd target
>
>box:/home/akpm> rpm -qi ksymoops 
>Name        : ksymoops                     Relocations: (not relocatable)
>Version     : 2.4.11                            Vendor: (none)
>Release     : 1                             Build Date: Sat Jan  8 05:43:45 2005
>Install Date: Wed Jun 28 16:59:45 2006      Build Host: ocs3.ocs.com.au
>Group       : Utilities/System              Source RPM: ksymoops-2.4.11-1.src.rpm

Back in 2000 there were a lot of version problems between ksymoops and
libbfd and libiberty, so I statically link against these libraries when
I build the rpm.  You have an i386 version of ksymoops, which was built
against an i386 only version of libbfd, it does not support target
elf64-x86-64.  Grab the ksymoops src.rpm and rebuild on x86_64, or use
a binary rpm from an x86_64 distribution.

