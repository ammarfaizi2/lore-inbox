Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423011AbWJYFqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423011AbWJYFqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 01:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423013AbWJYFqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 01:46:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:3549 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1423011AbWJYFqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 01:46:12 -0400
Subject: What about make mergeconfig ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 15:46:04 +1000
Message-Id: <1161755164.22582.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks !

I'm not good enough at make and friends to do that myself without
spending a lot more time than I have at hand, but I figured it might be
something doable in a blink for whoever knows Kconfig guts :)

What about something like:

make mergeconfig <path_to_file>

That would merge all entries in the specified file with the
current .config. By mergeing, that basically means that rule:

N + N = N
m + N = m
Y + N = Y
m + Y = Y

(that is, we basically take for each entry max(.config, merge file)

The idea here is that on archs like powerpc, we have the ability to
build kernels that can boot several platforms. However, the defconfigs
we ship (g5_defconfig, pseries_defconfig, maple_defconfig, cell... ) are
tailored for one platform.

Now, if (for testing typically) I want to build a kernel that boots (and
has all the necessary drivers) for both a g5 and a cell, I need to start
from one of the defconfigs (the g5 one) and basically add in manually
all the bits necessary from the other one (the cell one).

Thus it might be useful to have a mecanism to automate that...

Thanks in advance for whichever guru wants to have a look at this :)

Cheers,
Ben.

