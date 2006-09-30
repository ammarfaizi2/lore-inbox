Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751946AbWI3UhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbWI3UhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbWI3UhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:37:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:33014 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751946AbWI3UhY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:37:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 1/3] swsusp: Add ioctl for swap files support
Date: Sat, 30 Sep 2006 22:37:21 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200609290005.17616.rjw@sisk.pl> <200609301615.47746.arnd@arndb.de> <200609302158.03692.rjw@sisk.pl>
In-Reply-To: <200609302158.03692.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609302237.22086.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Saturday 30 September 2006 21:58 schrieb Rafael J. Wysocki:
> > Your definition looks wrong, '_IOW(SNAPSHOT_IOC_MAGIC, 13, void *)' means
> > your ioctl passes a pointer to a 'void *'.
> >
> > You probably mean
> >
> > #define SNAPSHOT_SET_SWAP_AREA _IOW(SNAPSHOT_IOC_MAGIC, 13, \
> >                                               struct resume_swap_area)
>
> No.  I mean the ioctl passes a pointer, the size of which is sizeof(void *).

That's a very bad thing to do. It means that the ioctl number is different
between 32 and 64 bit and you need to write a conversion handler that
first reads your pointer and then then writes the real data.

Also, it needs to be at least _IOR() in the case you're describing,
because the pointer is read, not written (I hope).

	Arnd <><
