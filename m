Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTLQGHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 01:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTLQGHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 01:07:47 -0500
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:36370 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S263447AbTLQGHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 01:07:46 -0500
Subject: [Answer] Re: Linux 2.4.24-pre1: Instant reboot
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Dick Johnson <root@chaos.analogic.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20031216223833.GC12564@merlin.emma.line.org>
References: <3FDF63A2.9090205@enterprise.bidmc.harvard.edu> 
	<20031216223833.GC12564@merlin.emma.line.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Dec 2003 01:07:21 -0500
Message-Id: <1071641243.5423.27.camel@ktkhome>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Short answer to my previous post on this subject:

    CONFIG_EDD=y + Athlon + VIA KT266A = triple fault on boot.

Longer answer:

Dick Johnson asked,
> What CPU did you compile it for?

Compiled 2.4.24-pre1 for Athlon/K7.  I also tried it with generic i386,
which made no difference.

Matthias Andree wrote:
> I've seen this, too, with XFS=y and OOM_KILLER=n,

If I didn't have 2 hours sleep, I would have hacked rc.sysinit to
auto-compile my linux kernel with a binary search looking for the
culprit, iterating if the BIOS rebooted an old kernel; but I was too
tired today for scriping foo.  :-)  So I did it the old fashioned way.

Turns out, after about a dozen compile/reboot loops, I narrowed it down
repeatably to the "x86 BIOS Enhanced Disk Drive support" (CONFIG_EDD)
option.  I can turn off just about every .config option, turn that one
on, and the kernel triple faults upon boot.  This is the first time that
a 2.4.x kernel has ever triple faulted on boot on my system.  As
mentioned above, CPU choice makes no difference.

Marcelo:  Perhaps have the author of whatever patch interacts with
CONFIG_EDD work a bit more on getting the patch right for various
platforms.  The (EXPERIMENTAL) feature worked just fine for me on
2.4.22...24.2.23, but the current -pre1 bombs for athlon/via_kt266a.

Kris

