Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWBPRi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWBPRi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWBPRi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:38:27 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:31874 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751387AbWBPRi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:38:26 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43F4B796.1010701@s5r6.in-berlin.de>
Date: Thu, 16 Feb 2006 18:34:14 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: James Bottomley <James.Bottomley@SteelEye.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
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
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060212190520.244fcaec.akpm@osdl.org> <20060213203800.GC22441@kroah.com> <1139934883.14115.4.camel@mulgrave.il.steeleye.com> <1140054960.3037.5.camel@mulgrave.il.steeleye.com> <20060216171200.GD29443@flint.arm.linux.org.uk>
In-Reply-To: <20060216171200.GD29443@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.59) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Feb 15, 2006 at 08:56:00PM -0500, James Bottomley wrote:
[...]
>>OK, this is what I'm proposing as the device model fix.  What it does is
>>thread context checking APIs throughout the device subsystem.  SCSI can
>>then use it simply via device_put_process_context().
[...]
>>Since this is planned for post 2.6.16, we have plenty of time to argue
>>about it.
> 
> This is probably an idiotic question, but if there's something in the
> scsi release handler can't be called in non-process context, why can't
> scsi queue up the release processing via the work API itself, rather
> than having to have this additional code and complexity for everyone?

Moreover, why are SCSI release handlers called in non-process context in 
the first place? IMO the fix should be to make sure that SCSI release 
handlers are always called from process context --- by the respective 
layers which manage physical devices, i.e. one or more layers beneath 
SCSI core.
-- 
Stefan Richter
-=====-=-==- --=- =----
http://arcgraph.de/sr/
