Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWGVKNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWGVKNl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 06:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWGVKNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 06:13:41 -0400
Received: from web37908.mail.mud.yahoo.com ([209.191.124.103]:45465 "HELO
	web37908.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751305AbWGVKNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 06:13:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=uBFLfUEDMppbSLeCRPLZ2T61/oN7Q9AmdNgZV9Z0EkrxUWD5LyZ1nMI/B94LkdCm6D/Ws44PKwCnCV10jJ7rYfxLOulKI9gxe299XrHZB0qoAVXja2rI1PmN0AdnXm5C9f4Bz/0rgv5vtMNcncqDY9B7teF9b8yiJ4SQTiTLzq8=  ;
Message-ID: <20060722101340.79494.qmail@web37908.mail.mud.yahoo.com>
Date: Sat, 22 Jul 2006 03:13:40 -0700 (PDT)
From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] OMAP: Keypad driver
To: Andrew Morton <akpm@osdl.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz, dtor_core@ameritech.net,
       tony@atomide.com, ext-timo.teras@nokia.com, juha.yrjola@solidboot.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060722023935.aab52bd2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:

> 
> The code looks clean.
> 
> - Could use setup_timer().
> 
> - Check the return value from device_create_file() (and any and all
> such
>   similar functions), handle failure appropriately.
> 
> - I don't think the tasklet stopping code is correct. 
> tasklet_disable()
>   will prevent the callback from being called.  The del_timer_sync()
> will
>   kill off the timer.  But the just-killed timer handler might have
> left
>   the tasklet scheduled, and although it will not call the handler,
> the
>   high-level tasklet code can still execute, and will then start
> playing
>   with now-freed data.  A final tasklet_kill() should fix that up.
> 
> - Perhaps the probe function is requesting the IRQ too early?  The
> IRQ
>   handler can perhaps be called while the hardware is still being set
> up. 

Ok. I will move it before 
  
  omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);

> 
> - Use INTF_TRIGGER_FALLING (etc), not the now-deprecated
> SA_TRIGGER_FALLING.

Thanx for the review. I will update the driver and submit the patch.

> 
> - The changelog needs work.  What's an OMAP? ;)

Ok. May changelog needs URL entry like http://linux.omap.com _or_
http://www.ti.com/omap :)

> 
> - Finally, by what authority does random_person@yahoo.com submit
> Nokia
>   and TI's code??  Please review Section 11 of
>   Documentation/SubmittingPatches, seek and obtain signoffs from the
> other
>   authors and then add your own, thanks.

I have CCed all the authors mentioned in the top of the driver file,
and I thought they will just reply with Signed-off-by: line. I never
added my name in Copyright, even when I did some re-organization of
omap keypad driver, which I thought was not major change :)

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
