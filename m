Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTHWXyq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 19:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263569AbTHWXyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 19:54:46 -0400
Received: from smtp-2.concepts.nl ([213.197.30.52]:2575 "EHLO
	smtp-2.concepts.nl") by vger.kernel.org with ESMTP id S263638AbTHWXyn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 19:54:43 -0400
Subject: [PATCH] 2.6.0-test4: small updates for zoran driver
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1061684001.4302.249.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 24 Aug 2003 02:13:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I've got 6 small patches to fix various small issues noticed by people
with the zoran driver that was accepted in 2.6.0-test3. These patches
should fix some of these issues. Most were noticed by Francois Romieu
(#1, #4-6). #2 was noticed by Linus (symbol conflict), #3 was already
announced by Gerd Knorr (v4l maitainer) some time ago, but I forgot to
actually apply the fix for that to my driver.

#1 fixes several memleaks in error cases when the setup of i2c client
drivers for video encoders/decoders fails. We forgot to free some memory
in various places.

#2 renames debug to zr_debug because debug is already defined somewhere
else.

#3 adds a release callback which frees the video_device struct. This is
needed to prevent freeing memoy before it's not in use anymore, as
described in http://lwn.net/Articles/36850/. Without this, the driver
will give a warning when loaded.

#4 adds pci_disable_device() to the card release function, we already
used pci_enable_device() in the card detection function.

#5 changes some funky coding style (a.k.a. indent artifact) to a
somewhat more conservative coding style.

#6 adds some newlines between variable declarations and function bodies.

1: http://213.197.11.65/ronald/patches/20030821_memleak_fixes.diff
2: http://213.197.11.65/ronald/patches/20030822_debug.diff
3: http://213.197.11.65/ronald/patches/20030821_vdf_release.diff
4: http://213.197.11.65/ronald/patches/20030823_disable_device.diff
5: http://213.197.11.65/ronald/patches/20030821_indenting.diff
6: http://213.197.11.65/ronald/patches/20030821_whitespace.diff

Please apply all of them.

On a related note, I'm not trying to be a pain in the ass by not
inlining patches, but Evolution doesn't seem to like me doing that, so
I'm kind of forced to do it differently. Is anyone else here using
Evolution to send in patches or is Evolution broken?

Thanks,

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

