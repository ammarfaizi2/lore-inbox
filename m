Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292464AbSBUPmP>; Thu, 21 Feb 2002 10:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292465AbSBUPlz>; Thu, 21 Feb 2002 10:41:55 -0500
Received: from [66.150.46.254] ([66.150.46.254]:14120 "EHLO mail.tvol.net")
	by vger.kernel.org with ESMTP id <S292464AbSBUPln>;
	Thu, 21 Feb 2002 10:41:43 -0500
Message-ID: <3C751531.AFFA30B1@wgate.com>
Date: Thu, 21 Feb 2002 10:41:37 -0500
From: Michael Sinz <msinz@wgate.com>
Organization: WorldGate Communications Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; FreeBSD 4.5-STABLE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] kernel 2.5.5 - coredump sysctl
In-Reply-To: <200202211512.g1LFC8Y27614@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> Would it be cleaner to use snprintf here ? Each of those checks you do
> appears to come down to
> 
>         buf+=snprintf(buf, sizeof(buffer)+buffer-buf, "%foo", arg)

	buf+=snprintf(buf, MAX_CORE_NAME - buf, "%foo", arg)

Hmm.... I was trying to keep things clear but if snprintf() is what
is prefered, it could be done so.  Most of the items here are just
string copies anyway, so the loop is trivial (and snprintf is
much higher overhead) 

snprintf is a bit more annoying due to the fact that snprintf returns
the number of bytes that *would have been written* and not the number
of bytes actually written if the limit is reached.  (Or, in older C
libraries, it returns -1 if the limit is hit)

(Don't complain to me that snprintf() is like that, it is C99 standard.
Older glibc have the -1 return code, which is also not really want
you want.)

BTW - I would really like to see this in the 2.4 kernels too - our
clusters really could use it (and do use it since I build the kernel
we use).

-- 
Michael Sinz -- msinz@wgate.com -- http://www.sinz.org
A master's secrets are only as good as
        the master's ability to explain them to others.
