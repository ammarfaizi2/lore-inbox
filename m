Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTELPw5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTELPw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:52:57 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:65182 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262251AbTELPwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:52:55 -0400
Message-ID: <3EBFC9A4.7020708@pacbell.net>
Date: Mon, 12 May 2003 09:19:48 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Patch for usb-ohci in 2.4 needs review & testing
References: <20030510004012.A26322@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete,

> The attached patch appears to fix a bug which was really making
> my life difficult: dd if=/dev/scd0 produces corrupted ISOs when
> reading off a USB CD-ROM on a box with no less than 2 P4 CPUs,
> HyperThreading and ServerWorks chipset. However, I'm not
> completely sure that I didn't break something.

Did the "ohci-hcd" backport give the same problem?
Or did you not try that?

That 2.5 code has had a lot more attention paid to it
with respect to locking and similar less-common problems.
Personally I'd rather see that version get the attention,
so both 2.4 and 2.5 get the benefits, although I can also
understand wanting changes that seem more incremental.


>  - The whole idea of checking jiffy-sized timeouts from an interrupt
>    is revolting, but I am wary of unknown here, so I didn't kill it.
>    If anyone knows how that abomination came to life, I'll be glad
>    to know too.

It shouldn't actually be alive ... never enabled,
because never debugged (and submitted by accident).
Safe IMO to remove completely.

In fact the last time the issue of HCD-enforced
timeouts came up, nobody had anything positive
to say about it.  No portable driver has ever
been able to rely on it.  What's been lacking is
the will to rip all such code out; in 2.5 only
"uhci-hcd" has any such code left.

- Dave

