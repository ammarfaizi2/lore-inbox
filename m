Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVLTOOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVLTOOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 09:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVLTOOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 09:14:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42811 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751054AbVLTOOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 09:14:40 -0500
Date: Tue, 20 Dec 2005 15:16:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [PATCH] block: Better CDROMEJECT
Message-ID: <20051220141614.GK3734@suse.de>
References: <1135047119.8407.24.camel@leatherman> <20051220074652.GW3734@suse.de> <1135082490.16754.0.camel@localhost.localdomain> <20051220132821.GH3734@suse.de> <1135085557.16754.2.camel@localhost.localdomain> <20051220133939.GI3734@suse.de> <1135087637.16754.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135087637.16754.12.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20 2005, Ben Collins wrote:
> On Tue, 2005-12-20 at 14:39 +0100, Jens Axboe wrote:
> > > Should be an easy check to add. In fact, I'll resend both patches with
> > > that in place if you want.
> > 
> > There's still the quirky problem of forcing a locked tray out. In some
> > cases this is what you want, if things get stuck for some reason or
> > another. But usually the tray is locked for a good reason, because there
> > are active users of the device.
> > 
> > Say two processes has the cdrom open, one of them doing io (maybe even
> > writing!), the other could do a CDROMEJECT now and force the ejection of
> > a busy drive.
> 
> But that's possible now with "eject -s" as long as you have write access
> to it. Most users are using "eject -s" anyway.
> 
> You can't stop this from happening. However, the fact is that a lot of
> devices (iPod's being the most popular) require this to work.

Well just because it (unfortunately) is already done by some other path,
doesn't make it a good idea by default and necessarily a reason to
further such bad principles.

The only way to really fix this would be requiring programs issuing
direct commands to a device to have it opened O_EXCL (and making sure
this actually works, right now it doesn't).

In reality, we are probably screwed :/

-- 
Jens Axboe

