Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbUJ3SJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbUJ3SJK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbUJ3SHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:07:17 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:33204 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261262AbUJ3SGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:06:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=G0I6UDb4+/v2sHBc5g0C3NhH0FZENML9rR3Vh2IidJPs9UVWOOqkVTOYXUQ9nMIieA8xfyPnXzOkbcgDEzZBNA6T9Hj04gurkkiMwPidoCG82M21jBRhM9pryPrkp4oxmZO877UwFHrIxOU5/Y+k7j/kVd5bVmHU4DjyG9VjDq0=
Message-ID: <58cb370e04103011065c265ce4@mail.gmail.com>
Date: Sat, 30 Oct 2004 20:06:11 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: CaT <cat@zip.com.au>
Subject: Re: PDC20267 bug and corruption (was: Re: [BK PATCHES] ide-2.6 update)
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041030034745.GA1287@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <58cb370e04102706074c20d6d7@mail.gmail.com>
	 <20041027133431.GF1127@zip.com.au>
	 <58cb370e04102706512283405@mail.gmail.com>
	 <20041030034745.GA1287@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004 13:47:45 +1000, CaT <cat@zip.com.au> wrote:
> On Wed, Oct 27, 2004 at 03:51:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > http://bugme.osdl.org/show_bug.cgi?id=2494
> 
> Tried it via bk7, wasn't it.
> 
> Looks like I have found a bug relating to the pdc driver though.
> 
> The situation is such: I have 2 HDs connected to a PDC20267 PCI card,
> one on each channel, with a master on the primary channel and a slave on
> the secondry channel. Accessing each drive individually causes no
> problems at all but accessing them simultaneously (like copying data off
> one drive onto the other) causes the IDE layer to go to hell in a hand
> basket. I can duplicate this each and every time by doing the following:
> 
> 1. copying a few gig from hde to hdh
> 2. dd if=/dev/hde of=/dev/null
>    dd if=/dev/zero of=/dev/hdh
> 
> With method #1 I get the following:
> 
> Oct 27 00:37:39 nessie kernel: attempt to access beyond end of device
> Oct 27 00:37:39 nessie kernel: hdh1: rw=1, want=3034756264, limit=390716802
> Oct 27 00:37:40 nessie kernel: Aborting journal on device hdh1.
> Oct 27 00:37:40 nessie kernel: ext3_abort called.
> Oct 27 00:37:40 nessie kernel: EXT3-fs error (device hdh1): ext3_journal_start: Detected aborted journal
> Oct 27 00:37:40 nessie kernel: Remounting filesystem read-only
> Oct 27 00:37:40 nessie kernel: EXT3-fs error (device hdh1) in start_transaction: Journal has aborted

This comes from the block layer, generic_make_request(),
request is screwed up before it hits IDE layer.

> With method #2, a whole lot more fun occurs. The logfile I have is big
> (almost 400k) so I've compressed it and included it as an attachment.
> This is with kernel 2.6.10-rc1-bk7 (no logs survived from me testing
> this with rc1-mm2).

Indeed, this is a lot more fun. ;)

Is this bug new/old?

Is it pdc202xx_old specific?  Does the same havoc happen
if you connect drives to the on-board Intel IDE controller?

Please post /proc identify data for both drives and PCI config
space dump for PDC20267 so someone can verify them.
