Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWHCNFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWHCNFn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 09:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWHCNFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 09:05:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17376 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932446AbWHCNFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 09:05:43 -0400
Subject: Re: [PATCH] tty: add ioctl for setting the throttle threshold
	(handshake)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dirk Eibach <eibach@gdsys.de>
Cc: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <44D1F1C5.6040809@gdsys.de>
References: <44D1F1C5.6040809@gdsys.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Aug 2006 14:25:00 +0100
Message-Id: <1154611500.23655.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-03 am 14:53 +0200, ysgrifennodd Dirk Eibach:
> To be more flexible ioctls were added to control the throttling thresholds.
> 
> This patch applies to kernel 2.6.16.
> 
> Signed-off-by: Dirk Eibach <eibach@gdsys.de>

NAK

Two reasons

#1 Users should not be expected to set these kind of parameters, the
kernel should just get it right
#2 With the new buffering if you respond too slowly then thats allowed
for (with a limit enforced in the patch I posted)

Those two alone aren't quite enough to deal with some corner cases where
you throttle too late and queue an oversized buffer. The changes in
2.6.18-rc by Paul however ensure that such a buffer is fed into the
ldisc in appropriate sized chunks to avoid data loss.

Alan

