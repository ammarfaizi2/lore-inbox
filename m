Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284418AbRLEOTD>; Wed, 5 Dec 2001 09:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284419AbRLEOSo>; Wed, 5 Dec 2001 09:18:44 -0500
Received: from mail207.mail.bellsouth.net ([205.152.58.147]:24549 "EHLO
	imf07bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S284418AbRLEOSl>; Wed, 5 Dec 2001 09:18:41 -0500
Message-ID: <3C0E2CBA.57412C69@mandrakesoft.com>
Date: Wed, 05 Dec 2001 09:18:34 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Lammerts <eric@lammerts.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        Josh McKinney <forming@home.com>, linux-kernel@vger.kernel.org
Subject: Re: Fwd: binutils in debian unstable is broken.
In-Reply-To: <Pine.LNX.4.43.0112051424560.1157-100000@ally.lammerts.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Lammerts wrote:
> change the drivers like this:
> 
> #ifdef DEVEXIT_LINKED
>      remove:         firestream_remove_one,
> #endif
> 
> to this:
> 
>      remove:         DEVEXIT_FUNC(firestream_remove_one),

The overall situation is not great, but I think I prefer this, or
something like this, to the ifdef.

I'm tempted to say we should add a per-driver function that calls BUG()
instead of a generic function which calls panic(), though.  That will be
a bit more informative to users.  For the case where the real
xxx_remove_one is dropped, it is a kernel bug if that code is -ever-
called...

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

