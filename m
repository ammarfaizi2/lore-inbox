Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbTIURTc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 13:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbTIURTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 13:19:32 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:37019 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262461AbTIURTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 13:19:31 -0400
Date: Sun, 21 Sep 2003 19:19:26 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/11] input: Fix psmouse->pktcnt in Synaptics mode
Message-ID: <20030921171926.GB20856@ucw.cz>
References: <10639672012999@twilight.ucw.cz> <m2k782waz3.fsf@p4.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2k782waz3.fsf@p4.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 03:02:40PM +0200, Peter Osterlund wrote:

> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > ChangeSet@1.1345, 2003-09-19 01:20:33-07:00, vojtech@suse.cz
> >   psmouse-base.c:
> >     Make sure psmouse->pktcnt is zero after passing a byte
> >     to be processed by synaptics code.
> 
> This patch breaks synaptics support, because the pktcnt variable is
> now used by the synaptics code. (Previously the synpatics code used a
> private buffer, which was unnecessary and therefore removed.)
> Reverting this patch makes the touchpad work again for me using kernel
> 2.6.0-test5-bk8:

Sorry for introducing the breakage. Applied to my tree.

>  linux-petero/drivers/input/mouse/psmouse-base.c |    1 -
>  1 files changed, 1 deletion(-)
> 
> diff -puN drivers/input/mouse/psmouse-base.c~fix-psmouse-breakage drivers/input/mouse/psmouse-base.c
> --- linux/drivers/input/mouse/psmouse-base.c~fix-psmouse-breakage	2003-09-21 14:51:59.000000000 +0200
> +++ linux-petero/drivers/input/mouse/psmouse-base.c	2003-09-21 14:52:10.000000000 +0200
> @@ -173,7 +173,6 @@ static irqreturn_t psmouse_interrupt(str
>  		 * so it needs to receive all bytes one at a time.
>  		 */
>  		synaptics_process_byte(psmouse, regs);
> -		psmouse->pktcnt = 0;
>  		goto out;
>  	}
>  
> 
> _
> 
> -- 
> Peter Osterlund - petero2@telia.com
> http://w1.894.telia.com/~u89404340

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
