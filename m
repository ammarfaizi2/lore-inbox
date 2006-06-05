Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750858AbWFEJYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWFEJYq (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 05:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWFEJYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 05:24:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30632 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750787AbWFEJYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 05:24:45 -0400
Date: Mon, 5 Jun 2006 11:23:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] swsusp: allow drivers to determine between write-resume and actual wakeup
Message-ID: <20060605092342.GI5540@elf.ucw.cz>
References: <20060605091131.GE8106@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605091131.GE8106@htj.dyndns.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 05-06-06 18:11:31, Tejun Heo wrote:
> Currently, there is no way to tell whether a device is resuming to
> write swsusp image or waking up from actual software suspend.  FREEZE
> and SUSPEND are different operations for some devices (e.g. disks
> don't spin down for FREEZE) and the resume operation for each is also
> different.
> 
> This patch makes swsusp change device power state from PMSG_FREEZE to
> PMSG_SUSPEND on resume from software suspend.  A driver can determine
> whether it's getting thawed or resuming by looking at device power
> state - if FREEZE, it's getting thawed to write image; if SUSPEND,
> resuming from software suspend.  This patch doesn't affect drivers
> which don't update device power state.  Only drivers which set power
> state to FREEZE after freezing are affected.

No, sorry.

If driver is interested if previous operation was FREEZE or
SUSPEND... just store that information locally.

If you want to know if you RESUME was after normal FREEZE or if it is
after reboot, there's better patch floating around to do that.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
