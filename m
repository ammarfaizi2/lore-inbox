Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTIYSV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbTIYSVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:21:30 -0400
Received: from adsl-67-122-122-226.dsl.pltn13.pacbell.net ([67.122.122.226]:56872
	"EHLO siamese.engr.3ware.com") by vger.kernel.org with ESMTP
	id S261757AbTIYSTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:19:32 -0400
Message-ID: <A1964EDB64C8094DA12D2271C04B8126F8C68B@tabby>
From: Adam Radford <aradford@3WARE.com>
To: "'Nick Piggin'" <piggin@cyberone.com.au>,
       Aaron Lehmann <aaronl@vitelus.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: RE: Complete I/O starvation with 3ware raid on 2.6
Date: Thu, 25 Sep 2003 11:19:20 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should set CONFIG_3W_XXXX_CMD_PER_LUN in your .config to 16 or 32.

-Adam

-----Original Message-----
From: Nick Piggin [mailto:piggin@cyberone.com.au]
Sent: Thursday, September 25, 2003 3:29 AM
To: Aaron Lehmann
Cc: Andrew Morton; linux-kernel@vger.kernel.org
Subject: Re: Complete I/O starvation with 3ware raid on 2.6




Aaron Lehmann wrote:

>On Thu, Sep 25, 2003 at 07:13:32PM +1000, Nick Piggin wrote:
>
>>But the load average will be 11 because there are processes stuck in the
>>kernel somewhere in D state. Have a look for them. They might be things
>>like pdflush, kswapd, scsi_*, etc.
>>
>
>They're pdflush and kjournald. I don't have sysrq support compiled in
>at the moment.
>

OK, it would be good if you could get a couple of sysrq T snapshots then
and post them to the list.

>
>I've noticed the problem does not occur when the raid can absorb data
>faster than the other drive can throw data at it. My naive mind is
>pretty sure that this is just an issue of way too much being queued
>

Although your system (usr, lib, bin etc) is on the IDE disk, right?
And that is only doing reads?

How does your system behave if you are doing just the read side (ie.
going to /dev/null), or just the write side (coming from /dev/zero).

>
>for writing. If someone could tell me how to control this parameter,
>I'd definately give it a try [tomorrow]. All I've found on my own is
>#define TW_Q_LENGTH 256 in 3w-xxxx.h and am not sure if this is the
>right thing to change or safe to change.
>

That looks like it, try it at 4.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
