Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275398AbRJATUw>; Mon, 1 Oct 2001 15:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275397AbRJATUm>; Mon, 1 Oct 2001 15:20:42 -0400
Received: from web10307.mail.yahoo.com ([216.136.130.85]:47120 "HELO
	web10307.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S275398AbRJATUg>; Mon, 1 Oct 2001 15:20:36 -0400
Message-ID: <20011001192104.17249.qmail@web10307.mail.yahoo.com>
Date: Mon, 1 Oct 2001 20:21:04 +0100 (BST)
From: "=?iso-8859-1?q?J.D.=20Hood?=" <jdthood@yahoo.co.uk>
Subject: Re: [PATCH] PnPBIOS 2.4.9-ac1[56] Vaio fix
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011001154136.K5531@come.alcove-fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Stelian Pop <stelian.pop@fr.alcove.com> wrote: 
> As I said, the DMI scan routines are still *after* the PnP 
> driver initialization. I didn't really tested it, but I suspect
> is_sony_vaio_laptop to be 0 when your routines are called.
> Something else must have changed in your code to enable my Vaio to
> boot...

I changed the initialization routine so that it would
use "boot" rather than "current" config values as much as 
possible.

However, if is_sony_vaio_laptop is 0 at pnpbios init
time then if you look in /proc/bus/pnp you'll see numerical
entries there.  Want to crash your machine?  Just read from
them.  (The numerically named entries in /proc/bus/pnp/boot 
should be okay to read and write, though.)

We need to know when is_sony_vaio_laptop so that we can
stop this from happening.  So either we put the dmi scan
earlier (which Alan says is in the works) or else we allow
the creation of the proc entries at init time but reject
read/write accesses after init time.  I'll make up a patch
that does the latter, but it would be nicest if the proc
entries were omitted altogether.

--
Thomas

____________________________________________________________
Do You Yahoo!?
Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
or your free @yahoo.ie address at http://mail.yahoo.ie
