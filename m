Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275964AbRJBIfq>; Tue, 2 Oct 2001 04:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275963AbRJBIfg>; Tue, 2 Oct 2001 04:35:36 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:59398 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S275862AbRJBIfS>;
	Tue, 2 Oct 2001 04:35:18 -0400
Date: Tue, 2 Oct 2001 10:35:39 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: "J.D. Hood" <jdthood@yahoo.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnPBIOS 2.4.9-ac1[56] Vaio fix
Message-ID: <20011002103539.D25153@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20011001154136.K5531@come.alcove-fr> <20011001192104.17249.qmail@web10307.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011001192104.17249.qmail@web10307.mail.yahoo.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2001 at 08:21:04PM +0100, J.D. Hood wrote:

> However, if is_sony_vaio_laptop is 0 at pnpbios init
> time then if you look in /proc/bus/pnp you'll see numerical
> entries there.  

Yes:
# cd /proc/bus/pnp/
# ls
00  01  02  03  04  05  06  07  08  09  0b  0c  0d  0e  boot  devices
# ls boot
00  01  02  03  04  05  06  07  08  09  0b  0c  0d  0e

> Want to crash your machine?  Just read from
> them.  (The numerically named entries in /proc/bus/pnp/boot 
> should be okay to read and write, though.)

It doesn't crash. I did a "cat /proc/bus/pnp/0* > /dev/null" 
and the laptop is still alive.

> We need to know when is_sony_vaio_laptop so that we can
> stop this from happening.  

See above.

> So either we put the dmi scan
> earlier (which Alan says is in the works) 

This is the solution, as Alan said DMI idents will be needed for
some other boards (GX ?). 

Alan: are you already working on this or you're waiting for a
patch ?

> or else we allow
> the creation of the proc entries at init time but reject
> read/write accesses after init time.  I'll make up a patch
> that does the latter, but it would be nicest if the proc
> entries were omitted altogether.

If we cannot read nor write them, there is no point in showing
them... (we already have the devices file to show the list).

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
