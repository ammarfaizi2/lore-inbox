Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289631AbSBONts>; Fri, 15 Feb 2002 08:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289735AbSBONti>; Fri, 15 Feb 2002 08:49:38 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:13834 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S289631AbSBONte>; Fri, 15 Feb 2002 08:49:34 -0500
Date: Fri, 15 Feb 2002 14:49:23 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: David Howells <dhowells@redhat.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>, <davidm@hpl.hp.com>,
        "David S. Miller" <davem@redhat.com>, <anton@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move task_struct allocation to arch 
In-Reply-To: <23603.1013777812@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.33.0202151439160.1001-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Feb 2002, David Howells wrote:

> Firstly, in response to me having supplied a patch that made a set of four
> byte-size values as the status area in the task_struct:
>
> | For the future, the biggest thing I'd like to see is actually to make
> | "work" be a bitmap, because the "bytes are atomic" approach simply isn't
> | portable anyway, so we might as well make things _explicitly_ atomic and
> | use bit operations. Otherwise the alpha version of "work" would have to be
> | four bytes per "bit" of information, which sounds really excessive.

As I mentioned before I more like the byte approach, since atomic bit
field handling is quite expensive on most architectures, where a simple
set/clear byte is only one or two instructions, if there is byte
load/store instruction. So I'd really like to see to leave the decision to
the architecture, whether to use bit or byte fields.

> And then after some discussion:
>
> | In particular, there's been all that discussion about cache-coloring the
> | "struct task_struct", and my personal suggestion for that whole can of
> | worms is to have the "struct low_level" be in the one low cache-line, and
> | make it contain a pointer to "struct task_struct" - and just split the two
> | up completely. Then the low-level asm code would never have to even look
> | at "task_struct", it would only look at this stuff.
>
> (struct low_level became thread_info).

That I can agree with. :)

bye, Roman

