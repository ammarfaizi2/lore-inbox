Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291741AbSBHS7O>; Fri, 8 Feb 2002 13:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291743AbSBHS7C>; Fri, 8 Feb 2002 13:59:02 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:63420 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S291745AbSBHS5x>;
	Fri, 8 Feb 2002 13:57:53 -0500
Date: Fri, 8 Feb 2002 19:01:06 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Balbir Singh <balbir_soni@hotmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] larger kernel stack (8k->16k) per task (fwd)
In-Reply-To: <F69rw2fk1VK68maChsd0001c218@hotmail.com>
Message-ID: <Pine.LNX.4.33.0202081849000.1359-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir,

On Fri, 8 Feb 2002, Balbir Singh wrote:
> 2. I think you missed getuser.S in arch/i386/kernel/lib.
>    All the __get_user_x should change to

no, I didn't miss them. If you read the patch again you will see them.

>
> 3. I verified that the instance of GET_CURRENT in hw-irq.h
>    is not being used by anybody and can safely be removed.

yes, I also verified and came to the same conclusion but left the change
in the patch on purpose (so if anyone does start using it, it is already
correct)

>
> __get_user_1:
>         movl %esp,%edx
>         andl $~(THREAD_SIZE - 1),%edx
>         cmpl addr_limit(%edx),%eax
>
> I have a patch that lets the user select any stack size
> from 8K to 64K, it can be configured. And yes, it works
> on my system.
>
> I do not have the /proc entry that u have though in
> my patch.
>
> Would you like to merge both the patches or would you
> like me to do it and send out a new version.
>
>
> The patch is attached along with this email. It
> is againt 2.4.17

The serious problem with your patch is that you missed quite a few places
(e.g.  smpboot.c and traps.c). Most importantly, you missed the alignment
in vmlinux.lds so I guess your machine boots by pure luck :) In the early
stages (first hours of writing it) I missed that one too and was puzzled
by random panics on boot...

Actually, the patch I sent is only part of the "complete piece", the other
part being changes to kdb to work correctly with large stack. I can
separate those from kdb patch that I use and send out if there was enough
interest.

Regards,
Tigran

