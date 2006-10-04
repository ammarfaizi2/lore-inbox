Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWJDUw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWJDUw0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWJDUw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:52:26 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:41178 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1751112AbWJDUwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:52:25 -0400
Date: Wed, 4 Oct 2006 13:47:18 -0700
To: Linus Torvalds <torvalds@osdl.org>
Cc: "John W. Linville" <linville@tuxdriver.com>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061004204718.GA4599@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org> <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org> <20061004185903.GA4386@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041216510.3952@g5.osdl.org> <20061004195229.GA4459@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041311420.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610041311420.3952@g5.osdl.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 01:12:17PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 4 Oct 2006, Jean Tourrilhes wrote:
> > 
> > 	Yes, this is precisely what we have been doing, the two APIs
> > have been working at the same time for more than 6 months.
> 
> In the kernel for any particular driver?
> 
> Or just in user-land?
> 
> There's a big difference.

	Both actually.
	I've slightly simplified the situation, because you may not
care for all the details, but if you want to know the gory details...
	It's all started with some kernel drivers changing the way
they handle ESSID. That was last January. So, in the kernel, you had
half the drivers doing the old way (NUL terminated), and half doing
the new way (not NUL terminated).
	I immediately asked to revert to the old way. All the Wireless
people were against me, and this mish-mash of API was kept (it was
public on netdev). At this point, nobody cared that userspace API was
broken and I was left cleaning up the mess.
	Of course, some part of the Wireless Tools did broke on the
new API (I had bug reports), so I had to push new version of Wireless
Tools. And I took this opportunity to finish moving over the API to
the new way.

	Sometime breaking userspace APIs is perfectly OK, while
sometimes it's not. You just have to make sure that Linus does not
hear about it, I guess ;-)

> 			Linus

	Have fun...

	Jean
