Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129721AbQKLT2u>; Sun, 12 Nov 2000 14:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129105AbQKLT2l>; Sun, 12 Nov 2000 14:28:41 -0500
Received: from slc188.modem.xmission.com ([166.70.9.188]:5640 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129213AbQKLT2c>; Sun, 12 Nov 2000 14:28:32 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Tigran Aivazian <tigran@veritas.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <Pine.LNX.4.21.0011111644110.1036-100000@saturn.homenet> <m1ofzmcne5.fsf@frodo.biederman.org> <20001112122910.A2366@athlon.random> <m1k8a9badf.fsf@frodo.biederman.org> <20001112163705.A4933@athlon.random>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Nov 2000 12:20:19 -0700
In-Reply-To: Andrea Arcangeli's message of "Sun, 12 Nov 2000 16:37:05 +0100"
Message-ID: <m17l69atfw.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Sun, Nov 12, 2000 at 06:14:36AM -0700, Eric W. Biederman wrote:
> > x86-64 doesn't load the segment registers at all before use.
> 
> Yes, before switching to 64bit long mode we never do any data access. We do a
> stack access to clear eflags only while we still run in legacy mode with paging
> disabled and so we only rely on ss to be valid when the bootloader jumps at
> 0x100000 for executing the head.S code (and not anymore on the gdt_48 layout).

Actually it just occurred to me that this stack assess is buggy.  You haven't
set up a stack yet so.  Only the boot/compressed/head.S did and that location isn't
safe to use.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
