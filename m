Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292182AbSBOVxb>; Fri, 15 Feb 2002 16:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292184AbSBOVxW>; Fri, 15 Feb 2002 16:53:22 -0500
Received: from are.twiddle.net ([64.81.246.98]:7562 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S292182AbSBOVxG>;
	Fri, 15 Feb 2002 16:53:06 -0500
Date: Fri, 15 Feb 2002 13:52:30 -0800
From: Richard Henderson <rth@twiddle.net>
To: David Howells <dhowells@redhat.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>, davidm@hpl.hp.com,
        "David S. Miller" <davem@redhat.com>, anton@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move task_struct allocation to arch
Message-ID: <20020215135230.A25047@twiddle.net>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linus Torvalds <torvalds@transmeta.com>, davidm@hpl.hp.com,
	"David S. Miller" <davem@redhat.com>, anton@samba.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <zippel@linux-m68k.org> <23603.1013777812@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <23603.1013777812@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Fri, Feb 15, 2002 at 12:56:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 12:56:52PM +0000, David Howells wrote:
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

I see.  Yes, that makes sense.  My mistake was following davem's
lead and pulling everything out of struct thread_struct.  In
reality, I shouldn't have moved hardly anything and $8 should
still point to current.


r~
