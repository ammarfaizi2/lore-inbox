Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264906AbUEVIDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264906AbUEVIDY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 04:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264908AbUEVIDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 04:03:24 -0400
Received: from zero.aec.at ([193.170.194.10]:4869 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264906AbUEVIDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 04:03:19 -0400
To: "Spinka, Kristofer" <kspinka@style.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unserializing ioctl() system calls
References: <1YuKj-2FZ-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 22 May 2004 10:03:15 +0200
In-Reply-To: <1YuKj-2FZ-9@gated-at.bofh.it> (Kristofer Spinka's message of
 "Sat, 22 May 2004 04:50:07 +0200")
Message-ID: <m3n040q470.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Spinka, Kristofer" <kspinka@style.net> writes:

> I noticed that even in the 2.6.6 code, callers to ioctl system call
> (sys_ioctl in fs/ioctl.c) are serialized with {lock,unlock}_kernel().
>
> I realize that many kernel modules, and POSIX for that matter, may not
> be ready to make this more concurrent.

POSIX doesn't care how the kernel implements locking.

> I propose adding a flag to indicate that the underlying module would
> like to support its own concurrency management, and thus we avoid
> grabbing the BKL around the f_op->ioctl call.

Better would be probably a unlocked_ioctl() entry point in f_op. Should
be pretty easy to implement.

There is also the additional issue that on 64bit systems with 32bit
userland the ioctl emulation currently relies on the BKL.

-Andi

