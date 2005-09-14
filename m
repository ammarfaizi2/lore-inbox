Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbVINRXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbVINRXo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbVINRXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:23:44 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:41490 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1030290AbVINRXn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:23:43 -0400
Date: Wed, 14 Sep 2005 19:26:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Coywolf Qi Hunt <coywolf@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: kbuild-permanently-fix-kernel-configuration-include-mess.patch added to -mm tree
Message-ID: <20050914172613.GB7480@mars.ravnborg.org>
References: <200509140841.j8E8fG1w022954@shell0.pdx.osdl.net> <2cd57c900509140205572f19b7@mail.gmail.com> <20050914102016.B30672@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914102016.B30672@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That is a small price to pay, rather than having to continually maintain
> "does this file need config.h included" - which I think can conclusively
> be shown to be a total lost cause.  There are about 3450 configuration
> include errors in the kernel as of -git last night.
Depends on how you count...
If all .h files followed the rule - they should be selfcontained. In
other words they should all include what they need this is correct.

The correct figure is much less.
I did a check with defconfig for i386.
There are 7 .o files where config.h is not included - all are correct.
lib/errno.c, arch/ia386/boot/bootsect.S + a few more.
That was out of 983 .o files.

There will be no slowdown introducing -iinclude (or -imacros) keeping
these figures in mind.



find -name '.*.o.cmd' | xargs grep __KERNEL__ to find number of .o files
build.

added grep -l 'include/linux/config.h' to find .o files build and where
config-h was included. Then a simple diff..

	Sam
