Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbUKWSjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUKWSjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbUKWSg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:36:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45489 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261524AbUKWSeV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:34:21 -0500
Message-ID: <41A3829C.4060901@pobox.com>
Date: Tue, 23 Nov 2004 13:34:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Alan Chandler <alan@chandlerfamily.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ide-cd problem
References: <200411201842.15091.alan@chandlerfamily.org.uk> <200411211025.11629.alan@chandlerfamily.org.uk> <200411211613.54713.alan@chandlerfamily.org.uk> <200411220752.28264.alan@chandlerfamily.org.uk> <20041122080122.GM26240@suse.de>
In-Reply-To: <20041122080122.GM26240@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>  		/* packet command */
> -		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
> +		spin_lock_irqsave(&ide_lock, flags);
> +		HWIF(drive)->OUTBSYNC(drive, WIN_PACKETCMD, IDE_COMMAND_REG);
> +		ndelay(400);
> +		spin_unlock_irqrestore(&ide_lock, flags);
>  		return (*handler) (drive);


FWIW this ndelay(400) is required by the spec, when you submit a command.

	Jeff


