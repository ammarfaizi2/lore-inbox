Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263898AbTCVVko>; Sat, 22 Mar 2003 16:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263905AbTCVVkn>; Sat, 22 Mar 2003 16:40:43 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:35200 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S263898AbTCVVkn>; Sat, 22 Mar 2003 16:40:43 -0500
Date: Sat, 22 Mar 2003 15:51:46 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Dawson Engler <engler@csl.stanford.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] race in 2.5.62/drivers/isdn/i4l/isdn_common.c?
In-Reply-To: <200303221226.h2MCQ4110972@csl.stanford.edu>
Message-ID: <Pine.LNX.4.44.0303221551120.4854-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Mar 2003, Dawson Engler wrote:

> /u2/engler/mc/oses/linux/linux-2.5.62/drivers/isdn/i4l/isdn_common.c:636:drv_stat_unload:ERROR:RACE:636:636:unprotected access to variable (*dev).channels,isdn_dev.channels,1[nvars=2] [vars=(*dev).channels,isdn_dev.channels,1:636 (*dev).channels,isdn_dev.channels,1:636 ][non_csect_reads=1] [non_csect_writes=1][modified=1] [locked_uses=1] [unlocked_uses=1] [n_writes=2] [n_reads=3] [n_root=2] [n_file_write=1] [n_file_read=1] [n_unlocked=1][has_locked=1] [depth=1] [path=/u2/engler/mc/oses/linux/linux-2.5.62/drivers/isdn/i4l/isdn_common.c:drv_stat_unload:634->end=/u2/engler/mc/oses/linux/linux-2.5.62/drivers/isdn/i4l/isdn_common.c:drv_stat_unload:636] [score=5] [z=-0.62] [rank=easy]
> 
>         spin_lock_irqsave(&drivers_lock, flags);
>         drivers[drv->di] = NULL;
>         spin_unlock_irqrestore(&drivers_lock, flags);
>         put_drv(drv);
> 
> 
> Error --->
>         dev->channels -= drv->channels;
> 

Yes, that's a bug. I'll fix it.

Thanks,
--Kai


