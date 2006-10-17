Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422875AbWJQJhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422875AbWJQJhs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 05:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423198AbWJQJhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 05:37:48 -0400
Received: from main.gmane.org ([80.91.229.2]:42217 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422875AbWJQJhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 05:37:47 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [build bug] x86_64, -git: Error: unknown pseudo-op: `.cfi_signal_frame'
Date: Tue, 17 Oct 2006 09:37:22 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnej8lv9.2lu.olecom@flower.upol.cz>
References: <20061016061037.GA12020@elte.hu> <1160980603.2388.9.camel@entropy> <20061016063602.GA4392@elte.hu> <20061016064300.GA5839@elte.hu>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo.

On 2006-10-16, Ingo Molnar wrote:
>
> * Ingo Molnar <mingo@elte.hu> wrote:
>
>> Note that i override 'CC' instead of specifying a 'CROSS' prefix. I 
>> suspect this means as-instr does not switch over to the 
>> cross-environment and thus mis-detected the gas version?

Do you mean 'CROSS_COMPILE' ?

> this did not solve it either - it seems if both CROSS and CC are set 
> then CC overrides it and CROSS is ignored? Removing the CC override 
> solved the problem. But how do i insert the 'distcc' that way? Seems 
> like a Kbuild breakage to me.

CC with friends is set like this:

+--[linux/Makefile]
|[...]
|AS		= $(CROSS_COMPILE)as
|LD		= $(CROSS_COMPILE)ld
|CC		= $(CROSS_COMPILE)gcc
|CPP		= $(CC) -E
|[...]
+--

So, i think, you must set 'CROSS_COMPILE' first and then 'CC' like this:
(exporing PATH in shell, of course)
+--
$ make CROSS_COMPILE=x86_64-pc-linux- 'CC=distcc $(CROSS_COMPILE)gcc'
+--

(BTW, it's funny to see arch-*unknown*-linux...
Like something is deeply hidden and is a very big secret ;)
____

