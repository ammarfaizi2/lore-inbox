Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbVHOUV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVHOUV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbVHOUV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:21:59 -0400
Received: from [85.8.12.41] ([85.8.12.41]:57234 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S964939AbVHOUV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:21:59 -0400
Message-ID: <4300F963.5040905@drzeus.cx>
Date: Mon, 15 Aug 2005 22:21:55 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-3 (X11/20050806)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Flash erase groups and filesystems
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you know how flash erase groups behave then skip a bit ;)

As you may or may not be aware, flash memory tends to be designed so
that only large groups of sectors can be erased at a time. For most
systems this is handled automatically by having the onboard controller
caching everyhing but the sector being overwritten. If you write a
single sector at a time (or if the controller is stupid) this will
result in the flash being erased several times because of writes in
sectors close by. The end result being that your flash is worn out faster.

--8<--- skip to here ----

To minimise the number of erases the MMC protocol supports pre-erasing
blocks before you actually write to them. Now what I'm unclear on is how
this will interact with filesystems and the assumptions they make.

If the controller gets a request to write 128 sectors and this fails
after 20 sectors, the remaining 108 sectors will still have lost their
data because of the pre-erase. Will this break assumptions made in the
VFS layer? I.e. does it assume that only the failed sector has unknown data?

I'm writing a patch that gives this functionality to the MMC layer and
since I'm no VFS expert I need some input into any side effects.

Rgds
Pierre
