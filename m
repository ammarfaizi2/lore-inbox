Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266205AbUHBAFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266205AbUHBAFb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 20:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266207AbUHBAFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 20:05:31 -0400
Received: from zero.aec.at ([193.170.194.10]:54796 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266205AbUHBAFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 20:05:24 -0400
To: Andrea Arcangeli <andrea@cpushare.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: secure computing for 2.6.7
References: <2ejhQ-4lc-5@gated-at.bofh.it> <2fqhq-1RU-45@gated-at.bofh.it>
	<2olLt-4wI-5@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 02 Aug 2004 02:05:20 +0200
In-Reply-To: <2olLt-4wI-5@gated-at.bofh.it> (Andrea Arcangeli's message of
 "Sun, 01 Aug 2004 12:30:11 +0200")
Message-ID: <m3ekmq2ym7.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@cpushare.com> writes:

> +/*
> + * bump this sequence number after fixing any kernel security bug
> + * that could render insecure some userspace application. This
> + * way future versions of the userpace application will be able
> + * to reliably make sure to run on a secure kernel.
> + * I hope 31bit are enough... ;).
> + */
> +static int security_sequence;

I don't think a sequence number is a good idea. Consider a
vendor/third party kernel fixing a security bug, but mainline hasn't
taken the patch yet for some reason.

The vendor kernel could not safely increase this number, because it 
could conflict with some other security bug fixed in mainline at the 
same time. 

The end result would be that the kernel would be fixed, but 
the application has no way to tell.

Better may be a bitmap, but even there you still have an problem 
with allocating these bits. 

A safe solution would be a file in /proc that lists CAN idenitifiers of
fixed bugs or similar, but that may be quite some overhead to maintain
and parse.

-Andi

