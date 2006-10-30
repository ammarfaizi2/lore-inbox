Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWJ3UjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWJ3UjS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbWJ3UjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:39:18 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:35854 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1030330AbWJ3UjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:39:17 -0500
Message-ID: <454662C5.8070607@shadowen.org>
Date: Mon, 30 Oct 2006 20:38:29 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andy Whitcroft <apw@shadowen.org>, Martin Bligh <mbligh@google.com>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
References: <20061029160002.29bb2ea1.akpm@osdl.org>	<45461977.3020201@shadowen.org>	<45461E74.1040408@google.com> <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com> <45463481.80601@shadowen.org>
In-Reply-To: <45463481.80601@shadowen.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> Martin Bligh wrote:
>>>> Setting up network interfaces:
>>>>      lo
>>>>     lo        IP address: 127.0.0.1/8
>>>> 7[?25l[1A[80C[10D[1;32mdone[m8[?25h    eth0
>>>>               No configuration found for eth0
>>>> 7[?25l[1A[80C[10D[1munused[m8[?25h    eth1
>>>>             No configuration found for eth1
>>>>
>>>> for all 8 cards.
>>>
>>> What version of udev is being used?
>> Buggered if I know. If we could quit breaking it, that'd be good though.
>> If it printed its version during boot somewhere, that'd help too.
>>
>>> Was CONFIG_SYSFS_DEPRECATED set?
>> No.
>>
>> M.
> 
> These all sounds pretty old.  I'll rerun them all with
> CONFIG_SYSFS_DEPRECATED set and see what pans out.
> 

Ok, these have all popped through.  Three of the four seems unchanged,
so I am inclined to think that turning on SYSFS_DEPRECATED has not
helped us.

One seems to have blown up differently:

Badness in enter_rtas at arch/powerpc/kernel/entry_64.S:641
Call Trace:
[C0000000FFF83080] [C000000000010470] .show_stack+0x74/0x1b4 (unreliable)
[C0000000FFF83130] [C00000000039FD84] .program_check_exception+0x1f4/0x6c8
[C0000000FFF83210] [C000000000004774] program_check_common+0xf4/0x100
--- Exception: 700 at .enter_rtas+0xa0/0x10c
    LR = .xmon_core+0x474/0x864
[C0000000FFF83500] [C0000000004D8D1C] 0xc0000000004d8d1c (unreliable)
[C0000000FFF836E0] [C00000000004FF60] .xmon_core+0x474/0x864
[C0000000FFF83870] [C0000000000505A8] .xmon+0x34/0x44
[C0000000FFF83A40] [C000000000025D80] .die+0x5c/0x1b8
[C0000000FFF83AD0] [C00000000002F248] .bad_page_fault+0xc4/0xe0
[C0000000FFF83B50] [C000000000004B98] .handle_page_fault+0x3c/0x54
--- Exception: 300 at .llc_init+0x34/0x8c
    LR = .init+0x1f4/0x3e4
[C0000000FFF83E40] [C00000000045CAB8] .md_init+0xf0/0x124 (unreliable)
[C0000000FFF83EC0] [C000000000009540] .init+0x1f4/0x3e4
[C0000000FFF83F90] [C0000000000275FC] .kernel_thread+0x4c/0x68
enter ? for help
[c0000000fff83ec0] c000000000009540 .init+0x1f4/0x3e4
[c0000000fff83f90] c0000000000275fc .kernel_thread+0x4c/0x68

-apw
