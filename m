Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUHGR1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUHGR1I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 13:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUHGR1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 13:27:08 -0400
Received: from c-67-171-146-69.client.comcast.net ([67.171.146.69]:13773 "EHLO
	kryten.internal.splhi.com") by vger.kernel.org with ESMTP
	id S263775AbUHGR04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 13:26:56 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Tim Wright <timw@splhi.com>
To: Martin Mares <mj@ucw.cz>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       James.Bottomley@steeleye.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040807001427.GA10890@ucw.cz>
References: <200408070001.i7701PSa006663@burner.fokus.fraunhofer.de>
	 <20040807001427.GA10890@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Splhi
Message-Id: <1091899593.20043.14.camel@kryten.internal.splhi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 10:26:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-06 at 17:14, Martin Mares wrote:
> Hello!
> 
> > I see always the same answers from Linux people who don't know anyrthing than
> > their belly button :-(
> > 
> > Chek Solaris to see that your statements are wrong.
> 
> Well, so could you please enlighten the Linux people and say in a couple
> of words how it could be done?
> 
> 				Have a nice fortnight

I can offer reasons as to why it cannot :-)

The path_to_inst stuff assumes a simple physical bus topology. It is
completely unsuited to e.g. a fibre-channel fabric. It is also unsuited
to iSCSI - my disks aren't attached to eth0, they're attached to
whichever interface has a route to the server. It's also worthless for
USB. The controller, bus and target are meaningless - the target number
is dynamically assigned at plugin so giving a name to controller 0, bus
0 target 3 is utterly pointless.

Linux and/or associated drivers has mechanisms to handle consistent
naming for a number of these (WWPN-binding for FC, similar device
binding of the unique ids for iSCSI, the hotplug infrastructure for usb
etc.). All of these map devices to consistent device names in /dev. The
"Unix" way of accessing devices has always been via names in /dev. I
completely fail to understand why Joerg wants to try to force a naming
model that is both alien to the native systems (I want /dev/cdrw on
Linux; I probably want D: on Windows or something like that), and is
inadequate to the task if you move beyond the simple world of parallel
SCSI.

Tim

-- 
Tim Wright <timw@splhi.com>
