Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTICLIX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 07:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbTICLIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 07:08:23 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:3533 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261899AbTICLIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 07:08:22 -0400
Date: Wed, 3 Sep 2003 13:08:08 +0200 (MEST)
From: peter_daum@t-online.de (Peter Daum)
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.22 with CONFIG_M686: networking broken
Message-ID: <Pine.LNX.4.30.0309031227100.10173-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Seen: false
X-ID: b7brrTZrYeE8DE0iq0Rqz9vkIbl7ALt3-BIas5GJqwn3gOzyBeuToM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems, like kernel version 2.4.22 introduced some weird bug,
that causes all kinds of network malfunctions, when the kernel is
compiled with "CONFIG_M686".

I am sorry, that I can't come up with a clearer error
description, but the whole issue is pretty mysterious: there is
no actual error occurring, but some networking functionality is so
slow that it's for all practical purposes useless. The best test
cases I could find are:

- getting a file via ftp (e.g. wget ftp://...): Data rate over a
  normally fast network connection is ~ 200 bytes /second, the
  connection soon dies with a timeout

- writing to a SMB share (provided, that samba is running on the
  machine) is awfully slow and eventually aborted (Windows
  complains about "network congestion")
  reading via SMB works as usual ...

I upgraded the kernel on a bunch of machines - on most of them, I
had to immediately go back to the previous kernel because there
were obvious problems; some machines, however, worked perfectly
normal with the new kernel.

I tried lots of different options until I eventually found out,
that the single setting that makes all the difference is the
processor type: Independently of any other settings, all kernels
with "CONFIG_M686" exhibit these problems; when I change this to
"CONFIG_MPENTIUM4" and recompile, everything seems to work.

(By the way: the affected machines have "Pentium Pro" or "Pentium
II" processors - is it safe to run a kernel compiled for "Pentium
IV" on such boxes?)

Regards,
                 Peter Daum

