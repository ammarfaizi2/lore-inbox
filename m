Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTICBtM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 21:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264013AbTICBtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 21:49:12 -0400
Received: from codepoet.org ([166.70.99.138]:40675 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S261152AbTICBtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 21:49:07 -0400
Date: Tue, 2 Sep 2003 19:49:09 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel header separation
Message-ID: <20030903014908.GB1601@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 02, 2003 at 08:16:14PM +0100, Matthew Wilcox wrote:
> 
> In a continuing series of "Things we should have done 5 years ago,
> do they really need to be done before the release of 2.6.0", here's a
> prototype of splitting the kernel headers into stuff we want userspace
> to see and stuff we don't.
> 
> The basic principle is to put user headers in usr/include/linux and
> usr/include/asm-$(ARCH).  Kernel headers may then include them as
> <user/foo.h> and <user-asm/foo.h>
> 
> This patch implents the 4 lines of Makefile magic necessary and converts
> cdrom.h to use this split.  Note that we can convert headers as slowly as
> we care to with this scheme.

Wohoo!!  Great stuff.  I hope this effort continues....

> RCS file: usr/include/linux/cdrom.h
> diff -N usr/include/linux/cdrom.h
> --- /dev/null	1 Jan 1970 00:00:00 -0000
> +++ usr/include/linux/cdrom.h	2 Sep 2003 19:07:48 -0000
> @@ -0,0 +1,719 @@
> +/*
> + * -- <linux/cdrom.h>
> + * General header file for linux CD-ROM drivers 
> + * Copyright (C) 1992         David Giller, rafetmad@oxy.edu
> + *               1994, 1995   Eberhard Moenkeberg, emoenke@gwdg.de
> + *               1996         David van Leeuwen, david@tm.tno.nl
> + *               1997, 1998   Erik Andersen, andersee@debian.org
> + *               1998-2000    Jens Axboe, axboe@suse.de
> + */
> + 
> +#ifndef	_LUSER_CDROM_H
> +#define	_LUSER_CDROM_H
> +
> +#include <linux/types.h>

Header files intended for use by users should probably drop
linux/types.h just include <stdint.h>,,,  Then convert the 
types over to ISO C99 types.

s/__u8/uint8_t/g
s/__u16/uint16_t/g
s/__u32/uint32_t/g
s/__u64/uint64_t/g

s/__s8/int8_t/g
s/__s16/int16_t/g
s/__s32/int32_t/g
s/__s64/int64_t/g

What do you think?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
