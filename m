Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317926AbSGWDyB>; Mon, 22 Jul 2002 23:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317928AbSGWDyB>; Mon, 22 Jul 2002 23:54:01 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:14471 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S317926AbSGWDyA>;
	Mon, 22 Jul 2002 23:54:00 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200207230356.HAA15253@sex.inr.ac.ru>
Subject: Re: read/recv sometimes returns EAGAIN instead of EINTR on SMP
To: davem@redhat.COM (David S. Miller)
Date: Tue, 23 Jul 2002 07:56:39 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020722.195749.34129476.davem@redhat.com> from "David S. Miller" at Jul 23, 2 07:15:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>    If one process tries to read non-blocking from a tcp socket (domain sockets work
>    fine), and another process sends the reading process signals, then sometimes
>    select() returns with the indication that the socket is readable,
>    but the subsequent read returns EAGAIN - instead of EINTR which
>    would have been the correct return code. This only happenes on SMP
>    machines.
> 
> I think EAGAIN is the correct return value.  This behavior has been
> there since the stone ages of TCP and I remember Alan specifically
> auditing all of this stuff long ago wrt. POSIX compliance.

However, I suspect this is bug. At least this behavior is absolutely
unjustified and unintelligible. If socket has something to read,
we have no reasons to interrupt.

                /* We need to check signals first, to get correct SIGURG
                 * handling. FIXME: Need to check this doesnt impact 1003.1g
                 * and move it down to the bottom of the loop
                 */

First, the first sentence contradicts to the second. The second is right,
the first sounds strange.

Second, I never understood what is the problem with SIGURG.
That's why it lives untouched.

Alexey
