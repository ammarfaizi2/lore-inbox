Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262906AbSJ1ImB>; Mon, 28 Oct 2002 03:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263188AbSJ1ImA>; Mon, 28 Oct 2002 03:42:00 -0500
Received: from daimi.au.dk ([130.225.16.1]:57501 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S262906AbSJ1ImA>;
	Mon, 28 Oct 2002 03:42:00 -0500
Message-ID: <3DBCF9C5.DF3FF28D@daimi.au.dk>
Date: Mon, 28 Oct 2002 09:48:05 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-17.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [CFT] kexec syscall for 2.5.43 (linux booting linux)
References: <m1k7kfzffk.fsf@frodo.biederman.org>
		<3DBCEB2E.BC3956FD@daimi.au.dk> <m1hef7j7j1.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> I believe it is inappropriate to assume the interrupt
> controller is going to be used by dos when it is shut down.

If Linux was booted by LILO or SYSLINUX, there will be no DOS
in memory. But the BIOS interrupt vector table and other data
structures are in the first physical memory page which is not
touched by Linux, so I'd expect the BIOS to be usable if we
can just leave the hardware in a usable state. Booting to DOS
from Linux might actually be possible.

OTOH if Linux was booted by LOADLIN, there will have been a
DOS in memory. DOS has changed interrupt vectors to point to
DOS own code in segment 0x70, but that code will be outside
the first physical page and will thus have been overwritten
by Linux. In this case neither DOS nor BIOS routines can be
used reliable. Any INT instruction can potentially crash,
this lead to problems with kmonte, does kexec have the same
problem?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
Don't do this at home kids: touch -- -rf
