Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSDQOzA>; Wed, 17 Apr 2002 10:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314103AbSDQOy7>; Wed, 17 Apr 2002 10:54:59 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:22795 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S314101AbSDQOy6>; Wed, 17 Apr 2002 10:54:58 -0400
Message-Id: <200204171454.g3HEsB904317@aslan.scsiguy.com>
To: Andrey Slepuhin <pooh@msu.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx driver v6.2.5 freezes the kernel 
In-Reply-To: Your message of "Wed, 17 Apr 2002 15:15:15 +0400."
             <20020417111515.GE7342@glade.nmd.msu.ru> 
Date: Wed, 17 Apr 2002 08:54:11 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>All other changes were successfully merged without any problems.
>BTW, version 6.2.6 of the driver from 2.4.19-pre7 freezes the system too.

What motherboard is this again?  Perhaps your PCI bus is running just
a hair bit faster than 66MHz?  A similar issue was discovered with the
U320 controllers running at 133MHz PCI-X where some amount of delay is
required prior to accessing chip registers again after setting
CHIPRST.

The code was flipped so that the delay was acurate.  In PCI, you
are only guaranteed that the write has been flushed all the way to the
device by performing a read to that device.  I guess we'll just have to
hope that our write transaction isn't stalled.

I'll make a 6.2.7 <sigh> drop later today.

--
Justin
