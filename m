Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267736AbTBYG4J>; Tue, 25 Feb 2003 01:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267758AbTBYG4J>; Tue, 25 Feb 2003 01:56:09 -0500
Received: from imo-m06.mx.aol.com ([64.12.136.161]:3040 "EHLO
	imo-m06.mx.aol.com") by vger.kernel.org with ESMTP
	id <S267736AbTBYG4I>; Tue, 25 Feb 2003 01:56:08 -0500
Date: Tue, 25 Feb 2003 02:06:09 -0500
From: SkamoElf@netscape.net
To: toptan@EUnet.yu (Toplica Tanaskovi?)
Cc: linux-kernel@vger.kernel.org
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4
MIME-Version: 1.0
Message-ID: <6BCBECD4.25482B65.00825DFE@netscape.net>
X-Mailer: Atlas Mailer 2.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toplica Tanaskovi? <toptan@EUnet.yu> wrote:

>Dana nedelja 23. februar 2003. 22:51 napisali ste:
>> >     Thank God, it's not agpgart's fault, it is the fact that Dave Jones
>> > mentioned earlier, I doubdt that any (ATI, nVidia..) drivers support
>> > AGP8x transfer rate.
>    I forgot to add through agpgart.
>>

I made an extensive testing of the NVidia driver. I did not know the Internal NVidia AGP would fail if I had AGPGART loaded, so I performed the testing again.

I set NvAGP to 1 and did not load agpgart, then tried to start X. Got the same garbage on screen. After rebooting and checking the log, to my surprise it was not full of garbage like other times! The last line was the one where the display was being set to 1280x1024, and the one above it was "AGP8X Initialized successfully" or something like that. I now set the NvAGP to 2 so it would try to use the AGPGART, and still got garbage on the screen, as usual. I rebooted and checked the log, and it had no garbage this time either! Checking the end of the log, I noticed the line just above the last one said 4X, not 8X...

I hacked the nvidia module's source so no other mode but 8X could be detected (it can be verified on /proc/drivers/nvidia/agp/host_controller). Alright, now the kernel module reported the card and AGP Bus transfer rate as 8X only (It normally reported 4X and 8X). I started X, and still garbage. Another reboot and check at the logs... still 4X.

My conclussion: I agree with you, my friend. The NVidia drivers do not seem to support AGP8X through AGPGART.



__________________________________________________________________
The NEW Netscape 7.0 browser is now available. Upgrade now! http://channels.netscape.com/ns/browsers/download.jsp 

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/
