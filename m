Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbUKGVH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbUKGVH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 16:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUKGVH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 16:07:27 -0500
Received: from aun.it.uu.se ([130.238.12.36]:16514 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261442AbUKGVHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 16:07:21 -0500
Date: Sun, 7 Nov 2004 22:07:18 +0100 (MET)
Message-Id: <200411072107.iA7L7I0K004173@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ledva@centrum.cz, linux-kernel@vger.kernel.org
Subject: Re: bugy config cpu 386 selection CONFIG_X86_TSC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Nov 2004 20:07:45 +0100, <ledva@centrum.cz> wrote:
>I just had to compile kernel for zipslack for 386 because
>it's default has some problem with *WP
>I chose linux-2.4.27 tree.
...
>I did
>
>make mrproper && make menuconfig && \
>make dep && make bzImage
>
>selected 386 and several other options as you
>can see in .config which can be obtained from
>http://portal.promon.cz/ledvinka/i/tscerr/config
>
>All changes were done entirely via menuconfig.
>Result of booting up the kernel is:
>
>CPU: 386
>Kernel panic: Kernel compiled for Pentium+, requires TSC feature!
>In idle task  - not syncing

Your config still has CONFIG_X86_TSC set, hence the panic.

Do a 'make oldconfig' after switching CPU type from a
TSC-capable one to a TSC-less one in 2.4 kernels. There
is a known bug in the old configuration system where it
can leave derived options in an inconsistent state after
a single round of option changes. CONFIG_X86_TSC is the
prime example of this. Doing a second configuration round
allows the derived options to reach a fixpoint.
