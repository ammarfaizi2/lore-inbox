Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSGVEZd>; Mon, 22 Jul 2002 00:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSGVEZd>; Mon, 22 Jul 2002 00:25:33 -0400
Received: from smtp.cs.curtin.edu.au ([134.7.1.4]:53510 "EHLO
	smtp.cs.curtin.edu.au") by vger.kernel.org with ESMTP
	id <S316070AbSGVEZc>; Mon, 22 Jul 2002 00:25:32 -0400
Message-Id: <5.1.1.6.0.20020722121603.01cfbda0@pop.cs.curtin.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Mon, 22 Jul 2002 12:27:01 +0800
To: linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org
From: David Shirley <dave@cs.curtin.edu.au>
Subject: Kernel Panic 2.4.18 - 2.4.19-rc3 when using iptables
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have posted this Q to both the linux-kernel and netfilter mailing
lists.

This box is a Dual Athlon 2000+ running 2.4.18 as well as 2.4.19-rc3,
the box is stable up until I run my iptables init script. Which looks
something like this:

#!/bin/bash

iptables -F
iptables -A INPUT -s 127.0.0.0/8 -j ACCEPT

iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -s 134.7.1.0/24 -m record_rpc -j ACCEPT
iptables -A INPUT -s 134.7.2.0/24 -m record_rpc -j ACCEPT
iptables -A INPUT -s 134.7.3.0/24 -m record_rpc -j ACCEPT
iptables -A INPUT -s 134.7.7.0/24 -m record_rpc -j ACCEPT
iptables -A INPUT -s 134.7.5.0/24 -m record_rpc -j ACCEPT

iptables -A INPUT -p tcp -s 134.7.1.1/32 --dport 513:514 -j ACCEPT
iptables -A INPUT -p tcp -s 134.7.1.60/32 --dport 5555 -j ACCEPT

iptables -A INPUT -p tcp --syn -j REJECT

iptables -A INPUT -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -j LOG
iptables -P INPUT DROP

As you can see i'm using the RPC connection tracking module
that comes with the patch-o-matic stuff.

About 1-2 minutes after I run this script the box hangs, and prints out
a bunch of register and stack info which I couldn't be bothered to
type in :P

It does say "Code: Bad EIP value" though.

Does anyone know what this could be?

Cheers
Dave




/-----------------------------------
David Shirley
System's Administrator
Computer Science - Curtin University
(08) 9266 2986
-----------------------------------/

