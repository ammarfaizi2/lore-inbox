Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVAUIM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVAUIM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVAUIM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:12:27 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:32937 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261870AbVAUIMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:12:18 -0500
Subject: Re: 2.6.11-rc1 vs. PowerMac 8500/G3 (and VAIO laptop) [usb-storage
	oops]
From: David Woodhouse <dwmw2@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: John Mock <kd6pag@qsl.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050121075833.GA19995@kroah.com>
References: <E1CrPQ4-0000pW-00@penngrove.fdns.net>
	 <1106210408.6932.27.camel@localhost.localdomain>
	 <20050121000822.GA14580@kroah.com>
	 <1106293748.783.31.camel@baythorne.infradead.org>
	 <20050121075833.GA19995@kroah.com>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 08:12:16 +0000
Message-Id: <1106295136.783.47.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-20 at 23:58 -0800, Greg KH wrote:
> Well, we should be byteswapping all of the fields that need to be
> swapped, right?  I'm guessing that userspace is expecting the fields
> to be in cpu endian, correct?

Userspace varies in that. Nobody expects _all_ the fields to be swapped;
the kernel only ever swapped those four. And in fact lsusb from the
stock usbutils expects it to be consistently little-endian. John's
version seems to be hacked to expect just those four fields to be host-
endian, while the rest remains little-endian.

We have a choice here -- we can preserve the ABI by continuing to be
stupidly inconsistent about endianness, or you can revert my patch and
stock usbutils can be correct.

> But if you want, I'll gladly revert your patch, as I don't have a ppc
> box to test this out on.

I'd revert it.

-- 
dwmw2


