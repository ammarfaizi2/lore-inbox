Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283295AbRLEHYd>; Wed, 5 Dec 2001 02:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283311AbRLEHYY>; Wed, 5 Dec 2001 02:24:24 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:56705 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S283295AbRLEHYH>; Wed, 5 Dec 2001 02:24:07 -0500
Message-ID: <3C0DCB93.20304@optonline.net>
Date: Wed, 05 Dec 2001 02:24:03 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Mikocevic <mozgy@hinet.hr>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA588.2080000@optonline.net> <3C0DAC2C.8060506@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> Yes and no.  We aren't chasing our tail, but that's because the 
> application is suppossed to call the GETOPTR ioctl in order to trigger 
> a pointer update.  In short, the GETOPTR ioctl is our cue that the 
> application knows about the empty space and will fill it.  We can 
> always make the thing chase it's tail unconditionally, but then you 
> risk playing total garbage when the application falls behind :-/

This is what happens under most of the drivers i've played quake with 
(under DOS too, I think). OSS and OSS/Free, and most of the other PCI 
drivers I've looked at, I believe they don't actually program the DMA 
engine during GETOPTR calls. Actually one could argue that in the case 
of quake it's better to let it chase its tail indefinitely (that's what 
they seem to have assumed when they wrote the game anyway according to 
comments in the source code) because that allows ambient sounds to 
continue uninterrupted during some slowdown, eg possible network 
congestion. (The side effect is that sometimes you end up with endlessly 
repeating weapon sound effects if you fire during congestion but of 
course that coincidence happens less often than congestion itself)

> I see no reason to drain the dac on close for mmaped stuff.  The 
> application can check GETOPTR to see if the last stuff has played if 
> it really cares that much.  I'm going to skip the drain_dac() calls on 
> mmap from now on.  That will solve that problem (and it's also the 
> right thing to do if we are chasing our tail and have set the software 
> pointer to God only knows where as far as the final sounds are 
> concerned). 

yep...

