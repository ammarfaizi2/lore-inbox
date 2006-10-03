Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWJCXct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWJCXct (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWJCXct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:32:49 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:3026 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S964894AbWJCXcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:32:48 -0400
Date: Tue, 3 Oct 2006 16:31:38 -0700
To: Theodore Tso <tytso@mit.edu>, "John W. Linville" <linville@tuxdriver.com>,
       Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003233138.GA2095@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <20061003231648.GB26351@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003231648.GB26351@thunk.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 07:16:48PM -0400, Theodore Tso wrote:
> On Tue, Oct 03, 2006 at 05:40:44PM -0400, John W. Linville wrote:
> > Unfortunately, I don't see any way to "fix" WE-21 without similarly
> > breaking wireless-tools 29 and other "WE-21 aware" apps.  And since
> > I'll bet that the various WE-aware apps have checks like "if WE >
> > 20" for managing ESSID length settings, we may have painted ourselves
> > into a korner (sic).
> 
> OK, I'm going to ask a stupid question.  Why is the kernel<->wireless
> driver interface have to be tied to the userspace<->wireless
> interface?

	They are not tied since WE-13. But you need a certain amount
of consistency, otherwise it's pure madness. If the driver does X
(no-NUL), but the userspace sees Y (mandatory NUL), then both driver
writer and application writer will go insane. You really want the API
to be as transparent as possible.

	But that's not the issue. The issue is that the userspace API
change was decided at the wireless summit last spring, and this was
something that most wireless people were very strongly advocating for,
including userspace people (Dan, Jouni). And most of it has already
been implemented.
	I think we can trust both Dan and Jouni to have a pretty good
idea of the impact of such changes. They are the one having to
implement it and dealing with the angry users.
	I've done many incompatible changes to the WE API over the
years, and it all went fine and dandy (anybody did notice those
changes ?). They key is to get userspace in place when you do the
kernel change.
	As I said, I was against that change, and I'm the one being
flamed.

> Is there some reason why this would be too hard to do with the current
> interface?

	It's already done with the current interface, you can access
the API with either ioctls or RtNetlink.

> 						- Ted

	Have fun...

	Jean
