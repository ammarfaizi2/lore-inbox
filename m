Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161127AbWJDHtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbWJDHtk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbWJDHtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:49:40 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:62422 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1161127AbWJDHtj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:49:39 -0400
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
From: Johannes Berg <johannes@sipsolutions.net>
To: Theodore Tso <tytso@mit.edu>
Cc: "John W. Linville" <linville@tuxdriver.com>, Jeff Garzik <jeff@garzik.org>,
       jt@hpl.hp.com, Linus Torvalds <torvalds@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061003231648.GB26351@thunk.org>
References: <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com>
	 <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com>
	 <1159890876.20801.65.camel@mindpipe>
	 <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org>
	 <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org>
	 <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org>
	 <20061003214038.GE23912@tuxdriver.com>  <20061003231648.GB26351@thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 09:49:39 +0200
Message-Id: <1159948179.2817.26.camel@ux156>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
X-sips-origin: local
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 19:16 -0400, Theodore Tso wrote:

> OK, I'm going to ask a stupid question.  Why is the kernel<->wireless
> driver interface have to be tied to the userspace<->wireless
> interface?  

Haha. Because Jean thinks it isn't and thus everything is fine. But in
reality it is.

> Is there some reason why this would be too hard to do with the current
> interface?  

Yes: drivers are expected to mostly handle the ioctls directly without a
layer between them and userspace.

> Or is the arguement that if you're going to invest that
> much energy in fixing the userspace interface code, you would rather
> go to d80211/nl80211?

cfg80211 and nl80211 actually do this abstraction, nl80211 gets requests
and rewrites them to cfg80211 structures that are passed to the driver.
I have plans for wext/cfg80211 compat code, essentially replacing the
interface between the drivers and wext by cfg80211 and letting userspace
not even be aware of it.

johannes
