Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269038AbTCAV3S>; Sat, 1 Mar 2003 16:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbTCAV3R>; Sat, 1 Mar 2003 16:29:17 -0500
Received: from yossman.net ([209.162.234.20]:15632 "EHLO yossman.net")
	by vger.kernel.org with ESMTP id <S269038AbTCAV3Q>;
	Sat, 1 Mar 2003 16:29:16 -0500
Message-ID: <3E61288E.6000001@yossman.net>
Date: Sat, 01 Mar 2003 16:39:26 -0500
From: Brian Davids <dlister@yossman.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <freesoftwaredeveloper@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi -O3 runtime problem
References: <200303012126.34752.freesoftwaredeveloper@web.de>
In-Reply-To: <200303012126.34752.freesoftwaredeveloper@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> Hi.
> 
> I have recently played a little bit with some optimiziation-flags on 
> linux-2.4.20, linux-2.4.21-pre4 and linux-2.4.21-pre5 (I'm currently running 
> pre5).
> Finally I could bring it to compile, but when I tried to mount a CD-ROM on the 
> shiny new system with the optimized kernel, mount simply said:
> mount: /dev/scd0 is not a valid block device
> 
> Then I tried to mount it via /dev/hdb (which is physically the same device, 
> but without ide-scsi) and it worked fine.
> 
> Is it a known problem, that ide-scsi fails if the kernel is compiled with -O3 
> ?
> If you have any questions about my hardware and/or configuration, just ask. :)

It's not an -O3 problem, it's one with your .config... ;)

> CONFIG_BLK_DEV_IDECD=y

When you have that set, ide-scsi never gets a chance to see the CD-ROM 
drive as the native IDE driver grabs it first.  Everything else relevant 
in the IDE and SCSI sections seem fine to my untrained eye... ;)  So 
either change that to N, or at boot time you can pass "hdb=scsi" as one 
of the parameters and avoid recompiling.


Brian Davids

