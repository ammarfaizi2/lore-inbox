Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWI3OQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWI3OQK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 10:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWI3OQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 10:16:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:35315 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751012AbWI3OQJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 10:16:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 1/3] swsusp: Add ioctl for swap files support
Date: Sat, 30 Sep 2006 16:15:47 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200609290005.17616.rjw@sisk.pl> <20060928230339.GF26653@elf.ucw.cz> <200609290135.33683.rjw@sisk.pl>
In-Reply-To: <200609290135.33683.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609301615.47746.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Friday 29 September 2006 01:35 schrieb Rafael J. Wysocki:
> @@ -119,7 +119,18 @@ extern int snapshot_image_loaded(struct
>  #define SNAPSHOT_SET_SWAP_FILE         _IOW(SNAPSHOT_IOC_MAGIC, 10,
> unsigned int) #define
> SNAPSHOT_S2RAM                 _IO(SNAPSHOT_IOC_MAGIC, 11) #define
> SNAPSHOT_PMOPS                 _IOW(SNAPSHOT_IOC_MAGIC, 12, unsigned int)
> -#define SNAPSHOT_IOC_MAXNR     12
> +#define SNAPSHOT_SET_SWAP_AREA         _IOW(SNAPSHOT_IOC_MAGIC, 13, void *) 
> +#define SNAPSHOT_IOC_MAXNR     13

Your definition looks wrong, '_IOW(SNAPSHOT_IOC_MAGIC, 13, void *)' means
your ioctl passes a pointer to a 'void *'.

You probably mean 

#define SNAPSHOT_SET_SWAP_AREA _IOW(SNAPSHOT_IOC_MAGIC, 13, \
						struct resume_swap_area)

	Arnd <><
