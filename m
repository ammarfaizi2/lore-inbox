Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265710AbUAPQky (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 11:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265711AbUAPQky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 11:40:54 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:37252 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265710AbUAPQkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 11:40:52 -0500
Date: Fri, 16 Jan 2004 16:48:34 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200401161648.i0GGmYlJ002181@81-2-122-30.bradfords.org.uk>
To: Jonathan Kamens <jik@kamens.brookline.ma.us>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <16392.2027.90408.850335@jik.kamens.brookline.ma.us>
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us>
 <16389.63781.783923.930112@jik.kamens.brookline.ma.us>
 <16391.24288.194579.471295@jik.kamens.brookline.ma.us>
 <200401160747.i0G7ln1I000368@81-2-122-30.bradfords.org.uk>
 <16392.734.505550.6731@jik.kamens.brookline.ma.us>
 <200401161546.i0GFkkpa002053@81-2-122-30.bradfords.org.uk>
 <16392.2027.90408.850335@jik.kamens.brookline.ma.us>
Subject: Re: Updated on UDMA BadCRC errors + subsequent problems (was: Is it safe to ignore UDMA BadCRC errors?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Jonathan Kamens <jik@kamens.brookline.ma.us>:
> John Bradford writes:
> 
>  > Maybe not - the most common cause I've seen for that message in the
>  > logs is trying to access S.M.A.R.T. information when S.M.A.R.T. is
>  > disabled.
>  > 
>  > I.E. the error should be reproducable with:
>  > 
>  > # smartctl -d /dev/hda
>  > # smartctl -a /dev/hda
>  > 
>  > Are you sure you weren't trying to get S.M.A.R.T. info from the
>  > drive at the time the error was logged?
> 
> My smartctl wants "-s off" rather than "-d", but other than that,
> you're correct, that sequence of commands does ause the same error to
> appear in the logs.  But why/how would SMART be disabled on the drive?
> I've been running smartd on the drive for weeks with no errors of this
> sort, and I fail to see how SMART would suddenly be disabled on the
> drive with no action on my part,

Some motherboard BIOSes disable S.M.A.R.T. on drives connected to
their on-board controllers on each boot.  Quite possibly some PCI IDE
cards do as well.  It's possible, (but probably not likely), that by
trying the drive on different controllers a BIOS somewhere has
disabled S.M.A.R.T.

> so it seems more likely that some
> other condition caused the error.

Quite possibly, but I can only really guess as to what that might be
at this point.

I _think_ that UDMA CRC checking is only done on data transfers, not
commands.  I've CC'ed Alan in the hope of getting some confirmation on
this.  Maybe a command being corrupted on the wire could theoretically
cause that error.

John.
