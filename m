Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261619AbTCGPN3>; Fri, 7 Mar 2003 10:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261618AbTCGPN3>; Fri, 7 Mar 2003 10:13:29 -0500
Received: from mailin.zma.compaq.com ([161.114.64.101]:37388 "EHLO
	zmamail01.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S261619AbTCGPN2>; Fri, 7 Mar 2003 10:13:28 -0500
Date: Fri, 7 Mar 2003 09:27:40 +0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: michael.ni@hp.com, greg@kroah.com, torben.mathiasen@hp.com
Subject: PCI hotplug w/ drivers linked statically vs. module
Message-ID: <20030307032740.GA5236@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,

I noticed a difference in behavior with PCI hotplug, depending
on if the driver in questino is loaded as a module, or statically
linked.

For example, the tg3 driver, hot-unplugging, then hot-replugging
works seemingly well if the driver is a module, but differnetly (poorly?)
if it is statically linked. (eth0 disappears and does not come
back.)

Trying out the cciss driver (with some changes), we did get it to
hot-unplug and hot-replug while it was in use as md multipath
primary path (failed over to secondary path ok upon hot-unplug.)  
and then i/o was able to be done on the old card when the card was 
re-plugged.  This was with the driver linked as a module.
(BTW, how can you tell the md driver that a failed path
is now good again?)

However, if we linked statically, then we still get requests
coming into the driver after the hba[] structure is deallocated.
(resulting in a panic). This does not seem to happen if the driver 
is linked as a module.

Looking at the tg3 driver, it doesn't seem to take any precautions
in it's remove function.  (Maybe there are things in the upper layers
there for e.g. pcmcia, that make it work...)

Note, in no case that I can see is the modular driver _unloaded_.
(e.g. there are other same type  boards in the system which continue to
function after one board is hot-unplugged) 

So why the difference in behavior with PCI hotplug and drivers
linked statically vs. as a module?

Thanks,

-- steve

