Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132993AbRDKUuo>; Wed, 11 Apr 2001 16:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132994AbRDKUuf>; Wed, 11 Apr 2001 16:50:35 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:31130 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132993AbRDKUuX>;
	Wed, 11 Apr 2001 16:50:23 -0400
Message-ID: <3AD4C38D.2C970A60@mandrakesoft.com>
Date: Wed, 11 Apr 2001 16:50:21 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Walter <srwalter@yahoo.com>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: [BUG] serial ioctl not returning with 2.4.3
In-Reply-To: <20010411142538.A27290@hapablap.dyn.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Walter wrote:
> 
> When I try to start "agetty" on my serial line, agetty hangs in an
> ioctl; according to strace, this ioctl is "SNDCTL_TMR_STOP".  This
> doesn't sound right, but that ioctl is defined as _IO('T', 3) if that
> makes any more sense.
> 
> The reason that this must be a kernel bug is because agetty works
> flawlessly in an identically-configured 2.4.2 kernel, and even a 2.4.3
> kernel with the debugging tokens defined.  I'd be glad to give any help
> that I could.

I am not sure this is a serial driver bug:

[jgarzik@rum linux_2_4]$ find . -name '*.[ch]'|xargs grep -wn
SNDCTL_TMR_STOP
./arch/sparc64/kernel/ioctl32.c:3503:COMPATIBLE_IOCTL(SNDCTL_TMR_STOP)
./drivers/sound/mpu401.c:1522:          case SNDCTL_TMR_STOP:
./drivers/sound/sequencer.c:1352:               case SNDCTL_TMR_STOP:
./drivers/sound/sound_timer.c:195:              case SNDCTL_TMR_STOP:
./drivers/sound/sys_timer.c:206:        case SNDCTL_TMR_STOP:
./include/linux/soundcard.h:165:#define SNDCTL_TMR_STOP                
_SIO  ('T', 3)

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
