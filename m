Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265635AbUABT43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 14:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUABT43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 14:56:29 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:64936 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265635AbUABT4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 14:56:25 -0500
Date: Fri, 2 Jan 2004 20:56:21 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Libor Vanek <libor@conet.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
Message-ID: <20040102195621.GB12905@wohnheim.fh-wedel.de>
References: <3FF56B1C.1040308@conet.cz> <20040102151206.GJ1718@actcom.co.il> <3FF59073.3060305@conet.cz> <20040102160020.A24026@infradead.org> <20040102163552.GD31489@wohnheim.fh-wedel.de> <3FF5A36A.5070501@conet.cz> <20040102180431.GB6577@wohnheim.fh-wedel.de> <3FF5BF68.8060303@conet.cz> <20040102191805.GA12905@wohnheim.fh-wedel.de> <3FF5C881.2080004@conet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FF5C881.2080004@conet.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 January 2004 20:37:37 +0100, Libor Vanek wrote:
>
> >If you take a snapshot on every change within your scope, it doesn't
> >really matter whether you do it before or after the change.  Before
> >change n is just after change n-1.  All you have to do is take another
> >snapshot before the first change, that is the special case.
> 
> But this special case in fact means to copy all the data, if wanted to do 
> it 100% working ;-) And I suggest that it wont' go through my exam ;)

Yes, it does.  Cannot comment on your exam, though.

> >Actually, with userspace notification in place, you could even get
> >this with just cvs.  Whenever a file is changed, commit.  cvs add on
> >creation, etc.  Yes, it sucks, but implementation simplicity has it's
> >own beauty and it would only take a few minutes. :)
> 
> I've heard about some fs from Microsoft which should have cvs-like 
> behaviour for all the time ("I want this file version from yesterday") - 
> but I haven't had any details (and I suppose performance hit must be big)

Not too big, actually.  The obvious implementation has to write data
twice (plus metadata, but that's minimal), so performance is ~50% of
normal.  With hard drives and a smarter implementation, you don't have
to worry about seek latency too much for the log, so performance is
usually better than 50%.  Basically, it hurts where you are good
enough anyway (large sequential writes) and goes unnoticed where
performance is bad (many small scattered writes).

The real problem is storage size.  Each write will *permanently*
reduce the filesystem size.  Maxtor and friends should happily sponsor
such development. :)

Seriously, such a thing is the perfect cure for "rm -rf foo /" and
similar famous mistakes and you can always just remove the oldest
backup data (preferrably after writing it to a tape).

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
