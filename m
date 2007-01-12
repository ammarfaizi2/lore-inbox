Return-Path: <linux-kernel-owner+w=401wt.eu-S1750887AbXALMPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbXALMPO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 07:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbXALMPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 07:15:13 -0500
Received: from luna.alliedvisiontec.com ([213.203.238.80]:49836 "EHLO
	luna.alliedvisiontec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbXALMPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 07:15:11 -0500
X-Greylist: delayed 1986 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 07:15:11 EST
Subject: ieee1394 feature needed: overwrite SPLIT_TIMEOUT from userspace
From: Philipp Beyer <philipp.beyer@alliedvisiontec.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Jan 2007 12:42:37 +0100
Message-Id: <1168602157.5074.4.camel@ahr-pbe-lx.avtnet.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm investigating an unwanted behaviour of our firewire devices in 
connection with the ieee1394 kernel module.

The problem is caused by a non standard-conform behaviour of our
devices. Anyway, changes on the device-side dont seem to be the
best solution, so I'm looking for a workaround in terms of a
kernel patch.

The problem:
Our devices exceed the SPLIT_TIMEOUT for write requests in some
situations, where write accesses to the devices flash memory are 
triggered. The SPLIT_TIMEOUT could be adjusted as it's part of the 
CSR layout, but the longest interval possible is 8 seconds. We need
a substantial longer interval to assure failure-free operation.
(the maximum timeout needed may be around 120 seconds)

The presumed solution:
These long timeouts are only needed in a few rare situations like
writing user presets to flash or firmware updates. As far as I've
examined the kernel code it would be the best thing to have a
function (ioctl?) accessible from userspace that overwrites the
stored SPLIT_TIMEOUT for a certain connected device. This way
there should not be any interferences in case of normal operation.
Until (rare) write accesses to the flash memory are performed, a
reasonable short timeout could be used.

Since I don't have any real experience in kernel hacking yet,
this should be interpreted as a feature request at first:
If the described feature is easy to implement I would appreciate
if someone could do this.

Otherwise I'm confident that I'm able to write a patch on my own.
In this case the critical part would be to meet the standards
of the kernel community, since we would like to have the patch
included in the mainline.

Therefore I'm also interested in any kind of advices about how
to realize an appropriate patch.

Thanks,

Philipp Beyer

Software Development
Allied Vision Technologies

