Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbTHYQcN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTHYQcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:32:13 -0400
Received: from p113.as-l007.contactel.cz ([212.65.200.113]:57216 "EHLO
	penguin.localdomain") by vger.kernel.org with ESMTP id S261938AbTHYQcJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:32:09 -0400
Date: Mon, 25 Aug 2003 18:32:06 +0200
From: Marcel Sebek <sebek64@post.cz>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] less /proc/net/igmp
Message-ID: <20030825163206.GA1340@penguin.penguin>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This Oops appears on 2.5.74+ kernels (including 2.6.0-test4) when
I'm trying to read /proc/net/igmp with 'less', 'cat' displays
the file content without oops:

LILO boot: linux init=/bin/bash
 ...
[snip]
 ...
bash# mount /proc
bash# cat /proc/net/igmp
Idx	Device    : Count Querier	Group    Users Timer	Reporter
bash# less /proc/net/igmp
Idx	Device    : Count Querier	Group    Users Timer	Reporter
bash# ifup -a
bash# cat /proc/net/igmp
Idx	Device    : Count Querier	Group    Users Timer	Reporter
1	lo        :     0      V2
				010000E0     1 0:FFFA22F0		0
bash# less /proc/net/igmp
Unable to handle kernel paging request at virtual address 08051be0
 printing eip:
08051be0
*pde = 0fb66067
*pfe = 00000000
Oops: 0004 [#1]
CPU:    0
EIP:    0073:[<08051be0>]    Not tainted
EFLAGS: 00010246
EIP is at 0x8051be0
eax: 0805fb68   ebx: 00000001   ecx: 00000000   edx: 00000019
esi: 08060649   edi: 08057543   ebp: bffffd8c   esp: bfffda50
ds: 007b   es: 007b   ss: 007b
Process less (pid 20, threadinfo = cfab6000 task = c13560cd)
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


EIP points to the begin of the function clr_linenum() in
less-374/linenum.c:78 (instruction 'push %ebp').

Kernel is compiled by gcc-2.95.4 (20011002) from Debian woody.
Less is from woody and also from the original sources.


-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

