Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTFSV7S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 17:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTFSV7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 17:59:18 -0400
Received: from vsmtp4.tin.it ([212.216.176.224]:26867 "EHLO vsmtp4.tin.it")
	by vger.kernel.org with ESMTP id S261151AbTFSV7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 17:59:16 -0400
Date: Fri, 20 Jun 2003 00:13:13 +0000
From: Giuliano Pochini <pochini@shiny.it>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.4.21+pppoe
Message-Id: <20030620001313.2f8e3279.pochini@shiny.it>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a pppoe connection is up, any change to the ethernet config causes an
oops. In this case I did "ifconfig eth0 down", but it also oopses if I add
a secondary address. These are two oopses caused by the command above:


NIP: D2036E48 XER: 00000000 LR: D2036E1C SP: C7BCFE20 REGS: c7bcfd70 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c7bce000[1012] 'pppd' Last syscall: 102
last math c7bce000 last altivec 00000000
GPR00: 000000F0 C7BCFE20 C7BCE000 00000000 CF54848F 00000006 CF54848F 00000010
GPR08: 000030D4 00000000 00000006 C0012FF0 40000089 10053474 10050000 10050000
GPR16: 10050000 10050000 10050000 10050000 00009032 07BCFF40 00000000 C00060B4
GPR24: C0270000 00000000 C7BCFE58 100496B4 CF548460 C0271AA0 C7E5A040 C0270000
Call backtrace:
D2036E1C C014201C C0142AA4 C0005E7C 10050000 0FDE98C4 1000620C
0FE5FF70 00000000
Warning (Oops_read): Code line not seen, dumping what data is available

>>NIP; d2036e48 <[pppoe]pppoe_connect+120/2f0>   <=====
Trace; d2036e1c <[pppoe]pppoe_connect+f4/2f0>
Trace; c014201c <tcp_read_sock+1cb4/19a6c>
Trace; c0142aa4 <tcp_read_sock+273c/19a6c>
Trace; c0005e7c <set_context+287c/28a8>
Trace; 10050000 Before first symbol
Trace; 0fde98c4 Before first symbol
Trace; 1000620c Before first symbol
Trace; 0fe5ff70 Before first symbol
Trace; 00000000 Before first symbol

[I rebooted here]

NIP: D2036E48 XER: 00000000 LR: D2036E1C SP: CAE47E20 REGS: cae47d70 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = cae46000[943] 'pppd' Last syscall: 102
last math cae46000 last altivec 00000000
GPR00: 000000F0 CAE47E20 CAE46000 00000000 CF54BF6F 00000006 CF54BF6F 00000010
GPR08: 00003634 00000000 00000006 C0013574 40000089 10053474 10050000 10050000
GPR16: 10050000 10050000 10050000 10050000 00009032 0AE47F40 00000000 C0005EB0
GPR24: C0230000 00000000 CAE47E58 100496B4 CF54BF40 C0235980 CAFE7680 C0230000
Call backtrace:
D2036E1C C011E74C C011F1D4 C0005C7C 10050000 0FDE98C4 1000620C
0FE5FF70 00000000
Warning (Oops_read): Code line not seen, dumping what data is available

>>NIP; d2036e48 <[pppoe]pppoe_connect+120/2f0>   <=====
Trace; d2036e1c <[pppoe]pppoe_connect+f4/2f0>
Trace; c011e74c <sock_create+56c/10e4>
Trace; c011f1d4 <sock_create+ff4/10e4>
Trace; c0005c7c <set_context+267c/28a8>
Trace; 10050000 Before first symbol
Trace; 0fde98c4 Before first symbol
Trace; 1000620c Before first symbol
Trace; 0fe5ff70 Before first symbol
Trace; 00000000 Before first symbol


23 warnings and 1 error issued.  Results may not be reliable.


[Giu@Jay Giu]$ uname -a
Linux Jay 2.4.21 #1 sab giu 14 15:41:20 UTC 2003 ppc unknown
[root@Jay root]# pppd --help
pppd version 2.4.2b1




--
Bye.
   Giuliano.

