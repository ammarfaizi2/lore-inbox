Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbUKWTSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbUKWTSX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbUKWTPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:15:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7624 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261482AbUKWTOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:14:24 -0500
Date: Tue, 23 Nov 2004 20:13:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ide-cd problem
Message-ID: <20041123191349.GM13174@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk> <200411211025.11629.alan@chandlerfamily.org.uk> <200411211613.54713.alan@chandlerfamily.org.uk> <200411220752.28264.alan@chandlerfamily.org.uk> <20041122080122.GM26240@suse.de> <41A3829C.4060901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A3829C.4060901@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23 2004, Jeff Garzik wrote:
> Jens Axboe wrote:
> > 		/* packet command */
> >-		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
> >+		spin_lock_irqsave(&ide_lock, flags);
> >+		HWIF(drive)->OUTBSYNC(drive, WIN_PACKETCMD, IDE_COMMAND_REG);
> >+		ndelay(400);
> >+		spin_unlock_irqrestore(&ide_lock, flags);
> > 		return (*handler) (drive);
> 
> 
> FWIW this ndelay(400) is required by the spec, when you submit a command.

Yes, I know it isn't pulled out of thin air :)

-- 
Jens Axboe

