Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267259AbTBNTfy>; Fri, 14 Feb 2003 14:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbTBNTfy>; Fri, 14 Feb 2003 14:35:54 -0500
Received: from almesberger.net ([63.105.73.239]:18190 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267259AbTBNTfx>; Fri, 14 Feb 2003 14:35:53 -0500
Date: Fri, 14 Feb 2003 16:44:36 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Corey Minyard <cminyard@mvista.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, suparna@in.ibm.com,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
Message-ID: <20030214164436.H2092@almesberger.net>
References: <3E4914CA.6070408@mvista.com> <m1of5ixgun.fsf@frodo.biederman.org> <3E4A578C.7000302@mvista.com> <m13cmty2kq.fsf@frodo.biederman.org> <3E4A70EA.4020504@mvista.com> <20030214001310.B2791@almesberger.net> <3E4CFB11.1080209@mvista.com> <20030214151001.F2092@almesberger.net> <3E4D3419.1070207@mvista.com> <Pine.LNX.4.50.0302141420220.3518-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0302141420220.3518-100000@montezuma.mastecende.com>; from zwane@holomorphy.com on Fri, Feb 14, 2003 at 02:26:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> I don't think suspending devices is safe at that stage since removing 
> devices and walking lists and freeing memory and disabling devices and... 
> kicks up quite a storm.

If you *really* don't want to stop devices, you can use the
"reserved, non-DMA memory" approach, kexec the kernel that
records the crash dump, and then do a system-wide reset, or
such.

But if you don't have that - possibly considerable - amount
of memory to spare, you don't have much of a choice than to
stop devices. Of course, crash dumps don't need a neat and
clean shutdown, so you can avoid all the kfrees, and such.

(So adding a special mode to the power management code may
be too much overhead. Besides, sometimes, you can just pull
a reset line, and don't have to do anything even remotely
related to power management.)

Also, for each device you're using when dumping, you should
have some means to bring it into a defined state already.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
