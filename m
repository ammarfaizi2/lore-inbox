Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbUDON4C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 09:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263882AbUDON4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 09:56:02 -0400
Received: from gwb.able.be ([213.49.26.8]:10514 "EHLO gwb.able.be")
	by vger.kernel.org with ESMTP id S263796AbUDONz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 09:55:56 -0400
Message-ID: <407E93F9.3010105@able.be>
Date: Thu, 15 Apr 2004 15:54:01 +0200
From: Wim Ceulemans <wim.ceulemans@able.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312 Debian/1.6-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: dev@able.be
Subject: Kernel panic using frame relay protocol and IPSec
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Disclaimer-aXs-GUARD: aXs GUARD Disclaimer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Could answers be cc'd to me personally, because I am not subscribed to 
the list.

We are using kernel 2.4.24 and super-freeswan 1.99.8.
When using the frame relay protocol when a psk tunnel is established, we 
are seeing a kernel panic when we ping through the tunnel.

This is the trace:

kernel BUG at skbuff.c:109!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01bdbd1>]       Not tainted
EFLAGS: 00010286
eax: 00000028   ebx: cf79fec0   ecx: c8f60000   edx: c6cfce00
esi: cbb28000   edi: c8f618ac   ebp: 00000010   esp: c8f61854
ds: 0018        es: 0018        ss: 0018
Process ping (pid: 2323, stackpage=c8f61000)
Stack: c0232bc0 d0043f17 0000008c 00000004 cbb28000 d0043f20 cf79fec0 
00000004
      d0043f17 cbb28164 cbb28000 00000004 c8f618a4 d004436f c8f618ac 
00000010
      cf79fec0 cbb28000 00000004 cc73fcc0 00000000 c01c176a cf79fec0 
cbb28000
Call Trace:    [<d0043f17>] [<d0043f20>] [<d0043f17>] [<d004436f>] 
[<c01c176a>]
 [<c01d87c3>] [<c01d8730>] [<c01c8a96>] [<d01ddd8c>] [<c01d8712>] 
[<c01d8730>]
 [<d01ddd8c>] [<d01dddb6>] [<c01c8a96>] [<d01dccde>] [<d01ddd8c>] 
[<d0211520>]
 [<c018548e>] [<c013110a>] [<c019c49e>] [<d017340f>] [<c01cb4f1>] 
[<d0211520>]
 [<d0211520>] [<c01c16f1>] [<d0211520>] [<d0211520>] [<c01d87c3>] 
[<d0211520>]
 [<c01d8730>] [<c01c8a96>] [<d0211520>] [<c01d871c>] [<c01d735a>] 
[<d0211520>]
 [<c01d8730>] [<d0211520>] [<c01d871c>] [<c01d8729>] [<c01c8a96>] 
[<c01d8020>]
 [<d0211520>] [<c01d871c>] [<c01effb7>] [<c01efc54>] [<c01f6b56>] 
[<c01baf95>]
 [<c01bbcbc>] [<c0110ba4>] [<c011cdf0>] [<c01bc4ab>] [<c0108823>]

Running ksymoops on this gives:

 >>ebx; cf79fec0 <_end+f4da4a0/fd71640>
 >>ecx; c8f60000 <_end+8c9a5e0/fd71640>
 >>edx; c6cfce00 <_end+6a373e0/fd71640>
 >>esi; cbb28000 <_end+b8625e0/fd71640>
 >>edi; c8f618ac <_end+8c9be8c/fd71640>
 >>esp; c8f61854 <_end+8c9be34/fd71640>

Trace; d0043f17 <[hdlc].text.start+eb7/2f0e>
Trace; d0043f20 <[hdlc].text.start+ec0/2f0e>
Trace; d0043f17 <[hdlc].text.start+eb7/2f0e>
Trace; d004436f <[hdlc].text.start+130f/2f0e>
Trace; c01c176a <dev_queue_xmit+17a/2c4>
Trace; c01d87c3 <ip_finish_output+1b3/568>
Trace; c01d8730 <ip_finish_output+120/568>
Trace; c01c8a96 <nf_hook_slow+ee/144>
Trace; d01ddd8c <END_OF_CODE+22a55/????>
Trace; c01d8712 <ip_finish_output+102/568>
Trace; c01d8730 <ip_finish_output+120/568>
Trace; d01ddd8c <END_OF_CODE+22a55/????>
Trace; d01dddb6 <END_OF_CODE+22a7f/????>
Trace; c01c8a96 <nf_hook_slow+ee/144>
Trace; d01dccde <END_OF_CODE+219a7/????>
Trace; d01ddd8c <END_OF_CODE+22a55/????>
Trace; d0211520 <END_OF_CODE+561e9/????>
Trace; c018548e <blkdev_release_request+7be/7e0>
Trace; c013110a <bread+1a/d0>
Trace; c019c49e <execute_drive_cmd+38e/3bc>
Trace; d017340f <[ip_conntrack].text.start+3af/313f>
Trace; c01cb4f1 <qdisc_restart+51/1a4>
Trace; d0211520 <END_OF_CODE+561e9/????>
Trace; d0211520 <END_OF_CODE+561e9/????>
Trace; c01c16f1 <dev_queue_xmit+101/2c4>
Trace; d0211520 <END_OF_CODE+561e9/????>
Trace; d0211520 <END_OF_CODE+561e9/????>
Trace; c01d87c3 <ip_finish_output+1b3/568>
Trace; d0211520 <END_OF_CODE+561e9/????>
Trace; c01d8730 <ip_finish_output+120/568>
Trace; c01c8a96 <nf_hook_slow+ee/144>
Trace; d0211520 <END_OF_CODE+561e9/????>
Trace; c01d871c <ip_finish_output+10c/568>
Trace; c01d735a <ip_options_undo+a22/1760>
Trace; d0211520 <END_OF_CODE+561e9/????>
Trace; c01d8730 <ip_finish_output+120/568>
Trace; d0211520 <END_OF_CODE+561e9/????>
Trace; c01d871c <ip_finish_output+10c/568>
Trace; c01d8729 <ip_finish_output+119/568>
Trace; c01c8a96 <nf_hook_slow+ee/144>
Trace; c01d8020 <ip_options_undo+16e8/1760>
Trace; d0211520 <END_OF_CODE+561e9/????>
Trace; c01d871c <ip_finish_output+10c/568>
Trace; c01effb7 <tcp_read_sock+12567/1476c>
Trace; c01efc54 <tcp_read_sock+12204/1476c>
Trace; c01f6b56 <unregister_inetaddr_notifier+17de/1b54>
Trace; c01baf95 <sock_sendmsg+69/88>
Trace; c01bbcbc <sock_create+694/f40>
Trace; c0110ba4 <__verify_write+164/834>
Trace; c011cdf0 <notify_parent+b70/c58>
Trace; c01bc4ab <sock_create+e83/f40>
Trace; c0108823 <__up_wakeup+104f/1464>

Is anyone aware of this problem or have a solution to this problem?

Regards

-- 
Wim Ceulemans
R&D Engineer

aXs GUARD, internet communication solutions
do IT safe, do IT with aXs GUARD
                                            
Able NV          
Leuvensesteenweg 282 - B-3190 Boortmeerbeek - Belgium 
Phone: + 32 15 50.44.00 - Fax: + 32 15 50.44.09
Mobile: +32 497 44.52.52
E-Mail: wim.ceulemans@able.be
http://www.axsguard.com
http://www.doITsafe.net

--
aXs GUARD has completed security and anti-virus checks on this e-mail
(http://www.axsguard.com)
