Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283757AbRLISt7>; Sun, 9 Dec 2001 13:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283761AbRLIStt>; Sun, 9 Dec 2001 13:49:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23091 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S283757AbRLIStd>; Sun, 9 Dec 2001 13:49:33 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: torvalds@transmeta.com, marcelo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux/i386 boot protocol version 2.03
In-Reply-To: <200112090922.BAA11252@tazenda.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Dec 2001 11:29:33 -0700
In-Reply-To: <200112090922.BAA11252@tazenda.transmeta.com>
Message-ID: <m17krww8ky.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> The following patch is a fairly small and fully backwards compatible
> change to the i386 boot protocol.  It makes the maximum legal initrd
> address explicitly available to the boot loader, so it doesn't have to
> guess.  To make matters worse, the current documentation specifies
> 0x3C000000 as the top address (exclusive), but the real address is
> 0x38000000.
> 
> This patch:
> 
> a) Bumps the boot protocol version number to 2.03;
> b) Adds a field to the boot header which contains the maximum legal
>    initrd address;
> c) Slightly reorganizes a couple of macros to make (b) possible;
> d) Documents this change and the actual behaviour for previous
>    protocol versions.

This looks reasonable. 

A couple of notes:
1) The minimum safe ramdisk address is 8MB (since 2.4.10).  On low
   mem machines you can get away with placing a ramdisk lower.  But we
   don't do any checking in our initial 8MB memory map.
2) If we use units of kilobytes instead of bytes for this we don't
   loose any precision and gain the ability to put a ramdisk in high
   memory without bumping the protocol version.
3) If we are going to export the maximum address we should also export
   the minimum address.

Eric

