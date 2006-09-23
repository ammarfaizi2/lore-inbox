Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWIWToJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWIWToJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 15:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWIWToI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 15:44:08 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:31707 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751505AbWIWToH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 15:44:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Sat, 23 Sep 2006 21:43:56 +0200
User-Agent: KMail/1.9.4
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com> <200609230218.36894.arnd@arndb.de> <8bd0f97a0609222350o3a9c8c36g468a6177ae7b1ea7@mail.gmail.com>
In-Reply-To: <8bd0f97a0609222350o3a9c8c36g468a6177ae7b1ea7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609232143.56996.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 September 2006 08:50, Mike Frysinger wrote:
> > There is not much point in trying to use the same numbers as an existing
> > architecture if that means that you have to leave holes like setup().
> > I don't know if you still have the choice of completely changing the
> > syscall numbers, but it would make it nicer in the future.
> 
> we do, fortunately, have this luxury ... so we can look forward to a
> nice cleaning of our syscall interface

Actually, I have one more general comment here. It would be really nice
if you could add those files that have nothing specific to blackfin moved
to include/asm-generic. That would probably include bug.h, current.h,
flat.h, hardirq.h, ioctls.h, {ipc,msg,sem,msg}buf.h, kmap_types.h, mman.h,
param.h, pci.h, poll.h, posix_types.h, scatterlist.h, semaphore.h,
socket.h, sockios.h, stat.h, termbits.h, termios.h, types.h, and unistd.h.

It doesn't really matter if you're the only user of the new files,
as long as they are generic enough to be used by every future port.
If the files are specific to nommu, 32bit or little-endian, then
they should probably have the respective name so the next person can
do it differently.

For unistd.h, it may be a good idea to leave space for a few syscall
numbers specific to architectures, so you could start the generic numbers
at 32 or so.

Of course nobody is forcing you do do that work, but the next person
trying to do will be really thankful.

	Arnd <><
