Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314411AbSESNYN>; Sun, 19 May 2002 09:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314420AbSESNYM>; Sun, 19 May 2002 09:24:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:269 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314409AbSESNYL>; Sun, 19 May 2002 09:24:11 -0400
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
To: rui.sousa@laposte.net (Rui Sousa)
Date: Sun, 19 May 2002 14:43:06 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rusty@rustcorp.com.au (Rusty Russell),
        linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44.0205191444200.18395-100000@localhost.localdomain> from "Rui Sousa" at May 19, 2002 02:58:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179Qxm-0003nQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > __copy_to/from_user() --> the same as above, but can they actually return 
> > > anything other than 0? My assembler is no good and I'm not able to see if
> > 
> > They do the same things, but don't do any initial range checks that might
> > be done by access_ok before hand
> 
> On the emu10k1 driver we use access_ok(VERIFY_READ) once at the beginning
> of the write() routine to check we can access the user buffer. After that 
> we always use __copy_from_user() and we trust it not to fail. Is this 
> correct, or not?

This is correct

> Basically, where in copy_from_user() is it determined the function cannot
> copy the entire user buffer? Is it in access_ok() only or also in 
> __constant_copy_user_zeroing()?

Static once off checks are done in access_ok
Dynamic checks are doing in __copy_from_*

Which are which depends on the platform. On x86 for example access_ok
is basically a check for 0->0xBFFFFFFF range and no more
