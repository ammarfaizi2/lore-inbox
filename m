Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTKDQNt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 11:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTKDQNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 11:13:49 -0500
Received: from [62.38.236.240] ([62.38.236.240]:34740 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S262375AbTKDQNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 11:13:46 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: lsmod ipv6 on -test9 shows many refs, lockd
Date: Tue, 4 Nov 2003 18:14:24 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311041814.24731.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Question: is it normal for ipv6 module to have many refs while there is few 
ipv6 connections ?
My system is up for 3 days now. I have been using ACPI sleep and _ifconfig to 
alter the ip address_. 
lsmod gives:
	ipv6                  235904  34
and lsof -i6 only shows two ports listening on ipv6.
Even when I close all tcp (including v4) sockets, ipv6 still has around 10 
refs in lsmod.
Ten days ago (with -test7) I used to have a broken script for sshd that tried 
to bind to ipv6 every 20 mins. The result was that the count for ipv6.ko 
would reach as high as 900 w/o any bound sockets.
Does that constitute a leak? 

In other news, I haven't managed to trace the bug behind 'lockd', but I guess 
it's time I ask about it. After about 4 days uptime [1], both in -test7 and 
-test9, lockd BUGs at 'module.h, 296' . After that, nfs becomes unusable[2] 
and I have to reboot the kernel. The BUG is hit while I try to mount a nfs 
partition, which is being served by another 2.6 machine [3].
I can only report that this has happened. It may be related to the ipv6 leak, 
I guess..


[1] Every day, I switch from my home net to my work's net and back. I use 
ifconfig new_ip for that.
[2] lockd freezes, the 'mount' process gets <defunct> and nfs cannot be 
unloaded.
[3] At work, I mount nfs partitions to a *nix environment. I have not yet seen 
lockd freeze there.


