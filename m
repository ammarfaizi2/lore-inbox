Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWBPSSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWBPSSc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 13:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWBPSSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 13:18:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44810 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932550AbWBPSSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 13:18:30 -0500
Date: Thu, 16 Feb 2006 18:18:03 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
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
Subject: Re: Linux 2.6.16-rc3
Message-ID: <20060216181803.GG29443@flint.arm.linux.org.uk>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>, "Brown, Len" <len.brown@intel.com>,
	"David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net,
	"Yu, Luming" <luming.yu@intel.com>,
	Ben Castricum <lk@bencastricum.nl>, sanjoy@mrao.cam.ac.uk,
	Helge Hafting <helgehaf@aitel.hist.no>,
	"Carlo E. Prelz" <fluido@fluido.as>,
	Gerrit Bruchh?user <gbruchhaeuser@gmx.de>,
	Nicolas.Mailhot@LaPoste.net, Jaroslav Kysela <perex@suse.cz>,
	Takashi Iwai <tiwai@suse.de>,
	Patrizio Bassi <patrizio.bassi@gmail.com>,
	Bj?rn Nilsson <bni.swe@gmail.com>,
	Andrey Borzenkov <arvidjaar@mail.ru>,
	"P. Christeas" <p_christ@hol.gr>, ghrt <ghrt@dial.kappa.ro>,
	jinhong hu <jinhong.hu@gmail.com>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	linux-scsi@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060212190520.244fcaec.akpm@osdl.org> <20060213203800.GC22441@kroah.com> <1139934883.14115.4.camel@mulgrave.il.steeleye.com> <1140054960.3037.5.camel@mulgrave.il.steeleye.com> <20060216171200.GD29443@flint.arm.linux.org.uk> <1140112653.3178.9.camel@mulgrave.il.steeleye.com> <20060216180939.GF29443@flint.arm.linux.org.uk> <1140113671.3178.16.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140113671.3178.16.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 10:14:31AM -0800, James Bottomley wrote:
> On Thu, 2006-02-16 at 18:09 +0000, Russell King wrote:
> > where scsi_release() is the function called by the device model on the
> > last put of a scsi device.
> > 
> > I guess is more or less what you're trying to do invasively via the
> > driver model.
> 
> Yes ... except I think more than just SCSI has the problem (and we
> actually have it in more than one release function) so it seems like a
> good candidate for a general abstraction.

Maybe implementing it as a helper function would be the best and
simplest solution?

static void scsi_release(struct device *dev)
{
	schedule_release_process(dev, scsi_release_process);
}

where schedule_release_process() contains more or less what I posted
in the previous mailing.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
