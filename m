Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313175AbSDJOuf>; Wed, 10 Apr 2002 10:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313176AbSDJOue>; Wed, 10 Apr 2002 10:50:34 -0400
Received: from [195.157.147.30] ([195.157.147.30]:21259 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S313175AbSDJOud>; Wed, 10 Apr 2002 10:50:33 -0400
Date: Wed, 10 Apr 2002 15:52:42 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Geoffrey Gallaway <geoffeg@sin.sloth.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Update - Ramdisks and tmpfs problems
Message-ID: <20020410155242.H4493@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Geoffrey Gallaway <geoffeg@sin.sloth.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020409144639.A14678@sin.sloth.org> <20020410102343.A31552@sin.sloth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a data point:  I have been using multiple tmpfs bind mounts for some time
on smp without this problem.

none on /dev/shm type tmpfs (rw,nosuid,nodev,mode=1777,size=256M)
/dev/shm on /tmp type none (rw,bind)
/dev/shm on /usr/tmp type none (rw,bind)

Never had a reboot fail for this reason.

Sean


On Wed, Apr 10, 2002 at 10:23:43AM -0400, Geoffrey Gallaway wrote:
> I finally found the problem, which appears to be a combination of things:
> 
> Multiple tmpfs mounts and SMP.
> 
> I am using a Dual Intel PIII 1Ghz box. When I use a SMP kernel AND do
> multiple tmpfs mounts (mount --bind /dev/shm/etc /etc; mount --bind
> /dev/shm/var /var) the machine goes into a reset loop. HOWEVER, when I use a
> non-SMP kernel and still do multiple tmpfs mounts OR when I use a SMP kernel
> and do only one tmpfs mount, the machine boots fine. Every once in a while
> (1 out of 20 times?) the machine would boot fine with a SMP kernel and
> multiple tmpfs mounts. Is this a timing issue?
> 
> If I can help to nail down this (apparent) bug more, please let me know.
> 
> Thanks,
> Geoffeg
> 
