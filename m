Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbVKWB4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbVKWB4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 20:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbVKWB4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 20:56:00 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:30364 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965199AbVKWBz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 20:55:59 -0500
Message-ID: <4383CC4E.40206@m1k.net>
Date: Tue, 22 Nov 2005 20:56:30 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: Johannes Stezenbach <js@linuxtv.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc2
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511202007.44600.gene.heskett@verizon.net> <20051121013241.GA7009@linuxtv.org> <200511202049.30952.gene.heskett@verizon.net>
In-Reply-To: <200511202049.30952.gene.heskett@verizon.net>
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

>WARNING:/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb
>.ko needs unknown symbol nxt200x_attach.
>
Gene has sent me a copy of his .config ... here are the relevant lines:

[snip]

CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_DVB=m
# CONFIG_VIDEO_CX88_DVB_ALL_FRONTENDS is not set
# CONFIG_VIDEO_CX88_DVB_MT352 is not set
CONFIG_VIDEO_CX88_DVB_OR51132=m
# CONFIG_VIDEO_CX88_DVB_CX22702 is not set
# CONFIG_VIDEO_CX88_DVB_LGDT330X is not set
# CONFIG_VIDEO_CX88_DVB_NXT200X is not set

[snip]

CONFIG_DVB_NXT2002=m
# CONFIG_DVB_NXT200X is not set
# CONFIG_DVB_OR51211 is not set
CONFIG_DVB_OR51132=m
# CONFIG_DVB_BCM3510 is not set
CONFIG_DVB_LGDT330X=m

[snip]

A configuration like this should have compiled cx88-dvb without any 
references to nxt200x at all.

Gene, do you have v4l-kernel cvs installed on top of kernel 2.6.15-rc2?  
Unless I'm missing something, it seems that this is the only way that 
you could have nxt200x support in cx88-dvb without having built the 
nxt200x module itself.  The v4l-kernel cvs build environment has nxt200x 
enabled by default when building against kernels 2.6.15 and later.

If this is true, then you can either disable nxt200x in 
v4l-kernel/v4l/Makefile, or re-build the cvs modules using the dvb + v4l 
merged-tree build environment. 
http://linuxtv.org/v4lwiki/index.php/How_to_build_from_CVS

This would, in effect, give the same result as if you had selected 
CONFIG_VIDEO_CX88_DVB_ALL_FRONTENDS (selected by default in Kconfig)

...or maybe you initially started a kernel build with the nxt200x module 
selected, then stopped the compile, unselected nxt200x, and continued 
the build process without cleaning in between, and after cx88-dvb had 
already been built?  Hmm... I guess that might be a bit far-fetched... 
but to be sure, you can wipe out your kernel tree and rebuild it again 
from scratch using the same .config .

If my assumption above is incorrect, then this will need to be looked 
into a bit deeper.  Please, let me know.

Regards,

Michael Krufky
