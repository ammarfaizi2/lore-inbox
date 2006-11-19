Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933283AbWKSVBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933283AbWKSVBu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933284AbWKSVBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:01:50 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:17878 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S933283AbWKSVBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:01:50 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4560C612.7040406@s5r6.in-berlin.de>
Date: Sun, 19 Nov 2006 22:01:06 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mattia Dongili <malattia@linux.it>, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: ohci1394 oops bisected [was Re: 2.6.19-rc5-mm2 (Oops in	class_device_remove_attrs
 during nodemgr_remove_host)]
References: <455CAE0F.1080502@s5r6.in-berlin.de>	<20061116203926.GA3314@inferi.kami.home>	<455CEB48.5000906@s5r6.in-berlin.de>	<20061117071650.GA4974@inferi.kami.home>	<455DCEF7.3060906@s5r6.in-berlin.de>	<455DD42B.1020004@s5r6.in-berlin.de>	<20061118094706.GA17879@kroah.com>	<455EEE17.4020605@s5r6.in-berlin.de>	<455F3DED.3070603@s5r6.in-berlin.de>	<455F7EDD.6060007@s5r6.in-berlin.de>	<20061119162220.GA2536@inferi.kami.home>	<456090C9.1040900@s5r6.in-berlin.de> <20061119123348.4c961515.akpm@osdl.org>
In-Reply-To: <20061119123348.4c961515.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sun, 19 Nov 2006 18:13:45 +0100
> Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>> Looks very much like eth1394's sysfs interface is getting
>> in the way. And since it is entirely handled by the ieee1394 core, it
>> means ieee1394 needs the class_dev to dev treatment. I think it's OK if
>> we just wait for Greg to finish his preliminary patch. Until then,
>> CONFIG_IEEE1394_ETH1394=n should avoid the oops. (Or Andrew marks
>> eth1394 broken or removes gregkh-driver-network-device.patch...)
> 
> Do we know what's actually wrong, and what needs to be done about it?

I for one don't know what's needed precisely. But at the moment I
actually don't want to spend any more time on this because:
 - It happens only if ohci1394 is unloaded while eth1394 is loaded.
   (That's not an unusual condition though.)
 - It happens only in -mm, and only because -mm contains the work-in-
   progress patches for class_device -> device transition.
I expect it to go away automatically once Greg is done with the
transition. It seems Greg is the one to do it :-), at least I'm not
available right now to lend a hand. There are older ieee1394 bugs in
mainline with bigger practical impact for me to work on. If there are
still issues once ieee1394 was converted away from class_device, I'm OK
with revisiting it.

(Besides, if anybody wants to become eth1394 maintainer, please step up.
MAINTAINERS currently lists eth1394 as in "Odd fixes" mode.)
-- 
Stefan Richter
-=====-=-==- =-== =--==
http://arcgraph.de/sr/
