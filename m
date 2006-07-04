Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWGDBER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWGDBER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 21:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWGDBER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 21:04:17 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:55999 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751348AbWGDBER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 21:04:17 -0400
Message-ID: <44A9BE75.9020706@garzik.org>
Date: Mon, 03 Jul 2006 21:03:49 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (checksums)
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>	<20060701170729.GB8763@irc.pl>	<20060701174716.GC24570@cip.informatik.uni-erlangen.de>	<20060701181702.GC8763@irc.pl>	<20060703202219.GA9707@aitel.hist.no>	<20060703205523.GA17122@irc.pl>	<1151960503.3108.55.camel@laptopd505.fenrus.org>	<1151964720.16528.22.camel@localhost.localdomain> <17577.43190.724583.146845@cse.unsw.edu.au>
In-Reply-To: <17577.43190.724583.146845@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> Can't say I agree with this layering distinction.
> It's been some years that I've felt that most 'logical volume
> management' really belongs in the filesystem.
> Why have a dm that chops devices up in to segments and assembles them to
> look like a big device, only to have that big device chopped up and
> presented as files.  Seems like double handling to me.

Agreed, and allow me to take an even more radical position:

I've long felt that things like snapshotting and mirroring made a lot of 
sense at the filesystem level -- as do layered filesystems, just like we 
layer block devices.

Block device drivers (MD, DM) get ever more complicated, and ultimately 
become mini-filesystems themselves.  The metadata managed by blkdev 
drivers continues to increase in complexity.  What is represented to the 
upper layer as a contiguous run of bytes is really, under the hood, 
chunks of data coalesced logically -- just like files in a filesystem.

The more complex that blkdev drivers become, the more and more they will 
look like filesystems.

	Jeff



