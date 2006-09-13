Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWIMUe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWIMUe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWIMUe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:34:59 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:43209 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751175AbWIMUe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:34:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ioread64()?
Date: Wed, 13 Sep 2006 22:34:59 +0200
User-Agent: KMail/1.9.1
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org,
       Jan-Bernd Themann <ossthema@de.ibm.com>
References: <fa.zgAWvZQAAp+6nKV9Kd93QR7HZHw@ifi.uio.no> <4500A9EF.40807@shaw.ca>
In-Reply-To: <4500A9EF.40807@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609132234.59419.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Friday 08 September 2006 01:23 schrieb Robert Hancock:
> > I'm looking for a way to access 64 or 128 bit of device space in a single
> > access. For smaller accesses I use ioread32() and friends. But which way
> > should I do it for the next bigger accesses? Casting the iospace to
> > something like u64* looks very suspicious to me. Any better ideas?
>
> There's no portable way to do this as far as I'm aware, for the likely
> reason that on many architectures it's impossible to do it in one access..

Jan-Bernd has stumbled over this as well. There is some hardware that
actually requires atomic 64 bit accesses and is only available on 64 bit
systems, and not for PCI devices.

I'd prefer to have an ioread64 function that is only provided on CONFIG_64BIT
systems, which will mean that any driver using it needs to depend on that
option in Kconfig.

As an alternative, you can already use the readq() function that some 
architectures provide. Since linux doesn't run on 128 bit architectures,
you will not see one that can do an atomic read of that size.

	Arnd <>< 
