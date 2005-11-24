Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVKXRCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVKXRCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 12:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbVKXRCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 12:02:43 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:47750 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932430AbVKXRCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 12:02:42 -0500
Message-ID: <4385F22E.4020509@m1k.net>
Date: Thu, 24 Nov 2005 12:02:38 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>, Johannes Stezenbach <js@linuxtv.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Linux 2.6.15-rc2
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511231736.58204.gene.heskett@verizon.net> <Pine.LNX.4.61.0511232338100.4550@goblin.wat.veritas.com> <200511231937.34206.gene.heskett@verizon.net> <Pine.LNX.4.61.0511240741020.5619@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0511240741020.5619@goblin.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>Got it, building src tree now, config'd & building.
>
>And, I unchecked everything but what I need to run this card (I think,
>whatdoIknow) and got this at depmod time:
>WARNING:
>/lib/modules/2.6.15-rc2-git4/kernel/drivers/media/video/cx88/cx88-dvb.ko
>needs unknown symbol mt352_attach
>WARNING:
>/lib/modules/2.6.15-rc2-git4/kernel/drivers/media/video/cx88/cx88-dvb.ko
>needs unknown symbol nxt200x_attach
>WARNING:
>/lib/modules/2.6.15-rc2-git4/kernel/drivers/media/video/cx88/cx88-dvb.ko
>needs unknown symbol mt352_write
>WARNING:
>/lib/modules/2.6.15-rc2-git4/kernel/drivers/media/video/cx88/cx88-dvb.ko
>needs unknown symbol lgdt330x_attach
>WARNING:
>/lib/modules/2.6.15-rc2-git4/kernel/drivers/media/video/cx88/cx88-dvb.ko
>needs unknown symbol cx22702_attach
>
>Maybe somebody can take the time to tell me what I do need to run a
>pcHDTV-3000 in both ntsc and atsc modes using this newer code?
>I was under the impression I needed the cx88 stuffs, ORV51132 (for
>atsc) and nxt2002(for ntsc), but now we have lots of other dependencies
>out the wazoo.  Please clarify.
>  
>
Gene-

These other dependencies have always been there, except that nxt200x and 
lgdt330x are relatively new frontends.

The difference is that a new Kconfig / Makefile feature is allowing us 
to only select the specific frontend needed by your hardware... 
Previously, all frontend support was forced to be built-in.

You and Adrian have clearly demonstrated that this frontend selection 
capability isn't working properly.  I think I will send Linus a patch to 
restore previous functionality, forcing all frontends to be built... 
Then I will resubmit a patch to Andrew that will re-enable this frontend 
selection support, and I'll ask him to hold it in -mm until we can work 
out the bugs.

The problem is that you are selecting cx88-dvb to be built-in to the 
kernel (not as a module) , but the frontends are being built as modules 
only.  This is a problem.

You can make it all work, if you select the option to build support for 
ALL FRONTENDS  (this is the same as the older functionality)... This 
option was selected by default in menuconfig. ... If you do not want to 
have all frontends supported, then you should be fine if you recompile 
the kernel again, but be sure to compile cx88 and cx88-dvb as MODULES 
(m) ... and not in-kernel (y)

Regards,

Michael Krufky


