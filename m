Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbSKLXg5>; Tue, 12 Nov 2002 18:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbSKLXg4>; Tue, 12 Nov 2002 18:36:56 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:40403 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267043AbSKLXgz>;
	Tue, 12 Nov 2002 18:36:55 -0500
Message-Id: <200211122341.gACNfhD17153@eng4.beaverton.ibm.com>
To: Per Andreas Buer <perbu@linpro.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: iostats broken for devices with major number > DK_MAX_DISK (16) 
In-reply-to: Your message of "12 Nov 2002 21:35:38 +0100."
             <PERBUMSGID-ul64ramh6g5.fsf@nfsd.linpro.no> 
Date: Tue, 12 Nov 2002 15:41:43 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    sorry for the intrusion. I noticed iostats didn't display statistics for
    devices on Mylex RAID constrollers. Det statistics are completely
    missing in /proc/stat. The reason seems to be an assumption that disks
    have major numbers which are below 16
    (http://lxr.linux.no/source/include/linux/kernel_stat.h#L15) which is
    used by http://lxr.linux.no/source/fs/proc/proc_misc.c#L344.
    
    Devices on Mylex-controllers have major number 48. Would it break
    anything if DK_MAX_MAJOR if set higher (e.g. 64)?
    
    AFAIK this goes for both 2.4 and the 2.5 series.

Which kernel did you observe it on?

In 2.4, yes, you're right. Without patches, there's a limit.  Patches do
exist that remove those limits though.

In >= 2.5.47, no. They've been completely removed from /proc/stat and
appear in sysfs.  And there are no major device number limits.

For various other flavors of 2.5 and assorted patches, the answer is
"well maybe, kind of"  depending on where you got your 2.5 from and
what patches you may have applied on top of that.

Rick
