Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267612AbTA3Tix>; Thu, 30 Jan 2003 14:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbTA3Tix>; Thu, 30 Jan 2003 14:38:53 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:1415 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S267612AbTA3Tiw>; Thu, 30 Jan 2003 14:38:52 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 30 Jan 2003 11:54:12 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: frlock and barrier discussion
In-Reply-To: <20030130182622.GR18538@dualathlon.random>
Message-ID: <Pine.LNX.4.50.0301301049150.962-100000@blue1.dev.mcafeelabs.com>
References: <3E396CF1.5000300@colorfullife.com> <20030130182622.GR18538@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Attached is a test app - could someone try it? I don't have access to a SMP
> system right now.

Try to put [g_val1, g_seq1] and [g_val2, g_seq2] on two different cache
lines and run it on a SMP system using CPUs with a partitioned cache
architecture. Even if you do an WMB on writer side, you might see a
different order w/out an RMB on the reader side. This because the two
cache lines might be committed to different partitions with different
loads, and the latest ( in time order ) commit might see a fastest path
due a lower traffic. An RMB on the reader side ( that is usually expensive )
wait for all CPUs's memory controllers to flush their stuff before
resuming execution.



- Davide

