Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbTLKJNj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 04:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264871AbTLKJNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 04:13:39 -0500
Received: from smtp-gw.fsdata.se ([195.35.82.150]:51161 "EHLO
	smtp-slave4.fsdata.se") by vger.kernel.org with ESMTP
	id S264870AbTLKJNg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 04:13:36 -0500
From: "Johan Ekenberg" <johan@ekenberg.se>
To: <linux-kernel@vger.kernel.org>
Cc: <johan@ekenberg.se>
Subject: 2.4.23 - repeated Oops with invalid EIP
Date: Thu, 11 Dec 2003 10:13:05 +0100
Message-ID: <LOBBIJGHMMDIKIINCCEIOEOCJJAA.johan@ekenberg.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Recipient-Split-By: smtp-slave4.fsdata.se
X-FSDATA-AntiSpamScore: 1.8
X-FSDATA-AntiSpamRules: MIME_QP_DEFICIENT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please Cc: replies to johan@ekenberg.se)

Description:
  "out of the blue" we started getting very frequent oopses on two large Internet servers.
  EIP is invalid, always starting with f7.
  Oopses reproduced with several different kernels including 2.4.23 "vanilla" (see below).
  *All* hardware has been replaced but oopses remain.

Hardware:
  SMP P3 and SMP P4 XEON
  DAC960 raid controller

Software:
  Apache/PHP/MySQL/Sendmail/Pureftpd etc (the usual Internet stuff)
  No changes in the setup to explain oopses.

Kernels:
  2.4.18-pre8 (previously used > 18 months w/o any problems)
  2.4.22      (running ~ two months w/o any problems)
  2.4.23      (just tried today)
    all completely static - no modules used
    all with patches for grsecurity and reiserfs-quota
  2.4.23 also tried without any patches at all, but same results

Kernel config: http://www19.aname.net/~johan/2.4.23-grsec-reiserquota-config.txt

Sample oops:
  ksymoops -m /path/to/System.map < oops.txt:
===============================================================================
Oops: 0000
CPU:    0
EIP:    0010:[<f784d7ab>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: bffffcf4   ebx: c37f4000   ecx: f784a000   edx: 00000000
esi: c0106deb   edi: 0000000b   ebp: c37f5fb8   esp: c37f5f80
ds: 0018   es: 0018   ss: 0018
Process ssh (pid: 18899, stackpage=c37f5000)
Stack: ffffffff ffffffff ffffffff 00000003 00000012 00000282 bffffcf4 eb7c6000
       00000000 eb7c6000 c01059ff c37f4000 c0106deb 0000000b bffff7b0 f784d99f
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<c01059ff>] [<c0106deb>]
Code: 8b 42 04 83 f8 ff c7 45 f0 20 00 00 00 c7 45 ec 3a 0a 00 00

>>EIP; f784d7aa <END_OF_CODE+37507676/????>   <=====
Trace; c01059fe <sys_execve+4e/60>
Trace; c0106dea <system_call+32/38>
Code;  f784d7aa <END_OF_CODE+37507676/????>
0000000000000000 <_EIP>:
Code;  f784d7aa <END_OF_CODE+37507676/????>   <=====
   0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  f784d7ac <END_OF_CODE+37507678/????>
   3:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  f784d7b0 <END_OF_CODE+3750767c/????>
   6:   c7 45 f0 20 00 00 00      movl   $0x20,0xfffffff0(%ebp)
Code;  f784d7b6 <END_OF_CODE+37507682/????>
   d:   c7 45 ec 3a 0a 00 00      movl   $0xa3a,0xffffffec(%ebp)
=================================================================================

Regards,
/Johan Ekenberg - Sweden

