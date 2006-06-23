Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWFWEBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWFWEBt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 00:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWFWEBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 00:01:49 -0400
Received: from terminus.zytor.com ([192.83.249.54]:45549 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751235AbWFWEBt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 00:01:49 -0400
Message-ID: <449B6790.9010806@zytor.com>
Date: Thu, 22 Jun 2006 21:01:20 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeff Dike <jdike@addtoit.com>, a.p.zijlstra@chello.nl, hugh@veritas.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
       christoph@lameter.com, mbligh@google.com, npiggin@suse.de,
       torvalds@osdl.org
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
References: <20060619175243.24655.76005.sendpatchset@lappy>	<20060619175253.24655.96323.sendpatchset@lappy>	<Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com>	<1151019590.15744.144.camel@lappy>	<20060623031012.GA8395@ccure.user-mode-linux.org> <20060622203123.affde061.akpm@osdl.org>
In-Reply-To: <20060622203123.affde061.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 22 Jun 2006 23:10:12 -0400
> Jeff Dike <jdike@addtoit.com> wrote:
> 
>> On Fri, Jun 23, 2006 at 01:39:49AM +0200, Peter Zijlstra wrote:
>>> (PS, 2.6.17-mm1 UML doesn't seem to boot)
>> I don't get that far - it doesn't build for me.  It dies in klibc thusly:
>>
>>   gcc -Wp,-MD,usr/klibc/syscalls/.typesize.o.d  -nostdinc -isystem /usr/lib/gcc/i386-redhat-linux/4.1.1/include -I/home/jdike/linux/2.6/test/linux-2.6.17/usr/include/arch/i386 -Iusr/include/arch/i386 -I/home/jdike/linux/2.6/test/linux-2.6.17/usr/include/bits32 -Iusr/include/bits32  -I/home/jdike/linux/2.6/test/linux-2.6.17/obj/usr/klibc/../include -I/home/jdike/linux/2.6/test/linux-2.6.17/usr/include -Iusr/include  -I/home/jdike/linux/2.6/test/linux-2.6.17/include -I/home/jdike/linux/2.6/test/linux-2.6.17/include2 -Iinclude2 -I/home/jdike/linux/2.6/test/linux-2.6.17/include -Iinclude  -I/home/jdike/linux/2.6/test/linux-2.6.17/include -D__KLIBC__=1 -D__KLIBC_MINOR__=4 -D_BITSIZE=32 -m32 -march=i386 -Os -g -fomit-frame-pointer -falign-functions=0 -falign-jumps=0 -falign-loops=0 -W -Wall -Wno-sign-compare -Wno-unused-parameter -c -o usr/klibc/syscalls/typesize.o usr/klibc/syscalls/typesize.c
>> usr/klibc/syscalls/typesize.c:1:23: error: syscommon.h: No such file or directory
> 
> That's probably a parallel kbuild race.  Type `make' again ;)

No, it's not.  It's a problem with O=, apparently; this patch fixes it:

http://www.kernel.org/git/?p=linux/kernel/git/hpa/linux-2.6-klibc.git;a=commitdiff;h=4e51186fb663b57ac7c53517947510d2e1e9de01;hp=79317ba49e3f83d40f37b59fcdd5bd7c7635ee32

	-hpa
