Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVAKEfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVAKEfd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 23:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVAKEfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 23:35:13 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:38924 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262416AbVAKEc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 23:32:27 -0500
Date: Tue, 11 Jan 2005 05:32:20 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Do PS/2 ESDI users exist?
Message-ID: <20050111043220.GB2760@pclin040.win.tue.nl>
References: <20050108214036.GW14108@stusta.de> <20050108234337.GE6052@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108234337.GE6052@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: kweetal.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I mentioned that patch 2.3.13 killed the setup,
so that tp720_setup and ed_setup would not be called anymore.
Hand-specifying the geometry failed from then on.

Since nobody noticed, maybe nobody with compiled-in ps2esdi
needed to specify the geometry.

In 2.1.128 (Nov 1998) the driver was modularised, but that patch
contained a few typos so that the driver would not build as a module.
Several people - all without ps2 hardware - submitted a patch,
and the correction finally went into patch-2.6.0-test6 (Sep 2003).

All that time, no actual (potential) users complained.
So, maybe nobody tried to use it as a module.

Google shows that lots of people have CONFIG_BLK_DEV_PS2=m.
Why didn't they notice? Because that setting results (e.g. under 2.4) in
#undef  CONFIG_BLK_DEV_PS2
#define CONFIG_BLK_DEV_PS2_MODULE 1
in <linux/autoconf.h>, and ps2esdi.c is inside #ifdef CONFIG_BLK_DEV_PS2.

Have there ever existed ESDI users? Yes, using out-of-tree patches before
2.1.15, and in the 2.1 - 2.2 time frame. I seem to be unable to find traces
of later users - just a few people who try and fail.

I wonder whether ps2esdi should be removed.
Does the present driver work for someone?
Have there been users in this millennium? With 2.3 or later?

Andries
