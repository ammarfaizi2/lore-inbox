Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbULCUc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbULCUc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbULCUcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 15:32:39 -0500
Received: from hermes.domdv.de ([193.102.202.1]:24588 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S262498AbULCUcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 15:32:06 -0500
Message-ID: <41B0CD41.1050105@domdv.de>
Date: Fri, 03 Dec 2004 21:32:01 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040918
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: 2.4.27  network related Oops
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do get an oops once about every one to two months (this time it took 
even 10 weeks), always during a nightly automated backup that is network 
load intensive via nfs and rmt as well as distributed data compression 
(memory intensive too due to a large streaming buffer). I never managed 
to catch the oops during several kernel versions until I took the time 
and installed netconsole. Now here's what I got from netconsole:

Oops: 0002
CPU:    0
EIP:    0010:[<c013ddc1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010013
eax: 000ff0c4   ebx: ffffffff   ecx: f7d22140   edx: 00000000
esi: c1c0f6a8   edi: 00000286   ebp: cc98d020   esp: ed541bac
ds: 0018   es: 0018   ss: 0018
Process cut (pid: 25393, stackpage=ed541000)
Stack:  cc31f3c0 0025ca70 0000c98d e1b55a40 00000003 e1b55aa0 cc98d020 
c02f1ea3
         cc98d000 00000358 e1b55a40 c02f1ff9 e1b55a40 00000202 fffffff4 
c0332733
         e1b55a40 c05f6290 cc98d020 e1b55a40 00000006 e1b55a40 cc98d020 
c0332849
Call Trace:
  [<c02f1ea3>]
  [<c02f1ff9>]
  [<c0332733>]
  [<c0332849>]
  [<c0313831>]
  [<c02fe903>]
  [<c0313760>]
  [<c03132e4>]
  [<c0313760>]
  [<c0313ab9>]
  [<c03138d0>]
  [<c02fe903>]
  [<c03138d0>]
  [<c03136cb>]
Warning (Oops_read): Code line not seen, dumping what data is available


 >>EIP; c013ddc1 <kfree+51/d0>   <=====

 >>ecx; f7d22140 <_end+376713c8/38275308>
 >>esi; c1c0f6a8 <_end+155e930/38275308>
 >>ebp; cc98d020 <_end+c2dc2a8/38275308>
 >>esp; ed541bac <_end+2ce90e34/38275308>

Trace; c02f1ea3 <kfree_skbmem+13/70>
Trace; c02f1ff9 <__kfree_skb+f9/150>
Trace; c0332733 <raw_rcv_skb+93/170>
Trace; c0332849 <raw_rcv+39/60>
Trace; c0313831 <ip_local_deliver_finish+d1/170>
Trace; c02fe903 <nf_hook_slow+b3/180>
Trace; c0313760 <ip_local_deliver_finish+0/170>
Trace; c03132e4 <ip_local_deliver+1a4/1d0>
Trace; c0313760 <ip_local_deliver_finish+0/170>
Trace; c0313ab9 <ip_rcv_finish+1e9/270>
Trace; c03138d0 <ip_rcv_finish+0/270>
Trace; c02fe903 <nf_hook_slow+b3/180>
Trace; c03138d0 <ip_rcv_finish+0/270>
Trace; c03136cb <ip_rcv+3bb/450>

The system seems to properly panic as it does properly auto-reboot. No 
hardware problem, this oops did occur on other hardware, too. And I do 
get the oops (if I remember right) since at least 2.4.20 if not earlier. 
The problem is just that it occurs very rarely, so it seems to be hard 
to trigger.
Oh, the problem is not NIC specific, it happened with epic100 on 100MBit 
as well as it happens now with e1000 on GBit ethernet.
The system the Oops (now) happens on is a Opteron 144 based server with 
ecc memory, currently running completely in 32bit mode. The system 
doesn't run X.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
