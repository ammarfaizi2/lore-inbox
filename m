Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266682AbUGQLNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266682AbUGQLNJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 07:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUGQLNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 07:13:09 -0400
Received: from zero.aec.at ([193.170.194.10]:61450 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266682AbUGQLNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 07:13:07 -0400
To: Roland McGrath <roland@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 singlestep through sigreturn system call
References: <2imAA-4n7-49@gated-at.bofh.it> <2iosE-5Kb-17@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 17 Jul 2004 13:12:50 +0200
In-Reply-To: <2iosE-5Kb-17@gated-at.bofh.it> (Roland McGrath's message of
 "Fri, 16 Jul 2004 02:10:08 +0200")
Message-ID: <m3eknaj39p.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> writes:

>> Anyways, even if I applied your patch there would be still inconsistency
>> because there are several other system calls that use IRET. So I don't
>> see much advantage in adding a special case just for sigreturn.
>
> Now that I see that the difference is due to iret being used, I have a
> different solution that handles all cases.  The following patch replaces
> both my previous patch for x86-64 native behavior and my patch for x86-64's
> ia32 support.  This patch just directly clones Davide Libenzi's i386 code
> for x86-64 in both 64-bit and 32-bit cases.  With this, the behavior of
> single-stepping all system calls is consistent.  

Hmm, but now the behaviour for 32bit processes is different from the
native 32bit kernel, since 32bit didn't apply any patch so far AFAIK.

If you send me a patch that just changes the behaviour of 64bit 
IRET I would apply it.

-Andi

