Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281094AbRKGXmN>; Wed, 7 Nov 2001 18:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281129AbRKGXmC>; Wed, 7 Nov 2001 18:42:02 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:54487 "EHLO
	e33.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281118AbRKGXl5>; Wed, 7 Nov 2001 18:41:57 -0500
Message-Id: <200111072340.fA7NeX409526@eng4.beaverton.ibm.com>
To: viro@math.psu.edu
cc: linux-kernel@vger.kernel.org, haveblue@us.ibm.com
Subject: removal of BKL from drivers ..
Date: Wed, 07 Nov 2001 15:40:33 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As an outgrowth of the locking document I did a few months ago
(http://lse.sourceforge.net/lockhier), Dave Hansen (haveblue) and I
have been looking at the use of the BKL in the release() functions of
drivers to see if it was really needed.  This isn't so much a
performance thing (although you can never really tell with the BKL :)
as a cleanliness thing.  It would appear that while some of those
drivers could stand some SMP locking, using the BKL in the release
function (only) doesn't provide it.  We've identified over 50 drivers
in which this can be removed, and are working on the patches (and
planning to contact the maintainers, per usual).  We'll select a small
number of them and apply safe SMP locking to them as examples for those
who like to cut 'n' paste their drivers for new devices.

The advantage of these changes will be to aid any developer trying to
determine how the BKL may or may not interact with their code. With
these patches, there will be 50+ less cases to consider.

At the time, it appears that most of these lock/unlock pairs were
created just in case they were needed, since there wasn't time to
inspect each driver or contact each maintainer.  Before we post these
patches, I thought I'd ask if in the time since Al Viro moved this out
here (July 2000) if anybody (especially him!) has found a *legitimate*
use of the BKL in the release() functions. (We have not found one.)

Rick

PS The patches, available in about a week or so barring complications,
   will also be posted to the above sourceforge website.
