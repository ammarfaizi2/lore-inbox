Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUBJKXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 05:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUBJKXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 05:23:04 -0500
Received: from asteroids.scarlet-internet.nl ([213.204.195.163]:4749 "EHLO
	asteroids.scarlet-internet.nl") by vger.kernel.org with ESMTP
	id S265805AbUBJKXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 05:23:01 -0500
Message-ID: <1076408579.4028b1036a8ae@webmail.dds.nl>
Date: Tue, 10 Feb 2004 11:22:59 +0100
From: wdebruij@dds.nl
To: linux-kernel@vger.kernel.org
Subject: missing vprintf in kernel.api. Interest in patch?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  while writing a new kernel module I needed vprintf behaviour to send
additional info to printk (e.g. __LINE__ and __FUNCTION__ preprocessor macros).
While the kernel API contains vsnprintf and vsprintf functions, it does not
contain a vprintf and since we have no access to the printk_buf structure it is
therefore impossible to directly write a formatted argument using a va_list to
the log. 

As a quick fix I wrote my own function using vsnprintf and printk, but this is
far from ideal when more people need such functionality.

Indeed, doing a quick grep on the (2.6.1) tree I noticed that I am not the only
one creating my own vprintf. In arch/um/kernel/tt/tracer.c, drivers/acpi/osl.c
and drivers/acpi/utilities/utdebug.c others have also written similar functions.
Not to mention all the DPRINTF, YYDPRINTF, etc. macros declared everywhere

Therefore my question is this: is there any interest in 

(1) a small patch that extracts the vsnprintf(printk_buf,...) from printk and
thus creates a vprintf function (trivial change, perhaps +5 lines of code).
and/or
(2) a kernel wide DPRINTK (or something) macro that adds the __FILE__,
__FUNCTION__ and __LINE__ macros to the output.
and/or
(3) an extension of 2 that also prints out clockcycles or timing statistics.

IMHO, everyone debugging and optimizing his code needs these features. It might
help clean up the codebase if everyone uses the same helper functions.
And since I already have such code laying around, sending in a patch is a
trivial task right now.

Please share your views, I don't want to create a patch if it'll be rejected
instantaneously because of some unspoken rule I haven't heard of.

cheers,

  Willem de Bruijn


