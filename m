Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291875AbSBNUs4>; Thu, 14 Feb 2002 15:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291851AbSBNUso>; Thu, 14 Feb 2002 15:48:44 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:45321 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S291829AbSBNUsc>; Thu, 14 Feb 2002 15:48:32 -0500
Message-ID: <3C6C2283.AC588246@linux-m68k.org>
Date: Thu, 14 Feb 2002 21:48:03 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
        davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>,
        anton@samba.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] move task_struct allocation to arch
In-Reply-To: <12214.1013706194@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

David Howells wrote:

> Ask Linus, he asked for the task_struct/thread_info split. Various people have
> complained about the two things being allocated separately (maintainers for
> m68k and ia64 archs certainly, and if I remember rightly, x86_64 as well,
> though I don't appear to have saved the message for that). However, DaveM
> (sparc64) appears to really be in favour of it.

Ok, so we have the following allocation possibilities.
1. allocate task_struct+thread_info+stack together.
2. allocate task_struct and thread_info+stack.
3. allocate task_struct+thread_info and stack.

1. is what we have so far and I hope Linus actually means a
task_struct/stack split. Linus, could you please clarify?
Architectures without a thread register want either the first or second
option. I don't really have an opinion, whether the first option should
be made obsolete. For architectures with a thread register the third
option makes most sense and is not really a problem, we only have to
specify the dependency between task_struct and thread_info.

bye, Roman
