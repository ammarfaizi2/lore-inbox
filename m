Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290503AbSBLTgc>; Tue, 12 Feb 2002 14:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290958AbSBLTgN>; Tue, 12 Feb 2002 14:36:13 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:45098 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S290503AbSBLTgC> convert rfc822-to-8bit; Tue, 12 Feb 2002 14:36:02 -0500
Date: Mon, 11 Feb 2002 21:34:52 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
cc: <alan@lxorguk.ukuu.org.uk>, <zaitcev@redhat.com>, <stodden@in.tum.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: pci_pool reap?
In-Reply-To: <20020211.184412.35663889.davem@redhat.com>
Message-ID: <20020211212925.B1867-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Feb 2002, David S. Miller wrote:

>    From: Gérard Roudier <groudier@free.fr>
>    Date: Sun, 10 Feb 2002 21:20:05 +0100 (CET)
>
>    On Mon, 11 Feb 2002, Alan Cox wrote:
>
>    > This function may not be called in interrupt context.
>
>    Such limitation looks poor implementation to me.
>
> I agree with you Gerard, and probably nobody truly even requires
> this limitation.  I do plan to remove it after I've done a thorough
> investigation of the platform implementations.

In the meantime, you may just queue the thing to memory (as the allocated
memory chunk is likely to be larger than a pointer given alignment) and
use some helper thread that dequeue things to free and does the actual
free in 'non-interrupt' context (only on ports that are unable to free
under interrupt context, obviously).

  Gérard.



