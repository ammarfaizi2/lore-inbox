Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270695AbTG0Iy3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 04:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270696AbTG0Iy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 04:54:29 -0400
Received: from mailf.telia.com ([194.22.194.25]:60899 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id S270695AbTG0Iy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 04:54:28 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: Oliver Neukum <oliver@neukum.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] System stalls using usb-storage
References: <20030723200051.C18354@one-eyed-alien.net>
	<200307270824.44851.oliver@neukum.org>
	<20030726233545.B20751@one-eyed-alien.net>
From: Peter Osterlund <petero2@telia.com>
Date: 27 Jul 2003 11:09:22 +0200
In-Reply-To: <20030726233545.B20751@one-eyed-alien.net>
Message-ID: <m27k64z67x.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm <mdharm-kernel@one-eyed-alien.net> writes:

> On Sun, Jul 27, 2003 at 08:24:44AM +0200, Oliver Neukum wrote:
> > Am Donnerstag, 24. Juli 2003 05:00 schrieb Matthew Dharm:
> > > The question is, what is the best way to handle this.  I'm guessing that
> > > increasing the priority of the usb-storage control thread will help, but
> > > that's just a guess.  I'm not even sure how to go about doing that, tho...
> > 
> > A kernel thread in the block io path has to have a higher priority than
> > any user task. Otherwise a priority inversion is possible.
> 
> Reasonable.  So, other than renice at the command line, how does one go
> about setting this?

Try this patch. The loop device thread is doing the same thing.

diff -puN drivers/usb/storage/usb.c~usb-priority drivers/usb/storage/usb.c
--- linux/drivers/usb/storage/usb.c~usb-priority	Sun Jul 27 10:56:02 2003
+++ linux-petero/drivers/usb/storage/usb.c	Sun Jul 27 10:56:47 2003
@@ -302,6 +302,8 @@ static int usb_stor_control_thread(void 
 
 	current->flags |= PF_IOTHREAD;
 
+	set_user_nice(current, -20);
+
 	unlock_kernel();
 
 	/* signal that we've started the thread */

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
