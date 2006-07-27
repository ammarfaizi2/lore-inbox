Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWG0Fpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWG0Fpx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 01:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbWG0Fpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 01:45:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:52100 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751798AbWG0Fpv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 01:45:51 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Petr Vandrovec <petr@vandrovec.name>
Subject: Re: [PATCH] ncpfs: move ioctl32 code to fs/ncpfs/ioctl.c
Date: Thu, 27 Jul 2006 07:45:41 +0200
User-Agent: KMail/1.9.1
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20060710085142.GB9440@osiris.boeblingen.de.ibm.com> <200607270456.48014.arnd.bergmann@de.ibm.com> <44C83480.6000102@vandrovec.name>
In-Reply-To: <44C83480.6000102@vandrovec.name>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607270745.42622.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 July 2006 05:35, Petr Vandrovec wrote:
> Yes, tomorrow (on amd64).

No need to hurry, I was sitting on my patch for more than a year now ;-)

> Although I understand that this code is correct, what about removing this second 
>   #ifdef ?  gcc should realize it anyway that without CONFIG_COMPAT defined cmd 
> must be equal to NCP_IOC_GETPRIVATEDATA, and having empty "else" variant is IMHO 
> just asking for troubles.

That was what I did first, but unfortunately we don't define compat_caddr_t when
CONFIG_COMPAT is disabled, so it would reference an invalid data structure.

> Or what about 
> 
> #ifdef CONFIG_COMPAT
>      if (cmd == NCP_IOC_GETPRIVATEDATA_32) {
>         struct ...
>      } else
> #endif
>      if (copy_to_user(argp, &user, sizeof(user)))
>         return -EFAULT;

Yes, that should be clearer than my approach.

	Arnd <><
