Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133011AbRDKW7J>; Wed, 11 Apr 2001 18:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133015AbRDKW4f>; Wed, 11 Apr 2001 18:56:35 -0400
Received: from [209.250.53.118] ([209.250.53.118]:59652 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S133014AbRDKWz7>; Wed, 11 Apr 2001 18:55:59 -0400
Date: Wed, 11 Apr 2001 17:36:42 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] serial ioctl not returning with 2.4.3
Message-ID: <20010411173642.A29791@hapablap.dyn.dhs.org>
In-Reply-To: <20010411142538.A27290@hapablap.dyn.dhs.org> <3AD4C38D.2C970A60@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AD4C38D.2C970A60@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Apr 11, 2001 at 04:50:21PM -0400
X-Uptime: 5:33pm  up 18:42,  1 user,  load average: 1.03, 1.21, 1.35
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 04:50:21PM -0400, Jeff Garzik wrote:
> Steven Walter wrote:
> > 
> > When I try to start "agetty" on my serial line, agetty hangs in an
> > ioctl; according to strace, this ioctl is "SNDCTL_TMR_STOP".  This
> > doesn't sound right, but that ioctl is defined as _IO('T', 3) if that
> > makes any more sense.
> > 
> > The reason that this must be a kernel bug is because agetty works
> > flawlessly in an identically-configured 2.4.2 kernel, and even a 2.4.3
> > kernel with the debugging tokens defined.  I'd be glad to give any help
> > that I could.
> 
> I am not sure this is a serial driver bug:
> 
> [jgarzik@rum linux_2_4]$ find . -name '*.[ch]'|xargs grep -wn
> SNDCTL_TMR_STOP
> ./arch/sparc64/kernel/ioctl32.c:3503:COMPATIBLE_IOCTL(SNDCTL_TMR_STOP)
> ./drivers/sound/mpu401.c:1522:          case SNDCTL_TMR_STOP:
> ./drivers/sound/sequencer.c:1352:               case SNDCTL_TMR_STOP:
> ./drivers/sound/sound_timer.c:195:              case SNDCTL_TMR_STOP:
> ./drivers/sound/sys_timer.c:206:        case SNDCTL_TMR_STOP:
> ./include/linux/soundcard.h:165:#define SNDCTL_TMR_STOP                
> _SIO  ('T', 3)

It would appear that way, if not for something I neglected to mention in
my first message--the ioctl is on the fd for the opened serial port.
This succeeds in other version of the kernel (as described in my
original posting) and so must somehow be valid for the serial driver.

Any more thoughts?  This would seem to be a definite bug in the serial
code.

-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
