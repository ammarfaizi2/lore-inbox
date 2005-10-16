Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVJPHQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVJPHQt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 03:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVJPHQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 03:16:49 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60318
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751153AbVJPHQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 03:16:49 -0400
Date: Sun, 16 Oct 2005 00:16:49 -0700 (PDT)
Message-Id: <20051016.001649.94729039.davem@davemloft.net>
To: viro@ftp.linux.org.uk
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] highest_possible_processor_id() has to be a macro
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051015235112.GA7992@ftp.linux.org.uk>
References: <20051015235112.GA7992@ftp.linux.org.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Sun, 16 Oct 2005 00:51:12 +0100

> 	... otherwise, things like alpha and sparc64 break and break
> badly.  They define cpu_possible_map to something else in smp.h
> *AFTER* having included cpumask.h.

So ugly...

But, it's the best fix for now.

Longer term we might want to make an asm/cpumask.h that can
help allow the platforms to cleanly say "well, mask X is
equivalent to Y, so only instantiate X and define Y to X"
which is all that these two platforms are trying to accomplish.

If you don't support cpu hotplug, present == possible afterall.
