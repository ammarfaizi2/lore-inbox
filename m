Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVD1NZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVD1NZV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 09:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVD1NZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 09:25:21 -0400
Received: from [81.2.110.250] ([81.2.110.250]:56014 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262118AbVD1NZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 09:25:10 -0400
Subject: Re: [06/07] [PATCH] SCSI tape security: require CAP_ADMIN for
	SG_IO etc.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Greg KH <gregkh@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0504280810140.12812@kai.makisara.local>
References: <20050427171446.GA3195@kroah.com>
	 <20050427171649.GG3195@kroah.com>
	 <1114619928.18809.118.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0504280810140.12812@kai.makisara.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114694511.18809.187.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Apr 2005 14:21:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-04-28 at 06:43, Kai Makisara wrote:
> Any user having write access to the device is still allowed to send MODE 
> SELECT (and some other commands useful for CD/DVD writers but being 
> potentially dangerous to other). The assumption that _any_ command needed 
> for burning CDs/DVDs is safe for all device types is ridiculous. This is 
> why I don't consider the refinements useful.

Ok thats the bit I needed to know

> Using MODE SELECT you can change the drive behaviour so that it may become 
> practically useless for other users (and even break very quickly). A 
> simple method is to disable drive buffering. The inconsistency here is 
> that to the users the drive status is not what the system managers meant 
> it to be.

Equally users will want to change the drive status and in some
situations will be changing the drive status habitually when using the
tape devices. That seems to have tape level ioctls anyway.

> Another inconsistency comes from using commands moving the tape so that 
> the tape driver does not know it. The tape driver provides users some 
> status information about the tape head location (file and block number, 
> BOT, EOF, etc.). This information is not valid if tape is moved using 
> pass-through. The basic problem is that the driver for this kind of a 
> sequential access device has to maintain some state information and it 
> gets distorted if pass-through is used. One solution would, of course, be 
> to interpret the commands and statuses going to/coming from pass-through 
> but this is a quite heavy solution.

That isn't a problem. The other drivers and O_DIRECT all take the same
basic approach that users doing raw I/O commands can shoot themselves in
the feet. Anything else stops people doing clever things they need to.
What it must not allow (as you explained in your example with mode
select) is let people shoot each other in the feet.

On the info you give making it CAP_SYS_RAWIO for now does appear to make
sense. A tape safe command or filter list might be better eventually
(and/or making the driver put the state back right on open - which may
also be neccessary when drives get powered off independantly of the
host...)

Alan

