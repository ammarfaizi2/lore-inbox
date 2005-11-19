Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbVKSLMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVKSLMb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 06:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVKSLMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 06:12:30 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:24425 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1750850AbVKSLMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 06:12:30 -0500
Message-ID: <437F082A.6040301@samwel.tk>
Date: Sat, 19 Nov 2005 12:10:34 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Pavel Machek <pavel@ucw.cz>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
References: <20051116181612.GA9231@knautsch.gondor.com> <20051117223340.GD14597@elf.ucw.cz> <437E215E.30500@tmr.com> <20051118232019.GA2359@spitz.ucw.cz> <437EE4B3.2090408@samwel.tk> <20051119092622.GA13622@midnight.suse.cz>
In-Reply-To: <20051119092622.GA13622@midnight.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> The issue might be that these people are using
> 
> 	hdparm -S xxx
> 	
> 	or
> 
> 	hdparm -y / -Y
> 
> while a much better way to do
> 
> 	hdparm -B 63
> 
> The -S option should in theory be safe, but I remember some drives did
> behave unpredictably if this was used.

Well, some drives have a specific lower limit on the -S values that are 
supported. That's the only compatibility problem I've ever encountered 
with -S. (And you can find out if a drive has a lower limit by checking 
hdparm -i.)

> -y/-Y is much tougher and some
> drives will not work reliably unless first woken up manually before
> issuing a read/write request.

In fact, -Y is problematic but -y usually isn't. -Y puts the drive to 
sleep and requires that Linux reset the complete IDE controller before 
using it again, while -y simply puts the drive in standby mode, leaving 
it up to the drive to decide when it spins up. I've never heard of any 
problems with -y.

> On the other hand, -B is pretty safe on drives that support it, and all
> IBM notebook drives do.

Not true, unfortunately. In fact, I had to change the default config of 
laptop-mode-tools a while ago so that it wouldn't use -B, as it seemed 
to be one of the *causes* of hangup/corruption problems. This was also 
an issue on Thinkpads, and I think it was also noted in the ubuntu bug I 
linked to earlier.

An additional problem is that the values for -B are not really 
standardized, while the values for -S are.

--Bart
