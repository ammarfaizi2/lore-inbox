Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUG1KR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUG1KR0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 06:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266869AbUG1KR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 06:17:26 -0400
Received: from zero.aec.at ([193.170.194.10]:19212 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266867AbUG1KRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 06:17:25 -0400
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
References: <2mN94-3MP-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 28 Jul 2004 12:16:40 +0200
In-Reply-To: <2mN94-3MP-9@gated-at.bofh.it> (David S. Miller's message of
 "Wed, 28 Jul 2004 05:20:06 +0200")
Message-ID: <m3acxkighj.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> 1) From inode to "struct kstat"
> 2) From "struct kstat" to "struct stat{,64}" on local kernel stack
> 3) From local kernel stack to userspace

[...]

> I was about to make sparc64 specific copies of all the stat
> system calls in order to optimize this properly.  But that
> makes little sense, instead I think fs/stat.c should call
> upon arch-specific stat{,64} structure fillin routines that
> can do the magic, given a kstat struct.

I think wrappers are preferable to callbacks.  Basically step (2) 
should be eliminated. 

Most architectures can use a generic wrapper for that, together
with a standard macro that clears all the padding in user space.

-Andi


