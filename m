Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317494AbSGTUiV>; Sat, 20 Jul 2002 16:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSGTUiV>; Sat, 20 Jul 2002 16:38:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317494AbSGTUiU>; Sat, 20 Jul 2002 16:38:20 -0400
Date: Sat, 20 Jul 2002 13:42:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org, <mingo@elte.hu>
Subject: Re: [PATCH] preempt-safe load_LDT
In-Reply-To: <1027196517.1085.769.camel@sinai>
Message-ID: <Pine.LNX.4.44.0207201340450.1492-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 20 Jul 2002, Robert Love wrote:
>
> Attached patch makes load_LDT preempt-safe per our off-list discussion.

It's buggy. It calls smp_processor_id() outside the preemption window, see
"load_LDT()".

I'd suggest making it use get/put_cpu() and to avoid the header file
dependencies moving it away from desc.h and into ldt.c instead.

		Linus

