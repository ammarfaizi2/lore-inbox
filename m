Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283012AbSAAS4P>; Tue, 1 Jan 2002 13:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283016AbSAASz4>; Tue, 1 Jan 2002 13:55:56 -0500
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:38598 "EHLO
	mel-rto1.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S283012AbSAASzp>; Tue, 1 Jan 2002 13:55:45 -0500
Message-ID: <3C3205AF.1080409@wanadoo.fr>
Date: Tue, 01 Jan 2002 19:53:35 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 with es1370 pci
In-Reply-To: <20011231065544.A28966@animx.eu.org> <3C3065CE.1070608@wanadoo.fr> <20011231122440.B29342@animx.eu.org> <3C316C47.4080406@wanadoo.fr> <20020101104611.A30843@animx.eu.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:

> Nope, they don't work well IMO and since this card has 2 DSPs


I assume one dsp is for es1370 and one is for the sb-16

> I know,  I only pasted the what was for the sound card, it is working
> properly.  mpg123 -a /dev/dsp2 works w/o any problem what so ever.


Yes, you can use one sound card or the other. You may hear a difference.

> here's mpg123 -4:

<snip>
> open("/sound/mp3/Aerosmith/Ain\'t_That_A_Bitch.mp3", O_RDONLY) = 3
<snip>
> open("/dev/dsp", O_WRONLY)              = 4
> ioctl(4, SNDCTL_DSP_GETBLKSIZE, 0x806ae1c) = 0
> ioctl(4, SNDCTL_DSP_RESET, 0)           = 0
> ioctl(4, SOUND_PCM_READ_BITS, 0xbffff8a0) = 0
> ioctl(4, SNDCTL_DSP_STEREO, 0xbffff89c) = 0
> ioctl(4, SOUND_PCM_READ_RATE, 0xbffff898) = 0
> write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 16384) = 16384
> write(4, "\374\377\3\0\373\377\4\0\367\377\1\0\373\377\7\0\377\377"..., 16384) = 16384
> write(4, "\344\377\333\377\5\0\316\377\362\377\234\377\f\0\212\377"..., 16384) = 16384
> write(4, "P\0\202\0\367\377\263\0\353\377\274\0\274\377\353\0\235"..., 16384) = 16384
> write(4, "\23\377S\0I\377U\0\200\377\215\0Z\377\222\377\330\377\16"..., 16384) = 16384
> write(4, "@\377\376\375\344\376\355\377\263\3769\0%\377Y\376\255"..., 16384) = 16384
> write(4, "\0\0\274\1:\377\365\1\17\0\301\1\0\0\332\0\360\377%\377"..., 16384) = 16384
> write(4, "\r\375_\372{\377\356\373W\374\230\370\'\1\220\0\26\371"..., 16384) = 16384
> write(4, "k\5j\5\337\1E\370<\10\346\5{\377;\3776\4\374\4F\376\24"..., 16384
>  <unfinished ...>


The same as the previous one: write to dsp but never read even the 
smallest sample of the sound file possibly by lack of interrupt.


>            CPU0       CPU1       
>   0:   68416693   68502478    IO-APIC-edge  timer
>   1:     400959     396781    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   3:  184224466  184748725    IO-APIC-edge  serial
>   4:     803073     799856    IO-APIC-edge  serial
>   5:     666537     667971   IO-APIC-level  aic7xxx
>   7:        126        106    IO-APIC-edge  soundblaster
>  10:   10271518   10263624   IO-APIC-level  eth0
>  11:     236351     237359   IO-APIC-level  aic7xxx
>  15:    4438445    4431067   IO-APIC-level  es1370
> NMI:          0          0 
> LOC:  136921268  136921264 
> ERR:          0
> MIS:          2
> 
> After attempting to play an mp3
> 
>            CPU0       CPU1       
>   0:   68420347   68505506    IO-APIC-edge  timer
>   1:     401392     397000    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   3:  184242407  184763513    IO-APIC-edge  serial
>   4:     803633     800393    IO-APIC-edge  serial
>   5:     666566     668012   IO-APIC-level  aic7xxx
>   7:        126        106    IO-APIC-edge  soundblaster
>  10:   10271726   10263824   IO-APIC-level  eth0
>  11:     236351     237359   IO-APIC-level  aic7xxx
>  15:    4438445    4431067   IO-APIC-level  es1370
> NMI:          0          0 
> LOC:  136927950  136927946 
> ERR:          0
> MIS:          2

My es1370 is happy with IRQ 9 which is shared with usb-uhci. IRQ 15 is 
for ide1 here.

-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

