Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTDIS3L (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 14:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263662AbTDIS3L (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 14:29:11 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:28164 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263661AbTDIS3K (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 14:29:10 -0400
Subject: Re: 64-bit kdev_t - just for playing
From: James Bottomley <James.Bottomley@steeleye.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 09 Apr 2003 13:40:36 -0500
Message-Id: <1049913637.1993.73.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let's try it with a real example:
> I have two onboard SCSI channels, the first one is for external
devices 
> and the second for internal devices.

There seems to be some confusion here.  As I understand it, you're
advocating a completely dynamic device space (both major and minor), but
the concrete examples you post come from devices that do dynamic minors
only.

Thanks to the work of Al Viro and others, the problem of dynamic majors
for block devices now lies predominantly in user space, but those
problems are still significant.

As far as SCSI goes, in the current 8/8 device scheme, we occupy 16
different majors for sd already, but this only gives us room for 256
discs and we had to compromise and only have 16 partitions on each (as
opposed to the 64 that IDE has).  Even if you expand this (as there are
patches to do), we get into trouble because we only have 256 sg nodes,
etc.

Expanding the size of the kernel dev_t will allow us to occupy only one
major,  for each SCSI device type, supply far more discs and still move
to a 64 partition model.

> I have to come back to the two questions I already asked earlier:
> 1. How do we want to manage devices in the future?

Well, it's a legitimate question to ask, but not one anyone is required
to answer.  The whole "taste" thing in the kernel is about making
correct decisions without necessarily seeing the ultimate end points. 
Enabling rather than dictating.  Nothing about an expanded kernel dev_t
precludes more dynamism in major number allocation.

However, there is already consideration of this issue, see for example:

http://www.linuxsymposium.org/2003/view_abstract.php?talk=94

If you have other contributions to make, I'm sure people will listen.

> 2. What compromises can we make for 2.6?

I think that's expand the kernel's device type but keep the current
static major/static or dynamic minor.  It seems to me, at this late
stage in the game, that this will cause the minimum disruption and
require the minimum of code changes, while still allowing us to satisfy
the enterprise device demands.  Pragmatically as well, we already have
the patches for this, we don't for dynamic majors.

James


