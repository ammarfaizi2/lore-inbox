Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUEAVkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUEAVkT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 17:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUEAVkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 17:40:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:28882 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261580AbUEAVkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 17:40:13 -0400
Date: Sat, 1 May 2004 14:39:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, kaos@sgi.com
Subject: Re: [PATCH][2.6-mm] Allow i386 to reenable interrupts on lock
 contention
Message-Id: <20040501143955.10d1cea1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405010628030.2332@montezuma.fsmlabs.com>
References: <2015.1083331968@ocs3.ocs.com.au>
	<Pine.LNX.4.58.0405010628030.2332@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> +	#define spin_lock_string_flags \
>  +		"\n1:\t" \
>  +		"lock ; decb %0\n\t" \
>  +		"jns 4f\n" \
>  +		"testl $0x200, %1\n\t" \
>  +		"jz 2f\n\t" \
>  +		"sti\n\t" \
>  +		"jmp 2f\n\t" \
>  +		LOCK_SECTION_START("") \
>  +		"2:\t" \
>  +		"rep;nop\n\t" \
>  +		"cmpb $0, %0\n\t" \
>  +		"jle 2b\n\t" \
>  +		"jmp 3f\n\t" \
>  +		LOCK_SECTION_END \
>  +		"3:\t" \
>  +		"cli\n\t" \
>  +		"jmp 1b\n" \
>  +		"4:\t"

Could we move all the irq-handling stuff into the out-of-line section, to
keep the fast-path cache footprint smaller?

