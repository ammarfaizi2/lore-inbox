Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130542AbQKLMVS>; Sun, 12 Nov 2000 07:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130589AbQKLMVJ>; Sun, 12 Nov 2000 07:21:09 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:32783 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130575AbQKLMUy>;
	Sun, 12 Nov 2000 07:20:54 -0500
Message-ID: <3A0E8B22.2A5CC132@mandrakesoft.com>
Date: Sun, 12 Nov 2000 07:20:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Hen, Shmulik" <shmulik.hen@intel.com>
CC: "'Olaf Titz'" <olaf@bigred.inka.de>, linux-kernel@vger.kernel.org,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: catch 22 - porting net driver from 2.2 to 2.4
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B2708D@hasmsx52.iil.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hen, Shmulik" wrote:
> the thing is I need to prevent Tx/Rx when a topology change is initiated
> from the ioctl (registering a virtual adapter is just one example), so they
> all share a single lock and I must use spin_lock_bh from the ioctl.

I do not think that they all need to shared a single lock.  And we don't
have your code, but spin_lock_bh may be an incorrect choice too.

Note that when topology changes, that is an operation which might take
more than a few milliseconds.  Therefore, your solution should do
something OTHER than spinning on a lock, while topology is changing.

dev->open and dev->do_ioctl are called with rtnl_lock already held.  You
can sleep in them.  Use that to your advantage...

-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
