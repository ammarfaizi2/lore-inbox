Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292311AbSBBQHm>; Sat, 2 Feb 2002 11:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292313AbSBBQHc>; Sat, 2 Feb 2002 11:07:32 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:49669 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S292311AbSBBQHS>; Sat, 2 Feb 2002 11:07:18 -0500
Message-ID: <3C5C0EAE.6266F70A@linux-m68k.org>
Date: Sat, 02 Feb 2002 17:07:10 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall latency improvement #1 (253p6)
In-Reply-To: <9849.1012317950@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

David Howells wrote:

> +/* this struct must occupy one 32-bit chunk so that is can be read in one go */
> +struct task_work {
> +       __s8    need_resched;
> +       __u8    syscall_trace;  /* count of syscall interceptors */
> +       __u8    sigpending;
> +       __u8    notify_resume;  /* request for notification on
> +                                  userspace execution resumption */
> +} __attribute__((packed));
> +

Did you test whether single stepping over a single syscall works? From
reading the patch/source I can't see how it should, but I haven't tested
it yet. The problem is that syscall tracing is only important at syscall
entry. At syscall exit we have to check whether single stepping is
active. These are two different operations, but I only see two tests
against syscall_trace.
BTW it doesn't work with 2.4, but there is no test for PT_DTRACE at all,
so it's not really surprising.

Second, could we move above structure into e.g. <asm/processor.h>? This
would allow architectures to reorder the bytes, as above is obviously
optimized for little endian machines.

bye, Roman
