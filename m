Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbSLQSZR>; Tue, 17 Dec 2002 13:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbSLQSZR>; Tue, 17 Dec 2002 13:25:17 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:44980
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265351AbSLQSZQ>; Tue, 17 Dec 2002 13:25:16 -0500
Message-ID: <3DFF6DE4.4070600@redhat.com>
Date: Tue, 17 Dec 2002 10:33:08 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Matti Aarnio <matti.aarnio@zmailer.org>, Hugh Dickins <hugh@veritas.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212171017590.2702-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212171017590.2702-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Thus glibc startup should be able to just do
> 
> 	ptr = default_int80_syscall;
> 	if (AT_SYSINFO entry found)
> 		ptr = value(AT_SYSINFO)
> 
> and then you can just do a
> 
> 	call *ptr

This won't work as I just wrote but something similar I can make work.
I think the use of the TCB is the best thing to do.  Replicating the
info in all thread new thread's TCBs doesn't cost much and with NPTL
it's even lower cost since we reuse old TCBs.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

