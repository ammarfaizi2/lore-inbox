Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030672AbWJCXSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030672AbWJCXSN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030675AbWJCXSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:18:13 -0400
Received: from thunk.org ([69.25.196.29]:65252 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030674AbWJCXSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:18:08 -0400
Date: Tue, 3 Oct 2006 19:16:48 -0400
From: Theodore Tso <tytso@mit.edu>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Jeff Garzik <jeff@garzik.org>, jt@hpl.hp.com,
       Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003231648.GB26351@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	"John W. Linville" <linville@tuxdriver.com>,
	Jeff Garzik <jeff@garzik.org>, jt@hpl.hp.com,
	Linus Torvalds <torvalds@osdl.org>,
	Lee Revell <rlrevell@joe-job.com>,
	Alessandro Suardi <alessandro.suardi@gmail.com>,
	Norbert Preining <preining@logic.at>, hostap@shmoo.com,
	ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, johannes@sipsolutions.net
References: <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003214038.GE23912@tuxdriver.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 05:40:44PM -0400, John W. Linville wrote:
> Unfortunately, I don't see any way to "fix" WE-21 without similarly
> breaking wireless-tools 29 and other "WE-21 aware" apps.  And since
> I'll bet that the various WE-aware apps have checks like "if WE >
> 20" for managing ESSID length settings, we may have painted ourselves
> into a korner (sic).

OK, I'm going to ask a stupid question.  Why is the kernel<->wireless
driver interface have to be tied to the userspace<->wireless
interface?  The first is internal to the kernel and is free to change,
and if it breaks out-of-tree drivers, I'll complain to Intel about why
the !@#@ the ipw3945 driver hasn't been merged, but we've never made
any guarantees about break out-of-tree drivers, so I wouldn't have the
right to complain to anyone else.

The second is an external userspace ABI, and that should remain
constant.  It sounds like right now one gets pushed straight out to
the other, but what if the wireless infrastructure layer in the kernel
provided "interface glue" so you can translate between multiple
interface versions --- and then force the userspace (or at least new
versions of the userspace) to declare to the kernel what version of
the interface they are expecting?  

That's what we do with the stat system call.  Userspace tells the
kernel whether they want the v1, v2, v3, v4, or v5 version of the stat
structure, and we have interface glue to support all of the old versions.  

Is there some reason why this would be too hard to do with the current
interface?  Or is the arguement that if you're going to invest that
much energy in fixing the userspace interface code, you would rather
go to d80211/nl80211?

Regards,

						- Ted
