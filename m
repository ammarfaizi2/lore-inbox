Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVHAG3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVHAG3c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 02:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVHAG3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 02:29:32 -0400
Received: from mail.suse.de ([195.135.220.2]:45206 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262343AbVHAG3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 02:29:31 -0400
Date: Mon, 1 Aug 2005 08:29:29 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Remove another fixed address constraint
Message-ID: <20050801062929.GA22102@suse.de>
References: <20050725061635.GD19817@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050725061635.GD19817@localhost.localdomain>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Jul 25, David Gibson wrote:

> Presently the LparMap, one of the structures the kernel shares with
> the legacy iSeries hypervisor has a fixed offset address in head.S.
> This patch changes this so the LparMap is a normally initialized
> structure, without fixed address.  This allows us to use macros to
> compute some of the values in the structure, which wasn't previously
> possible because the assembler always uses signed-% which gets the
> wrong answers for the computations in question.
> 
> Unfortunately, a gcc bug means that doing this requires another
> structure (hvReleaseData) to be initialized in asm instead of C, but
> on the whole the result is cleaner than before.

I think this change caused this compile error in rc4:

{standard input}: Assembler messages:
{standard input}:254: Error: value of 4000000000002080 too large for field of 4 bytes at 0000000000002108
make[1]: *** [arch/ppc64/kernel/LparData.o] Error 1

binutils-2.16.91.0.2
gcc-4.0.2_20050727

