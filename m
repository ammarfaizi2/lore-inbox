Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbTJMFvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 01:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTJMFvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 01:51:53 -0400
Received: from cartman.gtsi.sk ([62.168.96.9]:58078 "EHLO cartman.gtsi.sk")
	by vger.kernel.org with ESMTP id S261476AbTJMFvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 01:51:50 -0400
Subject: Re: Oops on APM wakeup on 2.4.22/23-pre, works with 2.6.0-test
In-Reply-To: <3F89B310.2050805@colorfullife.com>
To: Manfred Spraul <manfred@colorfullife.com>
Date: Mon, 13 Oct 2003 07:51:47 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org, sfr@canb.auug.org.au, apmd-list@lists.nit.ca
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1A8vcS-0000Yj-00@trillian.meduna.org>
From: Stanislav Meduna <stano@meduna.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Perhaps the same bug I fixed today in 2.6?
>
> Could you try the attached patch? It's untested but should fix the 
> double oops.

OK, it did. Thanks.

With your patch none of the trace gets printed, so maybe the
stack is really messed somehow. Now I get the oops,
but the machine wakes up and works normally afterwards.
The output is:


ksymoops 2.4.9 on i586 2.4.23-pre7-ford.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-pre7-ford/ (default)
     -m /boot/System.map-2.4.23-pre7-ford (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct 13 07:37:21 ford kernel: NMI: IOCK error (debug interrupt?)
Oct 13 07:37:21 ford kernel: CPU:    0
Oct 13 07:37:21 ford kernel: EIP:    0050:[<000047ce>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 13 07:37:21 ford kernel: EFLAGS: 00000082
Oct 13 07:37:21 ford kernel: eax: 00270000   ebx: 07000001   ecx: 00000002   edx: 00000000
Oct 13 07:37:21 ford kernel: esi: c5a8b420   edi: 00000096   ebp: 00000096   esp: c4fb7ef2
Oct 13 07:37:21 ford kernel: ds: 0000   es: 0000   ss: 0018
Oct 13 07:37:21 ford kernel: Process apmd (pid: 259, stackpage=c4fb7000)
Oct 13 07:37:21 ford kernel: Stack: 0000ea27 00000096 0000c27b 5307c064 c03ac03f 00000048 f79d0000 0010c010 
Oct 13 07:37:21 ford kernel:        00000000 00960000 00180000 00180000 12150000 0000c012 0000c117 41020000 
Oct 13 07:37:21 ford kernel:        b4200000 11c0c5a8 6400c500 f862c4fc 5307c010 00010000 00020000 7f540000 
Oct 13 07:37:21 ford kernel: Call Trace:   
Oct 13 07:37:21 ford kernel: Code:  Bad EIP value.


>>EIP; 000047ce Before first symbol   <=====

>>esi; c5a8b420 <_end+57aff14/6562b54>
>>esp; c4fb7ef2 <_end+4cdc9e6/6562b54>


1 warning issued.  Results may not be reliable.


> Any objections against adding lkml back to the cc list? I dropped it 
> accidentially.

OK, I added the addresses back.

Thanks
-- 
                                     Stano

