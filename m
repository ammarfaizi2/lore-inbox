Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVBYBjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVBYBjp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 20:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVBYBjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 20:39:45 -0500
Received: from main.gmane.org ([80.91.229.2]:17300 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262586AbVBYBjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 20:39:42 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH] Symlink /sys/class/block to /sys/block
Date: Fri, 25 Feb 2005 01:35:13 +0000 (UTC)
Message-ID: <loom.20050225T020954-395@post.gmane.org>
References: <courier.4217CBC9.000027C1@mail.farside.org.uk> <20050222190412.GA23687@suse.de> <courier.421C5047.00003EBA@mail.farside.org.uk> <20050224233458.GB26941@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.39.203.103 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041228 Firefox/1.0 Fedora/1.0-8)
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh <at> suse.de> writes:

> 
> On Wed, Feb 23, 2005 at 09:43:35AM +0000, Malcolm Rowe wrote:
> > Greg KH writes: 
> > 
> > >>Following the discussion in [1], the attached patch creates 
> > >>/sys/class/block
> > >>as a symlink to /sys/block. The patch applies to 2.6.11-rc4-bk7.  
> > >>
> > >>Please cc: me on any replies - I'm not subscribed to the mailing list. 
> > >Hm, your patch is linewrapped, and can't be applied :(
> > 
> > Bah, and I did send it to myself first, but I guess my mailer un-flowed it 
> > for me .  I'll try to find a better mailer. 
> > 
> > >But more importantly:
> > >>static void disk_release(struct kobject * kobj)
> > >
> > >Did you try to remove a disk (like a usb device) and see what happens
> > >here?  Hint, this isn't the proper place to remove the symlink...
> > 
> > Er, yeah. Oops. 
> > 
> > *Is* there a sensible place to remove the symlink from, though?  Nobody 
> > seems to call subsystem_unregister(&block_subsys), which is the place I'd 
> > expect to add a call to, and I can't see anything that's otherwise 
> > obvious... 
> 
> If the subsystem is never unregistered, then don't worry about undoing
> the symlink.

This symlink will break a lot of applications out there. If there is not a
_very_ good reason for it, we should not do that.

The "dev" file unfortunately does not tell you if it's a char or block
device node and that should be solved by something better than matching a
magic string somewhere in the middle of a devpath.

The hotplug events will still have the /block/* devpath, so this symlink
will give us nothing than problems.

Thanks,
Kay


