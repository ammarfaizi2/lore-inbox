Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWBRCMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWBRCMW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 21:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWBRCMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 21:12:22 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:21528 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1750738AbWBRCMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 21:12:20 -0500
X-IronPort-AV: i="4.02,126,1139212800"; 
   d="scan'208"; a="406858769:sNHT44644452"
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>, Ben Castricum <lk@bencastricum.nl>,
       sanjoy@mrao.cam.ac.uk, Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       Gerrit Bruchh?user <gbruchhaeuser@gmx.de>, Nicolas.Mailhot@LaPoste.net,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       Patrizio Bassi <patrizio.bassi@gmail.com>,
       Bj?rn Nilsson <bni.swe@gmail.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       "P. Christeas" <p_christ@hol.gr>, ghrt <ghrt@dial.kappa.ro>,
       jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: Linux 2.6.16-rc3
X-Message-Flag: Warning: May contain useful information
References: <20060212190520.244fcaec.akpm@osdl.org>
	<20060213203800.GC22441@kroah.com>
	<1139934883.14115.4.camel@mulgrave.il.steeleye.com>
	<1140054960.3037.5.camel@mulgrave.il.steeleye.com>
	<20060216171200.GD29443@flint.arm.linux.org.uk>
	<1140112653.3178.9.camel@mulgrave.il.steeleye.com>
	<20060216180939.GF29443@flint.arm.linux.org.uk>
	<1140113671.3178.16.camel@mulgrave.il.steeleye.com>
	<20060216181803.GG29443@flint.arm.linux.org.uk>
	<1140116969.3178.24.camel@mulgrave.il.steeleye.com>
	<20060216200138.GA4203@suse.de>
	<1140223363.3231.9.camel@mulgrave.il.steeleye.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 17 Feb 2006 18:12:04 -0800
In-Reply-To: <1140223363.3231.9.camel@mulgrave.il.steeleye.com> (James
 Bottomley's message of "Fri, 17 Feb 2006 16:42:43 -0800")
Message-ID: <adaaccpbekr.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 18 Feb 2006 02:12:05.0984 (UTC) FILETIME=[B6FE6E00:01C63430]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Is testing in_interrupt() really sufficient to make this work?  I seem
to remember that (at least) with CONFIG_PREEMPT disabled, there are
contexts where it is not safe to sleep but where both in_interrupt()
and in_atomic() still return 0.

 - R.
