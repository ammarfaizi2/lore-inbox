Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVHBMqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVHBMqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVHBMmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:42:02 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:40527 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261504AbVHBMlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:41:39 -0400
Message-ID: <42EF69F7.2020108@m1k.net>
Date: Tue, 02 Aug 2005 08:41:27 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horms <horms@verge.net.au>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Chris Wright <chrisw@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] v4l cx88 hue offset fix
References: <20050802071959.GB22793@verge.net.au>
In-Reply-To: <20050802071959.GB22793@verge.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horms wrote:

>Hi Marcelo, 
>
>Another fix from 2.6.12.3 that seems approprite for 2.4.
>Should apply cleanly to your tree.
>  
>
Horms-

Thank you for the effort of trying to get this into 2.4, but I don't 
think there is any support at all for cx88 cards in kernel 2.4 v4l.  I 
wasn't involved in v4l back then, but I took a look at Marcelo's 
linux-2.4.git/tree , and /drivers/media/video/cx88* just doesn't exist.  
There is no cx88-video.c file present for this patch to be applied to!

This one-line fix does make a very big difference, but unfortunately, it 
looks like 2.4 doesn't have the cx88 driver for the fixing...

Good to see that debian has backported it to their 2.6.8 kernel, 
though.  That really makes me smile.  :-)

>Signed-off-by: Horms <horms@verge.net.au>
>
>From: Michael Krufky <mkrufky@m1k.net>
>Date: Thu, 30 Jun 2005 20:06:41 +0000 (-0400)
>Subject: [PATCH] v4l cx88 hue offset fix
>X-Git-Tag: v2.6.12.3
>X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/gregkh/linux-2.6.12.y.git;a=commitdiff;h=aebaaf4060dd0db163694da8e4ab7ba86add57b9
>
>  [PATCH] v4l cx88 hue offset fix
>  
>  Changed hue offset to 128 to correct behavior in cx88 cards.  Previously,
>  setting 0% or 100% hue was required to avoid blue/green people on screen.
>  Now, 50% Hue means no offset, just like bt878 stuff.
>  
>  Signed-off-by: Michael Krufky <mkrufky@m1k.net>
>  Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
>  Signed-off-by: Chris Wright <chrisw@osdl.org>
>  Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>---
>
>Backported to Debian's kernel-source-2.6.8 by dann frazier <dannf@debian.org>
>
>--- a/drivers/media/video/cx88/cx88-video.c
>+++ b/drivers/media/video/cx88/cx88-video.c
>@@ -261,7 +261,7 @@ static struct cx88_ctrl cx8800_ctls[] = 
> 			.default_value = 0,
> 			.type          = V4L2_CTRL_TYPE_INTEGER,
> 		},
>-		.off                   = 0,
>+		.off                   = 128,
> 		.reg                   = MO_HUE,
> 		.mask                  = 0x00ff,
> 		.shift                 = 0,
>
-- 
Michael Krufky

