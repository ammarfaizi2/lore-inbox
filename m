Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVHKMha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVHKMha (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 08:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVHKMha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 08:37:30 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:421 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932374AbVHKMh3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 08:37:29 -0400
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
            <20050811064217.GB21395@titan.lahn.de>
In-Reply-To: <20050811064217.GB21395@titan.lahn.de>
From: hunold@linuxtv.org
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-dvb-maintainer@linuxtv.org
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
Date: Thu, 11 Aug 2005 14:37:20 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <E1E3CJE-0001NJ-PH@allen.werkleitz.de>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Scanned: No (on allen.werkleitz.de); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Philipp, 

> I got the following OOPS from running "alevtd -F -d -v /dev/vbi0" with
> my Siemens-DVB-C on a Dual-i686-600. I'm able to reproduce this even
> running a 2.6.12-rc6 without the nvidia module tainting the kernel.

So you're using the analog tuner of the card to watch analog cable tv and 
want to decode teletext from the vbi, right? 

Can you tell me the last kernel version that worked for you? 

>
> ...
> kernel BUG at drivers/media/common/saa7146_video.c:741!

739         fmt = format_by_fourcc(dev,fh->video_fmt.pixelformat);
740         /* we need to have a valid format set here */
741         BUG_ON(NULL == fmt); 

This sanity check is failing. Apparently the software managed
to select a pixelformat that cannot be translated to a "saa7146 format". 

Puh, I wrote this long ago. ;-) IIRC this should not be possible (ie. the 
driver should reject the unknown pixelformat in the configuring stage). 

Did you update the alevt package? Perhaps it's now doing this differently 
and it would fail with older kernels as well, which have worked before. 

We will probably have to debug this on a very low level. 

Regards
Michael. 

