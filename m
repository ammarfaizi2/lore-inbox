Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265237AbSKEGIW>; Tue, 5 Nov 2002 01:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbSKEGIW>; Tue, 5 Nov 2002 01:08:22 -0500
Received: from almesberger.net ([63.105.73.239]:28425 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265237AbSKEGIU>; Tue, 5 Nov 2002 01:08:20 -0500
Date: Tue, 5 Nov 2002 03:14:49 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Erik Andersen <andersen@codepoet.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, jw schultz <jw@pegasys.ws>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <20021105031449.E1408@almesberger.net>
References: <20021030161912.E2613@in.ibm.com> <20021031162330.B12797@in.ibm.com> <3DC32C03.C3910128@digeo.com> <20021102144306.A6736@dikhow> <1025970000.1036430954@flay> <20021105000010.GA21914@pegasys.ws> <1118170000.1036458859@flay> <20021105005745.E1407@almesberger.net> <20021105044216.GA4545@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105044216.GA4545@codepoet.org>; from andersen@codepoet.org on Mon, Nov 04, 2002 at 09:42:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> Hehe.  You just reinvented my old /dev/ps driver.  :)

Hmm, you still need 2+#pids operations, while my approach could
essentially do everything in a single read. Besides, many people
don't exactly love ioctls.

Furthermore, you'd need to version your big struct pid_info,
while my approach wouldn't have problems if fields are added or
removed (only if their content changes).

Two advantages of your approach are that the amount of data
cached in the kernel is limited to max(sizeof(pid_t)*#pids,
sizeof(struct pid_info)), and that you do less work under
tasklist_lock.

>     I do dislike /dev/ps mightily. If the problem is that /proc
>     is too large, then the right solution is to just clean up
>     /proc.  Which is getting done.  And yes, /proc will be larger
>     than /dev/ps, but I still find that preferable to having two
>     incompatible ways to do the same thing.

Hmm yes, so he might not like my /proc/grab-taskdata-FAST
either :)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
