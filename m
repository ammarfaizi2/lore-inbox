Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266609AbUF3Jyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266609AbUF3Jyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 05:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266610AbUF3Jyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 05:54:45 -0400
Received: from zork.zork.net ([64.81.246.102]:64232 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S266609AbUF3Jyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 05:54:44 -0400
To: jan@talentex.demon.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: malloc overlap?
References: <E1BfbVk-000PFO-0W@anchor-post-32.mail.demon.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: jan@talentex.demon.co.uk, linux-kernel@vger.kernel.org
Date: Wed, 30 Jun 2004 10:54:42 +0100
In-Reply-To: <E1BfbVk-000PFO-0W@anchor-post-32.mail.demon.net>
	(jan@talentex.demon.co.uk's message of "Wed, 30 Jun 2004 10:36:12
	+0100")
Message-ID: <6ufz8dmkv1.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jan@talentex.demon.co.uk writes:

> I am developing a program that mallocs a struct, which contains a
> pointer to another struct, which gets malloced. Then I realloc the
> first buffer to be one element larger and assign something to an
> element in the second element - and this action overwrites part of the
> second level struct. After much tracing I am now sure that the buffers
> somehow have come to overlap. Is this a known error? I imagine that if
> the kernel had this kind of problem, it wouldn't run far, but surely
> memory allocation is handled in the kernel?

malloc is implemented in userspace, typically by the C library, which
uses lower-elvel mechanisms to obtain memory from the kernel.

How are you calling realloc?  It must be called thus:

    x = realloc(x, s);

since the block will have to be moved if there is no space after it
into which to expand.  Given that you allocated the block at x,
another block, and then expanded the block at x, I think this may be
what's happening.
