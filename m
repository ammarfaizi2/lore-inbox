Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbTEHX1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 19:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbTEHX1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 19:27:22 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:20361 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262301AbTEHX1U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 19:27:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pavel Machek <pavel@ucw.cz>, "David S. Miller" <davem@redhat.com>
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Date: Fri, 9 May 2003 01:35:39 +0200
User-Agent: KMail/1.5.1
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
References: <20030507152856.GF412@elf.ucw.cz> <20030508.134300.122085520.davem@redhat.com> <20030508230337.GA139@elf.ucw.cz>
In-Reply-To: <20030508230337.GA139@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="euc-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305090135.39944.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 May 2003 01:03, Pavel Machek wrote:

> > Suggest something sane like defining a macro such as
> > "compat_task(tsk)" that can be tested by various bits of
> > code.
>
> That makes more sense. Unfortunately, that means that case "okay, it
> is compatible" can not be told from "we did not bother to check
> compat_task()". :-(. Nor do I see a transition phase.

You still need to list them as COMPATIBLE_IOCTL() or call
register_ioctl32_conversion(IOCTLNO, 0) when the ioctl has been
made compatible. Unless we are sure that every single ioctl
has been made compatible (probably never), the default must
be to call sys_ioctl from compat_sys_ioctl only if the number
is explicitly listed. This should solve both problems you
mentioned.

One minor remaining problem is that if multiple files contain
handlers for the same ioctl number, they have to be converted
at the same time because the number can not both be compatible
and incompatible at the same time.

	Arnd <><
