Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318290AbSG3O33>; Tue, 30 Jul 2002 10:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318291AbSG3O33>; Tue, 30 Jul 2002 10:29:29 -0400
Received: from 12-252-146-102.client.attbi.com ([12.252.146.102]:59409 "EHLO
	archimedes") by vger.kernel.org with ESMTP id <S318290AbSG3O32>;
	Tue, 30 Jul 2002 10:29:28 -0400
Date: Tue, 30 Jul 2002 08:33:09 -0600
To: linux-kernel@vger.kernel.org
Cc: Kai Engert <kai.engert@gmx.de>, Ani Joshi <ajoshi@unixbox.com>
Subject: Re: Sync bit bug in drivers/video/radeonfb.c ?
Message-ID: <20020730143309.GA21219@galileo>
Mail-Followup-To: James Mayer <james@cobaltmountain.com>,
	linux-kernel@vger.kernel.org, Kai Engert <kai.engert@gmx.de>,
	Ani Joshi <ajoshi@unixbox.com>
References: <3D4689E5.5000504@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4689E5.5000504@gmx.de>
User-Agent: Mutt/1.4i
From: James Mayer <james@cobaltmountain.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai, 

Oddly enough, if I apply this patch on my C1MV/M, I lose the upper
half of my uppermost line, and must use fbset -vsync low to fix it.

I determined the 1200x600 modedb entry using the existing radeonfb
driver, and it appears our hardware is exactly opposite on this issue.

Which C1M* do you have?

  James

> --- bad/drivers/video/radeonfb.c        Tue Jul 30 14:38:29 2002
> +++ good/drivers/video/radeonfb.c       Tue Jul 30 14:39:10 2002
> @@ -2401,8 +2401,8 @@
>          }
> 
>          sync = mode->sync;
> -       h_sync_pol = sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
> -       v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
> +       h_sync_pol = sync & FB_SYNC_HOR_HIGH_ACT ? 1 : 0;
> +       v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 1 : 0;
> 
>          RTRACE("hStart = %d, hEnd = %d, hTotal = %d\n",
>                  hSyncStart, hSyncEnd, hTotal);
