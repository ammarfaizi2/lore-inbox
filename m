Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132595AbRDDHnY>; Wed, 4 Apr 2001 03:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132759AbRDDHnE>; Wed, 4 Apr 2001 03:43:04 -0400
Received: from mail.inup.com ([194.250.46.226]:59913 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S132595AbRDDHnB>;
	Wed, 4 Apr 2001 03:43:01 -0400
Date: Wed, 4 Apr 2001 09:47:08 +0200
From: christophe barbe <christophe.barbe@lineo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: uninteruptable sleep (D state => load_avrg++)
Message-ID: <20010404094708.A4718@pc8.inup.com>
In-Reply-To: <003501c0bc5c$e26e81c0$5517fea9@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <003501c0bc5c$e26e81c0$5517fea9@local>; from manfred@colorfullife.com on mar, avr 03, 2001 at 18:40:53 +0200
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if I fork a bit the thread but I'm wondering why the load average is incremented for each D process.

I don't know if the kernel use this information (if yes please let me know).
But some programs like sendmail use this information to sleep when the load is too high (I believe from 12 for sendmail).
It makes sence but in the case of D process, the load average give a bad idea of the load because these process don't use CPU.

I use GFS to share a filesystem on several nodes. 
The file locking use real IO and so when you ask for a lock, if the lock is already owned, you fall in a D state.
This differs from what a local filesystem does but IMHO makes sense for a distributed filesytem like GFS.

Christophe

On mar, 03 avr 2001 18:40:53 Manfred Spraul wrote:
> > ps xl:
> >   F UID PID PPID PRI NI VSZ RSS WCHAN STAT TTY TIME COMMAND
> > 040 1000 1230 1 9 0 24320 4 down_w D ? 0:00
> >           /home/data/mozilla/obj/dist/bin/mozi
> >
> down_w
> 
> Perhaps down_write_failed()? 2.4.3 converted the mmap semaphore to a
> rw-sem.
> Did you compile sysrq into your kernel? Then enable it with
> 
> #echo 1 > /proc/sys/kernel/sysrq
> and press <Alt>+<SysRQ>+'t'
> 
> It prints the complete back trace, not just one function name
> 
> --
>     Manfred
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com
