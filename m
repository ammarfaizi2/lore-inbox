Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293101AbSCAPdd>; Fri, 1 Mar 2002 10:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293182AbSCAPdY>; Fri, 1 Mar 2002 10:33:24 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:12273 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S293101AbSCAPdF>; Fri, 1 Mar 2002 10:33:05 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0202280854250.15607-100000@home.transmeta.com> 
In-Reply-To: <Pine.LNX.4.33.0202280854250.15607-100000@home.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: recalc_sigpending() / recalc_sigpending_tsk() ? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Mar 2002 15:33:01 +0000
Message-ID: <22820.1014996781@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  Not a chance in hell. The backwards compatibility looks like a
> trivial one-liner:

>    compat-2.4.h:
> 	#define recalc_sigpending() recalc_sigpending(current)

> so what are you complaining about? 

It may be possible, but it's not a trivial one-liner. Am I missing 
something obvious? Other than the fact that you don't care, of course.

background.c: In function `jffs2_garbage_collect_thread':
background.c:116: warning: implicit declaration of function `recalc_sigpending'

$ grep recalc_sigpending background.i 
#define __ver_recalc_sigpending _ver_str(6682695c)
#define recalc_sigpending _set_ver(recalc_sigpending)
static inline void recalc_sigpending_Rsmp_6682695c(struct task_struct *t)
#define recalc_sigpending() recalc_sigpending(current)
                recalc_sigpending(get_current());
                recalc_sigpending(get_current());


I appreciate that the old recalc_sigpending(task) needed to stop working, 
to force people to stop doing recalc_sigpending(current). How about 
recalc_sigpending_cur() and recalc_sigpending_tsk() then?

--
dwmw2


