Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132710AbRDXCzb>; Mon, 23 Apr 2001 22:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132718AbRDXCzM>; Mon, 23 Apr 2001 22:55:12 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:61028 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132710AbRDXCy5>; Mon, 23 Apr 2001 22:54:57 -0400
Message-ID: <3AE4EAEB.254B2A48@redhat.com>
Date: Mon, 23 Apr 2001 22:54:35 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eugene Kuznetsov <divx@euro.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with i810_audio driver
In-Reply-To: <921508308.20010421012021@euro.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugene Kuznetsov wrote:
> 
> Hello,
> 
>       I am a happy owner of Intel D815EEA2 mother board. This board
> comes with integrated AC-97 audio. When I try to load i810_audio
> driver for it, driver identifies the device as
> "Intel 810 + AC97 Audio, version 0.02, 19:43:23 Apr 20 2001
> i810: Intel ICH2 found at IO 0xef00 and 0xe800, IRQ 6
> ac97_codec: AC97 Audio codec, id: 0x4144:0x5360 (Analog Devices
> AD1885)"
> and later brings the system into one of three possible conditions.
> A) a bit later it says:
>    i810_audio: 11168 bytes in 50 milliseconds
>    i810_audio: setting clocking to 41260 to compensate
> In this case everything is fine ( 16-bit sound is played correctly, I
> don't need much more ... ).

Write that number down.  You can add it to your /etc/modules.conf file if you
like.  If the new driver sees that the clocking variable has been set to
anything other than 48000 it doesn't run the clocking autodetect routine.

> B) It says:
>    i810_audio: 65528 bytes in 50 milliseconds
>    i810_audio: setting clocking to 7032 to compensate
> In this case the sound does not work at all - sound card does not
> produce anything but silence. With versions of kernel up to 2.4.3 I
> also received a lot of "DMA buffer overrun on send" messages in dmesg
> when playing anything.
> C) Last condition is relatively rare. It says something similar to
> case A, but number of bytes is multiple of 11168 and clocking is lower
> ( e.g. 13753 = 41260/3 ). Sound card works, but output quality is
> quite low.
> Which of cases A)..C) takes place, seems to be random ( I haven't
> noticed any pattern ). However, attempts to do rmmod/insmod
> do not have any effect. I have to at least reboot the system a few
> times to bring the sound to working state.

Both B and C are cases of the whole chip acting flat busted.  I would suspect
that possibly Win2k drivers set this thing up some way that we don't recover
from.  Is there any pattern like maybe "I listen to X in Win2k then reboot to
linux and sound is screwed" or something like that?  Also, when it does
happen, does shutting down and then actually powering the machine off
(possibly by going so far as to unplug the machine for 5 seconds or so to
overcome any low power state savings on modern motherboards) make it reliably
come back instead of having to reboot multiple times?  Does this ever happen
if you just unload/reload the module without rebooting inbetween (aka, does
the linux driver module sometimes trigger the problem)?  Finally, when B or C
does happen, can you get the module to work by loading the module with the
clocking= option set to the correct clocking value from A?

> I tried driver from kernels 2.4.1, 2.4.3 and 2.4.4-pre4. All of them
> behave more or less in the same way.
> In Windows 2000 this motherboard/audio device works without any problems.
> I can provide any additional information if it helps to solve the bug.
> Please cc: me, because I am not subscribed to the list.
> 
> --
> Best regards,
>  Eugene
> mailto:divx@euro.ru
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
