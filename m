Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbRFTIjV>; Wed, 20 Jun 2001 04:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbRFTIjL>; Wed, 20 Jun 2001 04:39:11 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:56838 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264856AbRFTIjG>; Wed, 20 Jun 2001 04:39:06 -0400
Message-ID: <3B3060C0.B2D368C@idb.hist.no>
Date: Wed, 20 Jun 2001 10:37:20 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: richard offer <offer@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Why can't I ptrace init (pid == 1) ?
In-Reply-To: <102490000.992966603@changeling.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

richard offer wrote:
> 
> In arch/i386/kernel/ptrace.c there is the following code ...
> 
>         ret = -EPERM;
>         if (pid == 1)           /* you may not mess with init */
>                 goto out_tsk;
> 
> What is the rationale for this ? Is this a real security decision or
> an implementation detail (bad things will happen).

I don't know why they did it, but ptracing init is definitely a added
security risk.  If an intruder can't take over init, then a smart
init can fight back.  Of course most inits aren't that smart, but
at least they can log problems and such.  The intruder can't prevent
that because init cannot be killed except by booting (which is
noticeable),
and it cannot be taken over with ptrace.  ptrace could otherwise
be used to make init exec some other init that doesn't do the
logging.  

If you want to debug the init software, consider running it
as a normal processs (not PID 1).  If that is impossible , e.g.
you need a real-life setup, do remove the above test temporarily 
and make an init-debug kernel for this purpose.

Helge Hafting
