Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271620AbTGQXMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 19:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271626AbTGQXMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 19:12:16 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:34837 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S271620AbTGQXMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 19:12:08 -0400
Message-ID: <3F1730C9.4020300@sbcglobal.net>
Date: Thu, 17 Jul 2003 18:27:05 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kurt Roeckx <Q@ping.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: Sb16 kernel parameters.
References: <20030717220915.GA5046@ping.be>
In-Reply-To: <20030717220915.GA5046@ping.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You'll need to use the kernel parameter 
(Documentation/kernel-parameters.txt) snd-sb16 .

Looking at the docs in the Documentation/sound/alsa directory:

  Module snd-sb16 and snd-sbawe
  -----------------------------

    Module for 16-bit SoundBlaster cards: SoundBlaster 16 (PnP),
                                          SoundBlaster AWE 32 (PnP),
                                          SoundBlaster AWE 64 PnP

    port        - port # for SB DSP 4.x chip (0x220,0x240,0x260)
    mpu_port    - port # for MPU-401 UART (0x300,0x330), -1 = disable
    awe_port    - base port # for EMU8000 synthesizer (0x620,0x640,0x660)
                   (snd-sbawe module only)
    irq         - IRQ # for SB DSP 4.x chip (5,7,9,10)
    dma8        - 8-bit DMA # for SB DSP 4.x chip (0,1,3)
    dma16       - 16-bit DMA # for SB DSP 4.x chip (5,6,7)
    mic_agc     - Mic Auto-Gain-Control - 0 = disable, 1 = enable (default)
    csp         - ASP/CSP chip support - 0 = disable (default), 1 = enable
    isapnp      - ISA PnP detection - 0 = disable, 1 = enable (default)
   
    Module supports up to 8 cards, autoprobe and ISA PnP.

    Note: To use Vibra16X cards in 16-bit half duplex mode, you must
          disable 16bit DMA with dma16 = -1 module parameter.
          Also, all Sound Blaster 16 type cards can operate in 16-bit
          half duplex mode through 8-bit DMA channel by disabling their
          16-bit DMA channel.

And at the end of the sb16.c file I found:

#ifndef MODULE

/* format is: snd-sb16=enable,index,id,isapnp,
                       port,mpu_port,fm_port,
                       irq,dma8,dma16,
                       mic_agc,csp,
                       [awe_port,seq_ports]

Which is probably what format you'll need to use but I don't know much 
about drivers...;-)
I don't know what "id" stands for either...

Good luck!


Kurt Roeckx wrote:

>I have an sound blaster 16, but I'm unable to get it working with
>2.6.
>
>During boot I get:
>Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun
>09 12:01:18 2003 UTC).
>ALSA device list:
>  #0: Sound Blaster 16 at 0x220, irq 5, dma 1&5
>
>Normally I'm using irq 7, and that has always worked for me, but
>for some reason it's selecting it.
>
>I'm still using my kernel parameter line from 2.4:
>sb=0x220,7,1,5
>
>And I tried some other things, but I'm unable to get it to work.
>
>
>How am I supposed to get the IRQ of the SB16 that's compiled in
>the kernel?
>
>
>Kurt
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

