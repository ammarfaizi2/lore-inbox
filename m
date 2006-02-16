Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030630AbWBPTKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030630AbWBPTKE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030631AbWBPTKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:10:00 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:24265 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030628AbWBPTJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:09:58 -0500
Subject: Re: Linux 2.6.16-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, "Brown, Len" <len.brown@intel.com>,
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
In-Reply-To: <20060216181803.GG29443@flint.arm.linux.org.uk>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	 <20060212190520.244fcaec.akpm@osdl.org> <20060213203800.GC22441@kroah.com>
	 <1139934883.14115.4.camel@mulgrave.il.steeleye.com>
	 <1140054960.3037.5.camel@mulgrave.il.steeleye.com>
	 <20060216171200.GD29443@flint.arm.linux.org.uk>
	 <1140112653.3178.9.camel@mulgrave.il.steeleye.com>
	 <20060216180939.GF29443@flint.arm.linux.org.uk>
	 <1140113671.3178.16.camel@mulgrave.il.steeleye.com>
	 <20060216181803.GG29443@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 11:09:29 -0800
Message-Id: <1140116969.3178.24.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 18:18 +0000, Russell King wrote:
> Maybe implementing it as a helper function would be the best and
> simplest solution?
> 
> static void scsi_release(struct device *dev)
> {
> 	schedule_release_process(dev, scsi_release_process);
> }
> 
> where schedule_release_process() contains more or less what I posted
> in the previous mailing.

That's almost exactly the execute_in_process_context() API that began
this discussion (and which Andi NAK'd).  However, it could possibly be
resurrected with the proviso that the caller has to feed in the
workqueue memory.  How would people feel about that?

James


