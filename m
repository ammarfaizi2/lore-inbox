Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317161AbSFFUoY>; Thu, 6 Jun 2002 16:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317167AbSFFUoX>; Thu, 6 Jun 2002 16:44:23 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:57776 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317161AbSFFUoX>; Thu, 6 Jun 2002 16:44:23 -0400
Date: Thu, 6 Jun 2002 13:44:19 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Shane Walton <dsrelist@yahoo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Stream Lined Booting - SCSI Hold Up
Message-ID: <20020606134419.A24456@eng2.beaverton.ibm.com>
In-Reply-To: <20020605172240.17081.qmail@web20808.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 10:22:40AM -0700, Shane Walton wrote:
> Good day,
> 
> I work with US DoD systems, and one of my requirements
> is to boot an ix86 based system with an aic7xxx SCSI
> interface in 15 seconds.  One of the apparent problems
> is the SCSI BIOS and aic7xxx driver take a long time
> to find one drive and then probe other empty channels.
>  Is there a way to inform the aic7xxx driver of
> connected hardware to limit the initialization phase? 
> Thanks for the help.

I never thought to disable the reset, getting rid of the SCSI resets
probably cuts 10-20 seconds off my boot time.

You can turn of the AIC driver reset, and shorten the selection timeout,
see linux/drivers/scsi/README.aic7xxx for details.

With my hardware, I can also disable the BIOS reset, and limit BIOS
scanning from the BIOS config screen (hit ctl-A during boot).

On my system, it saves me about 10 seconds to boot with:

lilo: linux-1 aic7xxx=no_reset aic7xxx=seltime:3

There are no options in linux scsi to limit the scanning of the target
id's or channels, I don't think there are any in the AIC driver either.

You could hack the driver and lower the max_id, and/or lower max_channel,
or somehow disable unused channels, but I doubt it will save much time
(7 id's * 2 channels * 32 ms/per-selection-timeout or so).

-- Patrick Mansfield
