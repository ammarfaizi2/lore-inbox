Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWHPWRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWHPWRH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWHPWRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:17:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:1276 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750730AbWHPWRF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:17:05 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Date: Thu, 17 Aug 2006 00:16:46 +0200
User-Agent: KMail/1.9.1
Cc: David Miller <davem@davemloft.net>, akpm@osdl.org, jeff@garzik.org,
       netdev@vger.kernel.org, jklewis@us.ibm.com,
       linux-kernel@vger.kernel.org, Jens.Osterkamp@de.ibm.com
References: <44E38157.4070805@garzik.org> <200608162324.47235.arnd@arndb.de> <20060816.143203.11626235.davem@davemloft.net>
In-Reply-To: <20060816.143203.11626235.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608170016.47072.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wednesday 16 August 2006 23:32 schrieb David Miller:
> Can spidernet be told these kinds of parameters?  "N packets or
> X usecs"?

It can not do exactly this but probably we can get close to it by

1.) Setting a one-time interrupt to fire x*10µs after putting a
   packet into the TX queue.

and

2.a) Enabling end of TX queue interrupts whenever more than y frames
     have been queued for TX.

or

2.b) Marking frame number y in the TX to fire an interrupt when it
     has been transmitted, and move the mark whenever we clean up
     TX descriptors.

or

2.c) Marking frame number y to generate an interrupt, but counting
     y from the end of the queue, and update the mark whenever we
     add frames to the queue tail.

I'm not sure which version of 2. would give us the best approximation.

	Arnd <><
