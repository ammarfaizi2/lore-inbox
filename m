Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSH0SmL>; Tue, 27 Aug 2002 14:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSH0SmL>; Tue, 27 Aug 2002 14:42:11 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:4086 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S317024AbSH0SmK>; Tue, 27 Aug 2002 14:42:10 -0400
Date: Tue, 27 Aug 2002 14:46:29 -0400
From: Doug Ledford <dledford@redhat.com>
To: Andris Pavenis <pavenis@latnet.lv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.20-pre4-ac1: i810_audio broken
Message-ID: <20020827144629.E28828@redhat.com>
Mail-Followup-To: Andris Pavenis <pavenis@latnet.lv>,
	linux-kernel@vger.kernel.org
References: <200208271253.12192.pavenis@latnet.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208271253.12192.pavenis@latnet.lv>; from pavenis@latnet.lv on Tue, Aug 27, 2002 at 12:53:12PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 12:53:12PM +0300, Andris Pavenis wrote:
> Found that i810_audio has been broken in kernel 2.4.20-pre4-ac1. It was Ok with 
> 2.4.20-pre1-ac1 I used before.
> 
> With 2.4.20-pre4-ac1 I'm only getting garbled sound and kernel messages (see below).
> Didn't have time yet to study mire detailed which change breaks driver.

The important part of my change is just two lines.  There is the line that 
prints out the message "Defaulting to base 2 channel mode." and the line 
after it where we mask off a couple bits in the global control register.  
Comment those two lines out and let me know if it makes a difference on 
your machine.

> In Alan's changelog I see:
> 
> 2.4.20-pre2-ac5: Further i810_audio updates for 845 (Juergen Sawinski) 
> 2.4.20-pre1-ac3: Tidy up error paths on i810_audio init (Alan) 
> 2.4.20-pre1-ac2: First set of i810 audio updates (Doug Ledford) 
> 
> Andris
> 
> ------ at startup -----------------
> Intel 810 + AC97 Audio, version 0.22, 11:18:00 Aug 26 2002
> PCI: Found IRQ 5 for device 00:1f.5
> PCI: Sharing IRQ 5 with 00:1f.3
> PCI: Setting latency timer of device 00:1f.5 to 64
> i810: Intel ICH 82801AA found at IO 0xe100 and 0xe000, MEM 0x0000 and 0x0000, IRQ 5
> i810_audio: Audio Controller supports 2 channels.
> i810_audio: Defaulting to base 2 channel mode.
> i810_audio: resetting hw channel 0
> ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
> i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), to
> ------ error messages  ------------
> i810_audio: DMA overrun on write
> i810_audio: CIV 0, LVI 27, hwptr 253a, count -13626
> i810_audio: DMA overrun on write
> i810_audio: CIV 0, LVI 27, hwptr 2662, count -296
> i810_audio: DMA overrun on write
> i810_audio: CIV 0, LVI 27, hwptr 2662, count -296
> i810_audio: DMA overrun on write
> i810_audio: CIV 0, LVI 27, hwptr 266a, count -8
> i810_audio: DMA overrun on write
> i810_audio: CIV 1, LVI 31, hwptr 2924, count -10526
> i810_audio: DMA overrun on write
> i810_audio: CIV 1, LVI 31, hwptr 2924, count -10526
> i810_audio: DMA overrun on write
> i810_audio: CIV 0, LVI 3, hwptr 253a, count -5434
> i810_audio: DMA overrun on write
> i810_audio: CIV 0, LVI 3, hwptr 2562, count -40
> ......
> 
> ---------  error message from artsd (KDE-3.1 beta1) -------
> Sound server fatal error:
> AudioSubSystem::handleIO: write failed
> len = 3228, can_write = 4096, errno = 17 (File exists)
> This might be a sound hardware/driver specific problem (see aRts FAQ)
> 
> -------------------------------------------------------------------- 
> Kernel was compiled with gcc-3.1 (like earlier kernels where i810_audio worked
> Ok)

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
