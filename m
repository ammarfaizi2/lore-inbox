Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129261AbQKDRIK>; Sat, 4 Nov 2000 12:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129285AbQKDRIB>; Sat, 4 Nov 2000 12:08:01 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:44304 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129261AbQKDRHu>;
	Sat, 4 Nov 2000 12:07:50 -0500
Message-ID: <3A044256.D8CD063C@mandrakesoft.com>
Date: Sat, 04 Nov 2000 12:07:34 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "Hen, Shmulik" <shmulik.hen@intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27077@hasmsx52.iil.intel.com> <3A03DABD.AF4B9AD5@mandrakesoft.com> <20001104111909.A11500@gruyere.muc.suse.de> <3A042D04.5B3A7946@mandrakesoft.com> <20001104175659.A15475@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> All the MOD_INC/DEC_USE_COUNT are done inside the modules themselves. There
> is nothing that would a driver prevent from being unloaded on a different
> CPU while it is already executing in ->open but has not yet executed the add
> yet or after it has executed the _DEC but it is still running in module code
> Normally the windows are pretty small, but very long running interrupt
> on one CPU hitting exactly in the wrong moment can change that.

Module unload calls unregister_netdev, which grabs rtnl_lock.
dev->open runs under rtnl_lock.

Given this, how can the driver be unloaded if dev->open is running?

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
