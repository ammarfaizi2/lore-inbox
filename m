Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWEFHKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWEFHKo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 03:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWEFHKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 03:10:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60940 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751250AbWEFHKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 03:10:44 -0400
Date: Sat, 6 May 2006 08:10:36 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device core: remove redundant call to device_initialize.
Message-ID: <20060506071036.GB18829@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>,
	gregkh@suse.de, linux-kernel@vger.kernel.org
References: <20060505153907.12756.23295.stgit@zion.home.lan> <20060505193542.0332557b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505193542.0332557b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 07:35:42PM -0700, Andrew Morton wrote:
> A better design would be to rip out all the device_initialize() calls and
> require that the caller run device_initialize() before "add"ing or
> "register"ing the platform_device.

No.  The caller must not call device_initialise().  They either use
platform_device_alloc() and platform_device_add(), or
platform_device_register().  Same rules apply to these as they
do for device_add() vs device_register().

> And indeed platform_device_alloc() already does that.  If that is
> sufficient then we're in good shape.
> 
> If it is not sufficient then more thought would be needed.  We could at
> least run device_initialize() at the _start_ of platform_device_add(),
> rather than towards the end.

Just remove the call to device_initialise() in platform_device_add() -
that's something I missed when I renamed platform_device_register to
platform_device_add().

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
