Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbTEMWzd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263657AbTEMWzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:55:33 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:41890 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263654AbTEMWzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:55:32 -0400
Date: Wed, 14 May 2003 00:08:36 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: framebuffer initialisation.
Message-ID: <20030513230836.GA15158@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	James Simmons <jsimmons@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,
 The 2.5 agpgart code broke the i810fb a while back.

The reason behind this, is that previously (i.e. 2.4) agp_init()
would call the chipset specific backend init routines.
In 2.5, that stuff got pushed out into seperate modules,
so now i810fb does a (superflous) agp_init() which just
printk's the agpgart banner, and then calls the intel_agp_init()
function directly.

This *should* work, but doesn't.

The agpgart code *absolutely must* be set up before the framebuffer
code. Previously this was going to be solved with link order shuffling,
however that won't work, as the drivers/video stuff is initialised
from drivers/char/mem.c (Really non-intuitive place to hide fb init IMO)
mem.c gets linked before agp/ so we lose there.

Hence the explicit init in i810fb. I've tried to untangle this and
figure out why that isn't working, at a complete loss.
(The lack of hardware to test this on also doesn't help).

Any ideas ?

		Dave

