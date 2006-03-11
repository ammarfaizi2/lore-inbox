Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWCKRHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWCKRHn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 12:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWCKRHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 12:07:43 -0500
Received: from mx5.mail.ru ([194.67.23.25]:58204 "EHLO mx5.mail.ru")
	by vger.kernel.org with ESMTP id S1751122AbWCKRHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 12:07:43 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Date: Sat, 11 Mar 2006 20:07:24 +0300
User-Agent: KMail/1.9.1
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Kay Sievers <kay.sievers@vrfy.org>,
       Arjan van de Ven <arjan@infradead.org>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603112007.25589.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> Arjan van de Ven wrote:
> > On Sat, 2006-03-11 at 17:05 +0100, Pierre Ossman wrote:
> >> Here is a patch for doing multi line modalias for PNP devices. This will
> >> break udev, so that needs to be updated first.
> >
> > how could this EVER be acceptable???
>
> Soon I would hope. The modalias attribute currently only supports one
> alias (i.e. one line). This isn't enough for PNP, so if we want to
> support that bus (which I assume we do) we need to extend the interface.
> udev could be updated and be backwards compatible, the kernel can not
> (excluding adding another interface to the same data). So this patch
> should lag the update to udev a bit (i.e. I'm not suggesting it be
> applied now).

actually it is not that much udev but modprobe issue and modprobe already 
supports multiple modules on command line (modprobe --all, module-init-tools 
3.3.2 that I have here). So assuming module aliases cannot have embedded 
spaces and udev properly space-splits command line (I have not checked, but 
it should be the case IIRC) udev simply has to use 'modprobe --all $modalias' 
to be compatible with this patch. It also remains backwards compatible with 
single-alias modalias.

Or do I miss something obvious here? I understand that alternative is to make 
every alias appear as separate device in sysfs, but I do not know PNP 
structure well enough to decide if it makes sense.

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEEwPNR6LMutpd94wRAhpTAJ9DQ6gj4SM+6Arxqxb3hM5PA01cHACgjZQs
yrONSgp3+TAo1p2qzR1tAHg=
=eq0n
-----END PGP SIGNATURE-----
