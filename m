Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbUCTBQA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 20:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbUCTBP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 20:15:59 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:50102 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263215AbUCTBPn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 20:15:43 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] barrier patch set
Date: Sat, 20 Mar 2004 02:24:14 +0100
User-Agent: KMail/1.5.3
References: <20040319153554.GC2933@suse.de> <200403200140.59543.bzolnier@elka.pw.edu.pl> <405B936C.50200@pobox.com>
In-Reply-To: <405B936C.50200@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403200224.14055.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 of March 2004 01:42, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Saturday 20 of March 2004 01:14, Jeff Garzik wrote:
> >>Bartlomiej Zolnierkiewicz wrote:
> >>>The fact that spec says "supported" not "enabled" in description of
> >>>word86 makes me wonder - can they be disabled? (FLUSH CACHE is mandatory
> >>>for General feature set and FLUSH CACHE EXT is mandatory if 48-bit LBA
> >>> is supported)
> >>
> >>Yes, that's why there are separate 'supported' and 'enabled' bits for
> >>each feature.
> >>
> >>Words 82-84 are 'supported' bits.  Words 85-87 are 'enabled' bits.
> >>These bits mirror each other, i.e. Word 83 and Word 86 have basically
> >>the same bits, except that Word 86 definitions change _slightly_ since
> >>the only bits that are relevant are the ones for features that can be
> >>disabled/enabled.
> >>
> >>You use set-features command to enable and disable these features, and
> >>then the result shows up in subsequent identify-device command output.
> >>
> >>If the driver is testing for a capability but does not enable it, then
> >>always use the 'enabled' set of bits, not the 'supported' set of bits.
> >
> > This is quite obvious but I am talking about confusing wording in
> > description of word86 - for some features 'enabled' is used and for
> > others 'supported'
>
> Yeah, mainly the difference is communicating in the description of each
> word.
>
> Anyway, what I described is how things work :)  For example, features
> that are always enabled in the drive are listed with both support and
> enabled bits set.  The driver sees that, and does not issue a
> set-features command, because it does not need to.

Yep but in your original mail you suggested that we should explicitly enable
FLUSH CACHE and FLUSH CACHE EXT features - there are even no subcommands
to do this.  ;-)

> >>>IMO to test if FLUSH CACHE works we should just issue it during disk
> >>>setup and check result.  This way we can use FLUSH CACHE also on < ATA-6
> >>>devices (there is a lot of them).
> >>
> >>I disagree.  "just issue it" is how those LG cdrom drives got cooked.
> >
> > I'm aware of LG fun.  Jens already stated that current barrier
> > implementation is disk-only and I'm talking about disks only.
> >
> > If anybody reused CACHE FLUSH opcode for disk drive he/she deserves to
> > loose. 8)
>
> Well...  If you don't check the proper feature bits found in the spec, I
> blame the driver for ignoring the spec...  :)

Please point me to these bits in ATA-4 or ATA-5 spec.
Have you checked them as I asked?

> >>All drives that support flush-cache list the relevant bits in
> >>identify-device, even on pre-ATA-6 devices.  Whether the feature was
> >>optional or mandantory, we can check the feature bits.
> >
> > Hm. so this is undocumented in the spec?
>
> ?  When it was optional, there was a feature bit to test.  When it
> became mandantory, the feature bit to test stayed in there.  The feature
> bit is zero, otherwise.  Makes it possible to use "just test the bit"
> and have things Just Work(tm).  :)

I wish it was so simple.  Here is an example to make it clear:

model: WDC WD800JB-00CRA1 firmware: 17.07W77
word 0x83 is 4b01, word 0x86 is 0x0801

and drive of course supports CACHE FLUSH command.

Cheers,
Bartlomiej

