Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWHNBKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWHNBKP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 21:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWHNBKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 21:10:14 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:30768 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751416AbWHNBKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 21:10:13 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@osdl.org>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-netdev <netdev@vger.kernel.org>
Subject: Re: 2.6.18-rc3-mm2 (+ hotfixes): GPF related to skge on suspend 
In-reply-to: Your message of "Sun, 13 Aug 2006 18:06:02 MST."
             <20060813180602.630e60e3.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Aug 2006 11:10:19 +1000
Message-ID: <17997.1155517819@ocs10w.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (on Sun, 13 Aug 2006 18:06:02 -0700) wrote:
>On Mon, 14 Aug 2006 10:54:21 +1000
>Keith Owens <kaos@ocs.com.au> wrote:
>
>> >Code: 44 8b 28 c7 45 d0 00 00 00 00 45 85 ed 0f 89 29 fb ff ff e9
>> >Error (Oops_bfd_perror): /tmp/ksymoops.0lrVNY Invalid bfd target
>> >
>> >box:/home/akpm> rpm -qi ksymoops 
>> >Name        : ksymoops                     Relocations: (not relocatable)
>> >Version     : 2.4.11                            Vendor: (none)
>> >Release     : 1                             Build Date: Sat Jan  8 05:43:45 2005
>> >Install Date: Wed Jun 28 16:59:45 2006      Build Host: ocs3.ocs.com.au
>> >Group       : Utilities/System              Source RPM: ksymoops-2.4.11-1.src.rpm
>> 
>> Back in 2000 there were a lot of version problems between ksymoops and
>> libbfd and libiberty, so I statically link against these libraries when
>> I build the rpm.  You have an i386 version of ksymoops, which was built
>> against an i386 only version of libbfd, it does not support target
>> elf64-x86-64.  Grab the ksymoops src.rpm and rebuild on x86_64, or use
>> a binary rpm from an x86_64 distribution.
>
>But would such a binary be able to decode i386 oopses?

It depends on your versions of bfdutils and binutils.  ksymoops does
not decode the object itself, it uses bfd and objdump to do the work.
FWIW, the version of ksymoops in suselinux 10.0 for x86_64 will handle
both i386 and x86_64.

>ftp://ftp.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/ksymoops-2.4.11-1.src.rpm
>fails to build, btw.  Had to do s/Copyright/License/ in the spec file.

Ah, the joys of changing RPM standards.

