Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWGJImb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWGJImb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 04:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWGJImb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 04:42:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:14252 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751363AbWGJIma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 04:42:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Pgc/YM9qolqXWtNVMrEqxcUDH1WkMsedmiIdzZoMXWTk8/A+wQA04gVzXbuZGHD0YkqlBCqbB8zjBZycVZLum2kTB4sOs6m0P/1YNeOtKR5BLCnG+BeTc31T3Mm/CTHHxGjf7pRH+8YYKNj/hESogaMOXAyzVW71S0/8enB5+tc=
Message-ID: <84144f020607100142l62f02321i9802f9eed64d39f4@mail.gmail.com>
Date: Mon, 10 Jul 2006 11:42:29 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Mike Galbraith" <efault@gmx.de>
Subject: Re: 2.6.18-rc1: slab BUG_ON(!PageSlab(page)) upon umount after failed suspend
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1152513068.7748.13.camel@Homer.TheSimpsons.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6wDCq-5xj-25@gated-at.bofh.it> <6wM2X-1lt-7@gated-at.bofh.it>
	 <6wOxP-4QN-5@gated-at.bofh.it> <44B189D3.4090303@imap.cc>
	 <20060709161712.c6d2aecb.akpm@osdl.org>
	 <1152513068.7748.13.camel@Homer.TheSimpsons.net>
X-Google-Sender-Auth: 97f2e44beec7b6dd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Mike Galbraith <efault@gmx.de> wrote:
> While trying to figure out what happened to break suspend to disk on my
> box, and booting between various other kernels to compare messages, I
> accidentally captured the following during shutdown.  I have no idea if
> failed suspends have anything to do with it, but it may, because I
> haven't had this happen in any other circumstance.  I'm making a rash
> presumption that the two or three other times the box has died on
> shutdown (without serial console being connected) were the same.

[snip]

> kernel BUG at <bad filename>:45803! <-- what goeth on here.  it's slab.c:1542

Looks as if kernel text is messed up.

> Code: 30 8b 57 3c 8b 45 f0 e8 d5 ac fe ff f6 47 36 02 74 11 8b 4f 3c b8 01 00 00 00 d3 e0 f0 29 05 14 ad 5f b1 83 c4 04 5b 5e 5f 5d c3 <0f> 0b eb b2 55 89 e5 57 56 53 83 ec 28 89 c6 89 d3 89 e0 25 00

See how ud2a comes after ret which doesn't match what GCC generates
for me at least. Furthermore, the BUG() line number is messed up (eb
b2). So doesn't look like a slab bug to me.

                                                    Pekka
