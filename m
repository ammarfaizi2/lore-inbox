Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268432AbRGXTPm>; Tue, 24 Jul 2001 15:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268436AbRGXTPd>; Tue, 24 Jul 2001 15:15:33 -0400
Received: from [217.12.160.2] ([217.12.160.2]:26980 "EHLO yepa.com")
	by vger.kernel.org with ESMTP id <S268432AbRGXTPY>;
	Tue, 24 Jul 2001 15:15:24 -0400
Message-ID: <3B5DC959.7C3CCB8F@yepa.com>
Date: Tue, 24 Jul 2001 21:15:37 +0200
From: Luca Venturini <luca@yepa.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: Italian, it, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "mazzaro@inwind.it" <mazzaro@inwind.it>, alan.cox@linux.org
Subject: Re: URGENT: Bug in ptrace()
In-Reply-To: <GGZG1N$IUdIOnzYcrd2i0brgDIkl7XCtbAQK_Zw0pdyqLQY9plM@inwind.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi all,

I patched it for kernel 2.2.12 and 2.2.19:

just replace

                if ((!child->dumpable ||
                    (current->uid != child->euid) ||
                    (current->uid != child->suid) ||
                    (current->uid != child->uid) ||
                    (current->gid != child->egid) ||
                    (current->gid != child->sgid) ||

with

                if ((!child->dumpable ||
                    (child->suid == 0) ||
                    (current->uid != child->euid) ||
                    (current->uid != child->suid) ||
                    (current->uid != child->uid) ||
                    (current->gid != child->egid) ||
                    (current->gid != child->sgid) ||

in /usr/src/linux/arch/i386/kernel/ptrace.c

This way nobody can "ATTACH" with ptrace a setuited task.

I do not know if this can be useful. Maybe the gurus in
the list can say something about it.

Is it even useful for new kernels?

Thanks.

Luca Venturini
Yepa S.r.l.

"mazzaro@inwind.it" wrote:
> 
> Hi all,
> 
> The exploit found on http://www.securiteam.com/exploits/5NP061P4AW.html
> 
> Still works on the latest 2.2 that's to say (I Think), 2.2.19
> 
> How can it be?
> 
> There are still a lot of machines on the net which use that ker.
> 
> Thank you for your attenction...
> 
> P.S.
> The exploit works even on the latest kernel (of the 2.2 series, off course), found on
> ftp://updates.redhat.com/6.2/en/
> 
> P.P.S.
> I'm trying to follow the ML, but the traffic is too high for me...:-(
> So, if you can... could you answer to my address?
> 
> Thank you,
> 
> Silvio Mazzaro
