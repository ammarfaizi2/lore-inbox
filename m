Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVKLGhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVKLGhy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 01:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVKLGhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 01:37:54 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:24221 "EHLO
	taverner.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932173AbVKLGhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 01:37:53 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] getrusage sucks
Date: Sat, 12 Nov 2005 06:37:36 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <dl42jg$s2$1@taverner.CS.Berkeley.EDU>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com> <20051111230223.GB7991@shell0.pdx.osdl.net> <dl3ad7$ikf$2@taverner.CS.Berkeley.EDU> <20051112005333.GC7991@shell0.pdx.osdl.net>
Reply-To: daw-usenet@taverner.CS.Berkeley.EDU (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.CS.Berkeley.EDU 1131777456 898 128.32.168.222 (12 Nov 2005 06:37:36 GMT)
X-Complaints-To: news@taverner.CS.Berkeley.EDU
NNTP-Posting-Date: Sat, 12 Nov 2005 06:37:36 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright  wrote:
>/proc/[pid]/stat. (fs/proc/array.c::do_task_stat).
>
>> Is there any argument
>> that disclosing it to everyone is safe?  Or is it just that no one has
>> ever given the security considerations much thought up till now?
>
>I guess it keeps falling in the "too theoretical" category.  It can be
>protected by policy, but default is open.

Ahh, I see.  I had never looked at /proc/[pid]/stat carefully before.

Well, making /proc/[pid]/stat world-readable by default looks pretty
dubious to me.  There's all sorts of stuff there that I suspect should
not be revealed: EIP, stack pointer, stats on paging and swapping, and
so on.  I suspect that this is not at all safe.  Most crypto algorithms
tend to fall apart when you have side channels like this.

Maybe no one cares, because no one uses Linux in a multi-user setting
where users are motivated to attack each other or attack the system.
But baking this kind of "privilege escalation" vulnerability into the
kernel by default doesn't seem like a good idea to me.
