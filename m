Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129100AbQKIAO7>; Wed, 8 Nov 2000 19:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129147AbQKIAOu>; Wed, 8 Nov 2000 19:14:50 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:45834 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129100AbQKIAOh>;
	Wed, 8 Nov 2000 19:14:37 -0500
Message-ID: <3A09EC3A.82324C57@mandrakesoft.com>
Date: Wed, 08 Nov 2000 19:13:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] media/radio [check_region() removal... ]
In-Reply-To: <Pine.LNX.4.21.0011090056470.22998-200000@tricky>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch looks generally ok.  Some of the whitespace/formatting changes are
questionable, I usually leave that up to the maintainer unless it is
very gratuitously opposite to CodingStyle.

Some of the driver messages ("foo version 1.0") are purposefully printed
-after-, not before, the device is probed and registered.  Your patch
gets this wrong in at least one place.

Finally, a word to you, Alan, and others doing request_region work:  it
is more informative to pass the device name (minor, etc.) into
request_region.  Ditto for request_irq.  Many (most, except net?)
drivers use board/chip name instead of registered interface name.  If
you can use the interface name for request_region or request_irq, use
it... it allows differentiation between multiple boards of the same
type.  That's especially when looking at ISA regions in /proc/ioports,
or interrupt counts in /proc/interrupts.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
