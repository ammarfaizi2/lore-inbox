Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318321AbSG3OvE>; Tue, 30 Jul 2002 10:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318325AbSG3OvE>; Tue, 30 Jul 2002 10:51:04 -0400
Received: from mout0.freenet.de ([194.97.50.131]:464 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S318321AbSG3OvD>;
	Tue, 30 Jul 2002 10:51:03 -0400
Message-ID: <3D46A8A0.2020101@gmx.de>
Date: Tue, 30 Jul 2002 16:54:24 +0200
From: Kai Engert <kai.engert@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Mayer <james@cobaltmountain.com>
CC: linux-kernel@vger.kernel.org, Ani Joshi <ajoshi@unixbox.com>
Subject: Re: Sync bit bug in drivers/video/radeonfb.c ?
References: <3D4689E5.5000504@gmx.de> <20020730143309.GA21219@galileo>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's strange! I'm using a C1MGP, german version.

See http://www.kuix.de/sonyc1/lspci for lspci output.

However, if you apply the patch below, and you have to manually set it 
to vsync low, I guess this means your on boot mode was set to high, 
which is what is requested in modedb.c, and it sounds like the patch 
below is correct. But we probably need more entries in modedb.c to 
support all models of the C1M.

Kai


James Mayer wrote:
> Hi Kai, 
> 
> Oddly enough, if I apply this patch on my C1MV/M, I lose the upper
> half of my uppermost line, and must use fbset -vsync low to fix it.
> 
> I determined the 1200x600 modedb entry using the existing radeonfb
> driver, and it appears our hardware is exactly opposite on this issue.
> 
> Which C1M* do you have?
> 
>   James
> 
> 
>>--- bad/drivers/video/radeonfb.c        Tue Jul 30 14:38:29 2002
>>+++ good/drivers/video/radeonfb.c       Tue Jul 30 14:39:10 2002
>>@@ -2401,8 +2401,8 @@
>>         }
>>
>>         sync = mode->sync;
>>-       h_sync_pol = sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
>>-       v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
>>+       h_sync_pol = sync & FB_SYNC_HOR_HIGH_ACT ? 1 : 0;
>>+       v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 1 : 0;
>>
>>         RTRACE("hStart = %d, hEnd = %d, hTotal = %d\n",
>>                 hSyncStart, hSyncEnd, hTotal);

