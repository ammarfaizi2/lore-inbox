Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934482AbWKXIn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934482AbWKXIn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 03:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934502AbWKXIn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 03:43:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:36824 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S934482AbWKXInZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 03:43:25 -0500
Date: Fri, 24 Nov 2006 00:41:14 -0800
From: Greg KH <greg@kroah.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: ohci1394 oops bisected [was Re: 2.6.19-rc5-mm2 (Oops in	class_device_remove_attrs during nodemgr_remove_host)]
Message-ID: <20061124084114.GE14340@kroah.com>
References: <455DCEF7.3060906@s5r6.in-berlin.de> <455DD42B.1020004@s5r6.in-berlin.de> <20061118094706.GA17879@kroah.com> <455EEE17.4020605@s5r6.in-berlin.de> <455F3DED.3070603@s5r6.in-berlin.de> <455F7EDD.6060007@s5r6.in-berlin.de> <20061119162220.GA2536@inferi.kami.home> <456090C9.1040900@s5r6.in-berlin.de> <20061119123348.4c961515.akpm@osdl.org> <4560C612.7040406@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4560C612.7040406@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 10:01:06PM +0100, Stefan Richter wrote:
> Andrew Morton wrote:
> > On Sun, 19 Nov 2006 18:13:45 +0100
> > Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> >> Looks very much like eth1394's sysfs interface is getting
> >> in the way. And since it is entirely handled by the ieee1394 core, it
> >> means ieee1394 needs the class_dev to dev treatment. I think it's OK if
> >> we just wait for Greg to finish his preliminary patch. Until then,
> >> CONFIG_IEEE1394_ETH1394=n should avoid the oops. (Or Andrew marks
> >> eth1394 broken or removes gregkh-driver-network-device.patch...)
> > 
> > Do we know what's actually wrong, and what needs to be done about it?
> 
> I for one don't know what's needed precisely. But at the moment I
> actually don't want to spend any more time on this because:
>  - It happens only if ohci1394 is unloaded while eth1394 is loaded.
>    (That's not an unusual condition though.)

Yes, I can trigger this quite easily here now.

>  - It happens only in -mm, and only because -mm contains the work-in-
>    progress patches for class_device -> device transition.
> I expect it to go away automatically once Greg is done with the
> transition. It seems Greg is the one to do it :-), at least I'm not
> available right now to lend a hand. There are older ieee1394 bugs in
> mainline with bigger practical impact for me to work on. If there are
> still issues once ieee1394 was converted away from class_device, I'm OK
> with revisiting it.

I'll hold off on submitting the network change to mainline until I fix
this problem, so it might be a while...

thanks for narrowing it down for me.

greg k-h
