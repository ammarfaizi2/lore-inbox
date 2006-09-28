Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbWI1QIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWI1QIl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbWI1QIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:08:40 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:62470 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S1751328AbWI1QIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:08:21 -0400
Subject: Re: Tiny error in printk output for clocksource : a3:<6>Time:
	acpi_pm clocksource has been installed.
From: Joe Perches <joe@perches.com>
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Greg KH <greg@kroah.com>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200609281256.23175.vda.linux@googlemail.com>
References: <9a8748490609261722g557eaeeayc148b5f5d910874d@mail.gmail.com>
	 <1159333843.13196.6.camel@localhost>
	 <20060926221718.7e20613e.rdunlap@xenotime.net>
	 <200609281256.23175.vda.linux@googlemail.com>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 09:08:14 -0700
Message-Id: <1159459694.5015.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-28 at 12:56 +0200, Denis Vlasenko wrote:
> \#define MACSTR "%02X:%02X:%02X:%02X:%02X:%02X"
> #define MAC(bytevector) \
>         ((unsigned char *)bytevector)[0], \
>         ((unsigned char *)bytevector)[1], \
>         ((unsigned char *)bytevector)[2], \
>         ((unsigned char *)bytevector)[3], \
>         ((unsigned char *)bytevector)[4], \
>         ((unsigned char *)bytevector)[5]

This is similar to the 802.11 way.
802.11 uses MAC_FMT and MAC_ARG.
I think a common style is preferable.

It's fine, but it increases the size of kernel image
by up to ~100K.  Using a common function, a stack
automatic and "%s" in the printk decreases the size
of the kernel. 

Strictly, not all MAC addresses are 6 byte.

Maybe all the Ethernet/TR addresses should use the
IEEE EUI48 designation?  That feels a bit like the
KiB/KB distinction, but it is technically correct.

Would a patch with an DEV6_ADDR->EUI48 substitution
be acceptable?

