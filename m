Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313205AbSDJPDd>; Wed, 10 Apr 2002 11:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSDJPCe>; Wed, 10 Apr 2002 11:02:34 -0400
Received: from [216.196.223.237] ([216.196.223.237]:55948 "HELO sin.sloth.org")
	by vger.kernel.org with SMTP id <S313201AbSDJPBI>;
	Wed, 10 Apr 2002 11:01:08 -0400
Date: Wed, 10 Apr 2002 11:01:07 -0400
From: Geoffrey Gallaway <geoffeg@sin.sloth.org>
To: Sean Hunter <sean@dev.sportingbet.com>, linux-kernel@vger.kernel.org
Subject: Re: Update - Ramdisks and tmpfs problems
Message-ID: <20020410110107.A2299@sin.sloth.org>
In-Reply-To: <20020409144639.A14678@sin.sloth.org> <20020410102343.A31552@sin.sloth.org> <20020410155242.H4493@dev.sportingbet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What kernel version are you using on those smp+multi tmpfs boxes? What
hardware?

Geoffeg

This one time, at band camp, Sean Hunter wrote:
> Just a data point:  I have been using multiple tmpfs bind mounts for some time
> on smp without this problem.
> 
> none on /dev/shm type tmpfs (rw,nosuid,nodev,mode=1777,size=256M)
> /dev/shm on /tmp type none (rw,bind)
> /dev/shm on /usr/tmp type none (rw,bind)
> 
> Never had a reboot fail for this reason.
> 
> Sean
> 
> 
> On Wed, Apr 10, 2002 at 10:23:43AM -0400, Geoffrey Gallaway wrote:
> > I finally found the problem, which appears to be a combination of things:
> > 
> > Multiple tmpfs mounts and SMP.
> > 
> > I am using a Dual Intel PIII 1Ghz box. When I use a SMP kernel AND do
> > multiple tmpfs mounts (mount --bind /dev/shm/etc /etc; mount --bind
> > /dev/shm/var /var) the machine goes into a reset loop. HOWEVER, when I use a
> > non-SMP kernel and still do multiple tmpfs mounts OR when I use a SMP kernel
> > and do only one tmpfs mount, the machine boots fine. Every once in a while
> > (1 out of 20 times?) the machine would boot fine with a SMP kernel and
> > multiple tmpfs mounts. Is this a timing issue?
> > 
> > If I can help to nail down this (apparent) bug more, please let me know.
> > 
> > Thanks,
> > Geoffeg
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
