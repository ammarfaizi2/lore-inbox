Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWEORVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWEORVu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWEORVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:21:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36057 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964999AbWEORVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:21:49 -0400
Date: Mon, 15 May 2006 10:18:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [RFT] major libata update
Message-Id: <20060515101831.0e38d131.akpm@osdl.org>
In-Reply-To: <20060515170006.GA29555@havoc.gtf.org>
References: <20060515170006.GA29555@havoc.gtf.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> wrote:
>
> 
> After much development and review, I merged a massive pile of libata
> patches from Tejun Heo and Albert Lee.  This update contains the
> following major libata
> 
> CHANGES:
> * Rewritten error handling. This is a major piece of work, even
>   though it will be rarely seen.  The new libata EH provides the
>   foundation for not only improved error handling, but also new features
>   such as device hotplug or command queueing. (Tejun Heo)
> 
> * PIO-based I/O is now IRQ-driven by default, rather than polled
>   in a kernel thread.  The polling path will continue to exist for
>   controllers that need it, and other special cases. (Albert Lee)
> 
> * Core support for command queueing (Jens Axboe, Tejun Heo)
> 
> * Support for NCQ-style command queueing (Jens Axboe, Tejun Heo)
> 
> * Increase max-sectors dramatically, for LBA48 devices (Tejun Heo?)
> 
> * Other minor changes, from myself and others.
> 
> IMPACT:
> * If all goes well, this update should improve error handling,
>   solve several outstanding, difficult-to-solve bugs, and provide a good
>   foundation for adding some nifty features in the future.
> 
> TESTING:
> * Although most drivers by count received few operational changes, the
> common probe path was updated, so all drivers need fresh "yes, it sees
> all my disks" regression testing.
> 
> * ahci and sata_sil24 were touched a lot, and so need additional
> testing.
> 
> * sata_sil and ata_piix also need healthy re-testing of all basic
> functionality.

Lots of goodies.

> FEEDBACK:
> * Please CC linux-ide@vger.kernel.org on all emails and bug reports.
> 
> MERGE STATUS:
> * Barring major problems in testing, will submit during 2.6.18 merge window.

I'd be a little concerned with that merge plan at this time - we have a lot
of sata bug reports banked up and afaict a pretty low fixup rate.  Then
again, these patches might fix some of those bugs...

I guess if we can get it all in early (which is only a couple of weeks
away!) and you and Tejun will have time set aside to work on problems then
OK.  But....

http://bugzilla.kernel.org/show_bug.cgi?id=4920
http://bugzilla.kernel.org/show_bug.cgi?id=5533
http://bugzilla.kernel.org/show_bug.cgi?id=5586
http://bugzilla.kernel.org/show_bug.cgi?id=5589
http://bugzilla.kernel.org/show_bug.cgi?id=5798
http://bugzilla.kernel.org/show_bug.cgi?id=5863
http://bugzilla.kernel.org/show_bug.cgi?id=4968
http://bugzilla.kernel.org/show_bug.cgi?id=5047
http://bugzilla.kernel.org/show_bug.cgi?id=5905
http://bugzilla.kernel.org/show_bug.cgi?id=5596
http://bugzilla.kernel.org/show_bug.cgi?id=5654
http://bugzilla.kernel.org/show_bug.cgi?id=5664
http://bugzilla.kernel.org/show_bug.cgi?id=5700
http://bugzilla.kernel.org/show_bug.cgi?id=5709
http://bugzilla.kernel.org/show_bug.cgi?id=5721
http://bugzilla.kernel.org/show_bug.cgi?id=5722
http://bugzilla.kernel.org/show_bug.cgi?id=5922
http://bugzilla.kernel.org/show_bug.cgi?id=5789
http://bugzilla.kernel.org/show_bug.cgi?id=5931
http://bugzilla.kernel.org/show_bug.cgi?id=5969
http://bugzilla.kernel.org/show_bug.cgi?id=5948
http://bugzilla.kernel.org/show_bug.cgi?id=5987
http://bugzilla.kernel.org/show_bug.cgi?id=5995
http://bugzilla.kernel.org/show_bug.cgi?id=6173
http://bugzilla.kernel.org/show_bug.cgi?id=6207
http://bugzilla.kernel.org/show_bug.cgi?id=6240
http://bugzilla.kernel.org/show_bug.cgi?id=6253
http://bugzilla.kernel.org/show_bug.cgi?id=6260
http://bugzilla.kernel.org/show_bug.cgi?id=6272
http://bugzilla.kernel.org/show_bug.cgi?id=6283
http://bugzilla.kernel.org/show_bug.cgi?id=6311
http://bugzilla.kernel.org/show_bug.cgi?id=6317
http://bugzilla.kernel.org/show_bug.cgi?id=6346
http://bugzilla.kernel.org/show_bug.cgi?id=6470
http://bugzilla.kernel.org/show_bug.cgi?id=6056
http://bugzilla.kernel.org/show_bug.cgi?id=6494
http://bugzilla.kernel.org/show_bug.cgi?id=6516
http://bugzilla.kernel.org/show_bug.cgi?id=6521

