Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288511AbSANAzS>; Sun, 13 Jan 2002 19:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288512AbSANAzI>; Sun, 13 Jan 2002 19:55:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62737 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288511AbSANAyw>;
	Sun, 13 Jan 2002 19:54:52 -0500
Message-ID: <3C422C59.90E7D5CB@mandrakesoft.com>
Date: Sun, 13 Jan 2002 19:54:49 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Tim Hockin <thockin@sun.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rx FIFO Overrun error found
In-Reply-To: <3C40A6F2.18A8C3E6@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> Hi all,
> 
> I think I found the reason for the Rx status FIFO overrun nic hang:
> If the Rx fifo overflows, the nic sets RxStatusFIFOOver _instead_ of
> IntrRxIntr.
> Thus netdev_rx is never called, the rx ring is never refilled, nic
> hangs.
> 
> The attached patch adds proper OOM handling to natsemi.c.
> I've also copied the simpler netdev_close locking from ns83820.c.

Two comments, sis900.c uses the check (rx-overrun | rx-err | rx-ok), did
you test that combination?  (s/RxStatusFIFOOver/IntrRxOverrun/)

and it would be preferred to separate "add oom handling" and "fix nic
hang" patches.

-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
