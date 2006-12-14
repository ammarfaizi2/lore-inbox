Return-Path: <linux-kernel-owner+w=401wt.eu-S1751078AbWLNRsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWLNRsc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWLNRsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:48:32 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:43703 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbWLNRsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:48:31 -0500
Message-ID: <45818E6E.8020505@s5r6.in-berlin.de>
Date: Thu, 14 Dec 2006 18:48:30 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: ieee1394 in 2.6.20-rc1 (was Re: Linux 2.6.20-rc1)
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612132146.41829.gene.heskett@verizon.net> <Pine.LNX.4.64.0612131918100.5718@woody.osdl.org> <200612140036.46083.gene.heskett@verizon.net>
In-Reply-To: <200612140036.46083.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Wednesday 13 December 2006 22:32, Linus Torvalds wrote:
>>On Wed, 13 Dec 2006, Gene Heskett wrote:
>>> Ok, one not so silly Q (IMO) from the resident old fart.  I saw,
>>> sometime in the past week, a relatively huge ieee1394 update go by. 
>>> And I have some issues with the present 2.6.19 version causeing
>>> segfaults and kino go-aways when trying to capture from my firewire
>>> movie camera.  Problems occur when trying to control the camera from
>>> kino.
>>>
>>> Is this patchset in this -rc1?  If it is, I'll see if I can get a
>>> build to work and check it out.

This time everything which was in linux1394-2.6.git before the post
2.6.19 merge window went into 2.6.20-rc1. However it wasn't much
substantial stuff; we didn't get much done during the past few months.
Here is my pull message: http://lkml.org/lkml/2006/12/07/323

You can patch the ieee1394 drivers in 2.6.{19,18,16.x} to nearly the
same level as in 2.6.20-rc1 (that is, minus changesets which only
address in-kernel API changes) by means of the patchkit v212 from
http://me.in-berlin.de/~s5r6/linux1394/merged/. However I'm 99.9% sure
that it won't fix the problems you got.

>>-rc1 does include a reasonably big firewire update, but I'm not sure how
>>it will affect your camera usage. In fact, the ieee1394 people seem to
>> be trying to deprecate the dv1394 stuff, in favour of just raw1394 and
>> user-mode libraries.

That's right.

>>I think you can tell Kino to use either the DV or the raw interface, but
>>I'm not sure. If you can, try either. The raw interface seems to be
>>horribly misdesigned (security problems), but is the one to use.

These security issues are partly inherent to the IEEE 1394 architecture,
if I may say so. Dan Dennedy has a patch as work in progress to improve
raw1394's security towards devices as far as possible (while still
allowing non-root users access to /dev/raw1394, unless the administrator
thinks otherwise).

The other issue is security of the local host against attacks from
malicious external devices or other PCs. Here the issue is with
OHCI-1394's physical DMA feature and the fact that the sbp2 driver needs
it enabled. I'm planning to implement filtered physical DMA as a simple
security improvement and, at some day in a /distant/ future, implement a
DMA mapping in sbp2 to work completely without physical DMA.

(Anyway, that's unrelated to Gene's issues.)
-- 
Stefan Richter
-=====-=-==- ==-- -===-
http://arcgraph.de/sr/
