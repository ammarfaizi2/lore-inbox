Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVC2MYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVC2MYw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 07:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVC2MYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 07:24:19 -0500
Received: from web52902.mail.yahoo.com ([206.190.39.179]:4439 "HELO
	web52902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262234AbVC2MW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 07:22:29 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=AWx+ULqNu07BqT/MlK17I+mbhtKHUx8tad8EufCdYekePC6Hck7Vxt19ZDDK4ptglTexgGwti4uxLI7YIRJMO+MTQuZPjh8pxQl6DAYWO4F5P2OMxa4kX3rshIvU75My69K1dw7ZMi5erkRbGmQMgqqtPv6waI9u9Iyz82L/cJE=  ;
Message-ID: <20050329122226.94666.qmail@web52902.mail.yahoo.com>
Date: Tue, 29 Mar 2005 13:22:26 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I have one IDE hard disc, but I was using a USB memory stick at one
> > point. (Notice the usb-storage and vfat modules in my list.) Could
> > that be the troublesome SCSI device?

--- Jens Axboe <axboe@suse.de> wrote:
> Yes, it probably is. What happens is that you insert the stick and do io
> against it, which sets up a process io context for that device. That
> context persists until the process exits (or later, if someone still
> holds a reference to it), but the queue_lock will be dead when you yank
> the usb device.
> 
> It is quite a serious problem, not just for CFQ. SCSI referencing is
> badly broken there.

That would explain why it was nautilus which caused the oops then. Does this mean that the major
distros aren't using the CFQ then? Because how else can they be avoiding this oops with USB
storage devices?

Send instant messages to your online friends http://uk.messenger.yahoo.com 
