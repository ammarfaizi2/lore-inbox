Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317110AbSGHU2R>; Mon, 8 Jul 2002 16:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSGHU2Q>; Mon, 8 Jul 2002 16:28:16 -0400
Received: from ppp1237-cwdsl.fr.cw.net ([62.210.116.214]:46607 "EHLO
	calvin.paulbristow.lan") by vger.kernel.org with ESMTP
	id <S317110AbSGHU2O>; Mon, 8 Jul 2002 16:28:14 -0400
Message-ID: <3D29F70D.6020001@paulbristow.net>
Date: Mon, 08 Jul 2002 22:33:17 +0200
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.22] simple ide-tape.c and ide-floppy.c cleanup
References: <20020703155113.GA26299@zombie.inka.de> <3D2913C9.3030409@evision-ventures.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK.  I kept quiet while the IDE re-write went on so that when it was 
over I could fix up ide-floppy and start adding some of the requested 
features that were only really possible with the taskfile capabilities. 
 But I have to jump in with the latest statements from Martin...  

Martin Dalecki wrote:

>U¿ytkownik Eduard Bloch napisa³:
>  
>
>>Why not another way round? Just make the ide-scsi driver be prefered,
>>and hack ide-scsi a bit to simulate the cdrom and adv.floppy devices
>>that are expected as /dev/hd* by some user's configuration?
>>    
>>
>
>This is the intention.
>
Since when?  I thought Jens was in the process of getting rid of the 
ide-scsi kludge with his moves to support cd/dvd writing directly in 
ide-cd?

>>to be honest - why keep ide-[cd,floppy,tape] when they can be almost
>>completely replaced with ide-scsi? I know about only few cdrom devices
>>that are broken (== not ATAPI compliant) but can be used with
>>workarounds in the current ide-cd driver. OTOH many users do already
>>need ide-scsi to access cd recorders and similar hardware, so they would
>>benefit much more from having ide-scsi as default than few users of
>>broken "atapi" drives.
>>    
>>
OK.  I would prefer though to take Linus's comment on board about 
unifying the removeable media  interfaces. Be they IDE, SCSI, Firewire, 
USB, whatever.  Let's try to make it something comprehensible for 
"normal humans", and don't say "let config scripts sort it out - I deal 
with many user help requests from broken configs.

Please don't forget that
  a) some of the broken ide devices will still need fixes even if 
handled via ide-scsi (and yes, devices on the market today are still 
broken today)
  b) some features still need IDE commands (not ATAPI) which I hoped we 
would have done via taskfile - I guess this is tricky via ide-scsi
  c) getting ide-scsi working for PCMCIA devices is an absolute f*****g 
nightmare - for this reason alone I would keep ide-floppy
  d) many of these devices (LS120/LS240/Zip 100/250 etc) can and need to 
boot.  I don't even know how to start doing this under ide-scsi in it's 
present form.

The current system may be ugly, but if we have to break it in the name 
of progress we have at least to make the new, improved version work as 
well (and hopefully better) than the old one.

>>Other operating systems did switch to constitent (scsi-based) way of
>>accessing all kinds of removable media drivers. Why does Linux have to
>>keep a kludge, written years ago without having a good concept?
>>
>>    
>>
If we can address all these issues I will be extremely happy to helping 
create a sensible removeable media subsystem.


-- 

Paul

Linux ide-floppy maintainer
Email:	paul@paulbristow.net
Web:	http://paulbristow.net
ICQ:	11965223



