Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbUCRBdY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 20:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbUCRBdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 20:33:24 -0500
Received: from zero.aec.at ([193.170.194.10]:23047 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262278AbUCRBdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 20:33:21 -0500
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-raid@vger.kernel.org, justin_gibbs@adaptec.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Enhanced" MD code avaible for review
References: <1AOTW-4Vx-7@gated-at.bofh.it> <1AOTW-4Vx-5@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 18 Mar 2004 02:33:17 +0100
In-Reply-To: <1AOTW-4Vx-5@gated-at.bofh.it> (Jeff Garzik's message of "Wed,
 17 Mar 2004 20:30:12 +0100")
Message-ID: <m3wu5jey76.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:
>
> ioctl's are a pain for 32->64-bit translation layers.  Using a
> read/write interface allows one to create an interface that requires
> no translation layer -- a big deal for AMD64 and IA32e processors
> moving forward -- and it also gives one a lot more control over the
> interface.

Sorry, Jeff, but that's just not true. While ioctls need an additional
entry in the conversion table, they can at least easily get an
translation handler if needed. When they are correctly designed you
just need a single line to enable pass through the emulation.
If you don't want to add that line to the generic compat_ioctl.h
file you can also do it in your driver.

read/write has the big disadvantage that if someone gets the emulation
wrong (and that happens regularly) it is near impossible to add an 
emulation handler then, because there is no good way to hook
into the read/write paths.

There may be valid reasons to go for read/write, but 32bit emulation
is not one of them. In fact from the emulation perspective read/write
should be avoided.

-Andi

