Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271759AbRIJV0G>; Mon, 10 Sep 2001 17:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271757AbRIJVZr>; Mon, 10 Sep 2001 17:25:47 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:43806 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271747AbRIJVZa>; Mon, 10 Sep 2001 17:25:30 -0400
Subject: Re: Preemption patch, some more feedback
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0109101132410.4681-100000@toy.mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.30.0109101132410.4681-100000@toy.mandrakesoft.com>
X-Mailer: Evolution/0.13.99+cvs.2001.09.08.07.08 (Preview Release)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.08.07.08 (Preview Release)
Date: 10 Sep 2001 17:26:08 -0400
Message-Id: <1000157173.18895.24.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-09-10 at 11:41, Francis Galiegue wrote:
> Machine is Athlon 650, AMD Viper chipset, 256 MB RAM. Kernel is
> 2.4.9-ac10 + preempt patch + irc_conntrack patch from iptables.
> 
> The preempt patch largely improves multimedia latency (no surprise on
> that), I can watch a DivX smoothly (with mplayer, gfx being Matrox G400)
> and compile various stuff behind.
> 
> However, a very simple command destroys this completely:
> 
> cat /dev/zero >/dev/null
> 
> DivX playback then becomes sluggish, no visible difference in this case
> between stock kernel and "preempt" kernel.

A long-term lock must be held for the duration of `cat /dev/zero >
/dev/null' -- i dont know if it is in the access to /dev/null or
/dev/zero or in the basic file operation itself.

as long as a lock is held, preemption can not occur.

what do we do? for the short term, and the benefit of everyone (UP, SMP,
and preemption users) we need to eliminate long-held locks with a better
solution.

in the long term, we can look at having the preemption patch use various
different types of locks (priority locks, spin then sleep locks, etc.)

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

