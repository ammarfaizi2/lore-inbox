Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWJPBc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWJPBc7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 21:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWJPBc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 21:32:59 -0400
Received: from animx.eu.org ([216.98.75.249]:47249 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1751286AbWJPBc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 21:32:58 -0400
Date: Sun, 15 Oct 2006 21:22:49 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Neil Brown <neilb@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       aeb@cwi.nl, Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Why aren't partitions limited to fit within the device?
Message-ID: <20061016012249.GA2029@animx.eu.org>
Mail-Followup-To: Neil Brown <neilb@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	aeb@cwi.nl, Jens Axboe <jens.axboe@oracle.com>
References: <17710.54489.486265.487078@cse.unsw.edu.au> <1160752047.25218.50.camel@localhost.localdomain> <17714.52626.667835.228747@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17714.52626.667835.228747@cse.unsw.edu.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Friday October 13, alan@lxorguk.ukuu.org.uk wrote:
> > No I think not. Any partition which is partly outside the disk should be
> > ignored entirely, that ensures it doesn't accidentally get mounted and
> > trashed by an HPA or similar mixup.
> 
> Hmmm.. So Alan things a partially-outside-this-disk partition
> shouldn't show up at all, and Andries thinks it should.
> And both give reasonably believable justifications.
> 
> Maybe we need a kernel parameter?  How about this?

How about something in /proc or /sys to force the partition to show or not?

Maybe something like
echo 1 > /sys/block/hda/hda4/visible
?

Just an idea, my view would be not to introduce a new kernel parameter since
you have to reboot just to see it.  It's quite possible this would effect
USB/Firewire storage devices.  I have never been bitten by this problem
however it would be nice not to have to reboot to solve one like this say on
a slightly corrupted usb memory stick.

A possibility of using words instead of numbers, in the above example could
be one of: yes r/o no  indicating full r/w, r/o, or not visible.

I'm not so sure if the size of the partition that is visible should be the
size according to the partition table or the size according to the start of
the partition to the end of the device.  I would probably choose to have the
size to be the smaller number.

I was bitten by a 2.4 to 2.6 conversion where the size of the disk was 1
sector larger than what I saw in 2.4, but it was a minor problem which was
solved by masking off bit 0 of the size.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
