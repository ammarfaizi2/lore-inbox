Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283311AbRLWEEw>; Sat, 22 Dec 2001 23:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282962AbRLWEEn>; Sat, 22 Dec 2001 23:04:43 -0500
Received: from b0rked.dhs.org ([216.99.196.11]:11398 "HELO b0rked.dhs.org")
	by vger.kernel.org with SMTP id <S283311AbRLWEE2>;
	Sat, 22 Dec 2001 23:04:28 -0500
Date: Sat, 22 Dec 2001 20:04:24 -0800 (PST)
From: Chris Vandomelen <chrisv@b0rked.dhs.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Assigning syscall numbers for testing
In-Reply-To: <20011222182556.A19700@redhat.com>
Message-ID: <Pine.LNX.4.31.0112221956280.23282-100000@b0rked.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, that's not the case I'm talking about: what happens when a vendor
> starts shipping this patch and Linus decides to add a new syscall that
> uses a syscall number that the old kernel used for dynamic syscalls?

Isn't that a non-issue, based on the patch that was sent? So, you change
a few #define statements to point to other unused slots in the syscall
table, and you're good to go.

If I understood correctly, /proc/dynamic_syscalls contains the information
about dynamically registered syscall name->number associations, which are
placed beyond the end of the currently registered set of syscalls. Later
on down the line when we have 500 syscalls (exaggeration of course), the
patch should still work as intended by just telling it that the empty
slots in the syscall table begin at 501. So now your syscall that was
registered as syscall 241 with the dynamic syscall patch in 2.4.17 now
gets number 502 (or anything else for that matter) with the same patch
under 5.4.23. Whee.

Chris


