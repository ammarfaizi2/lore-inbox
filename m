Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUJRThQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUJRThQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUJRTgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:36:20 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:14760 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S267659AbUJRTfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:35:00 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Jon Smirl <jonsmirl@gmail.com>
Date: Mon, 18 Oct 2004 12:34:45 -0700
MIME-Version: 1.0
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Message-ID: <4173B865.26539.117B09BD@localhost>
In-reply-to: <9e47339104101519034137c795@mail.gmail.com>
References: <200410160946.32644.adaplas@hotpop.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@gmail.com> wrote:

> > There's a log of initialization that goes on between console_init() and
> > populate_rootfs().  However, console_init() will only initialize built-in
> > consoles (as pointed to by conswitchp) such as vgacon or dummycon.
> > However, the framebuffer system initialization does happen after
> > populate_rootfs().
> 
> We already have vgacon, promcon, sticon, mgacon, newportcon. What
> platforms (other than embedded) are not covered by these? 

Many embedded platforms do not map VGA resources in, so it is not 
possible to get VGACon to work on those machines unless the kernel/boot 
loader is modified to properly map VGA resources (which should be 
possible).

Then there are Macintosh machines that also do not map VGA resources. I 
am not sure if it is possible to map them on Macintosh machines or not.

I would assume however a serial port console would be fine for embedded 
machines until the framebuffer driver could come up anyway.

> The idea is to use one of these as a temporary console and not
> print anything on it except KERN_ERR level messages. Of course if
> you are a kernel developer you can change this. A working system
> would non have KERN_ERR messages during this phase and the screen
> would remain blank. 
> 
> Messages at levels other than KERN_ERR would be queued until
> populate_rootfs()/early user space time where they would then get
> displayed on the fbcon. fbcon will be a full console with mode
> setting capability and other fancy features. It would immediately
> go into graphics mode. 

As long as this process happens quickly and the machine boots into 
graphics mode within 1-2 seconds from poweron, that would probably be OK. 
If it starts taking too long for the system to get into graphics mode to 
display something the user can easily think something is wrong and the 
machine is not working.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


