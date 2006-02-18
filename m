Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWBRUQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWBRUQc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 15:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWBRUQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 15:16:31 -0500
Received: from mx1.rowland.org ([192.131.102.7]:21252 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932138AbWBRUQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 15:16:30 -0500
Date: Sat, 18 Feb 2006 15:16:29 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Jens Axboe <axboe@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, <linux-acpi@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>,
       "Yu, Luming" <luming.yu@intel.com>, Ben Castricum <lk@bencastricum.nl>,
       <sanjoy@mrao.cam.ac.uk>, Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       Gerrit Bruchh?user <gbruchhaeuser@gmx.de>,
       <Nicolas.Mailhot@LaPoste.net>, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>, Patrizio Bassi <patrizio.bassi@gmail.com>,
       Bj?rn Nilsson <bni.swe@gmail.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       "P. Christeas" <p_christ@hol.gr>, ghrt <ghrt@dial.kappa.ro>,
       jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       <linux-scsi@vger.kernel.org>, Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [linux-usb-devel] Re: Linux 2.6.16-rc3
In-Reply-To: <1140223363.3231.9.camel@mulgrave.il.steeleye.com>
Message-ID: <Pine.LNX.4.44L0.0602181515350.4115-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2006, James Bottomley wrote:

> +/**
> + * execute_in_process_context - reliably execute the routine with user context
> + * @fn:		the function to execute
> + * @data:	data to pass to the function
> + *
> + * Executes the function immediately if process context is available,
> + * otherwise schedules the function for delayed execution.
> + *
> + * Returns:	0 - function was executed
> + *		1 - function was scheduled for execution
> + */
> +int execute_in_process_context(void (*fn)(void *data), void *data,
> +			       struct execute_work *ew)
> +{
> +	if (!in_interrupt()) {
> +		fn(data);
> +		return 0;
> +	}

The test should be in_atomic(), not in_interrupt().

Alan Stern

