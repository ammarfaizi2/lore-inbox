Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbQLWRqC>; Sat, 23 Dec 2000 12:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129352AbQLWRpw>; Sat, 23 Dec 2000 12:45:52 -0500
Received: from mail.sonicity.com ([63.251.235.60]:29956 "HELO
	mail.sonicity.com") by vger.kernel.org with SMTP id <S129421AbQLWRpk>;
	Sat, 23 Dec 2000 12:45:40 -0500
Date: Sat, 23 Dec 2000 09:15:13 -0800 (PST)
From: <keyser-lk@soze.net>
To: Sourav Sen <sourav@csa.iisc.ernet.in>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: whats happening
In-Reply-To: <Pine.SOL.3.96.1001223180009.12949B-100000@kohinoor.csa.iisc.ernet.in>
Message-ID: <Pine.LNX.4.30.0012230910170.13602-100000@straylight.int.sonicity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Dec 2000, Sourav Sen wrote:

> In some parts of the kernel code I find expression like
>
> len = (len + ~PAGE_MASK) & PAGE_MASK ;
>
> Whats happening to len?

It's being aligned properly.

if you have a continuous array of objects that are each 8 bytes, you
create a mask that's FFFFFFF8, then if len=7, instead of doing an
operation on the last byte of the first thing and the first 7 bytes of the
second, the above expression will add 7, making len 14, then normalize it
to the last valid object address, 8.  And if you start with a valid
address, you get that same address back.


justin
-- 
To summon a demon you must first know its name.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
