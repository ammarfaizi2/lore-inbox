Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265774AbUGMUJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265774AbUGMUJH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUGMUJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:09:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49565 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265774AbUGMUJD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:09:03 -0400
Date: Tue, 13 Jul 2004 16:14:45 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: haiquy@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27-rc3 __alloc_pages: 3-order allocation failed (gfp=0x20/0)
Message-ID: <20040713191445.GB9655@logos.cnet>
References: <Pine.LNX.4.53.0407132101340.437@linuxcd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0407132101340.437@linuxcd>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 09:07:55PM +0000, haiquy@yahoo.com wrote:
> 
> Hi,
> 
> I got a lot such errors log when run dmesg and the rpogram cdda2wav seems stop
> extracting audio cds
> 
> Some others log like:
> 
> scsi : aborting command due to timeout : pid 3260, scsi0, channel 0, id 1, lun 0 0x00 00 00 00 00 00
> scsi : aborting command due to timeout : pid 3260, scsi0, channel 0, id 1, lun 0 0x00 00 00 00 00 00
> SCSI host 0 abort (pid 3260) timed out - resetting
> SCSI bus is being reset for host 0 channel 0.
> SCSI host 0 channel 0 reset (pid 3260) timed out - trying harder
> SCSI bus is being reset for host 0 channel 0.
> scsi : aborting command due to timeout : pid 3256, scsi0, channel 0, id 1, lun 0 0xbe 04 00 00 00 00 00 00 4b 10 00 00
> hdd: lost interrupt
> 
> I use ide-scsi for ide cdrom as cdda2wav requires this. If I use normal ide-cd
> and use cdparanoia it works as normal.
> 
> What should I do to help debuging this problem?

Hi Steve,

The "3-order allocation failures" should not be a problem - its just 
the ide-scsi driver trying to allocate a big scatter-gather list of 8 pages,
it fails then tries to allocate "smaller pieces" (4 pages then if that fails 
1 page of memory). 

Now the problem is the ide-scsi timeout's -- I really have not much of 
an idea what could be going wrong there.

