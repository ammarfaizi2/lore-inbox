Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130031AbQLNFDi>; Thu, 14 Dec 2000 00:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129977AbQLNFD1>; Thu, 14 Dec 2000 00:03:27 -0500
Received: from www.wen-online.de ([212.223.88.39]:61198 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129921AbQLNFDJ>;
	Thu, 14 Dec 2000 00:03:09 -0500
Date: Thu, 14 Dec 2000 05:32:39 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: swapoff/on leak test12-pre7
In-Reply-To: <Pine.Linu.4.10.10012091822230.602-100000@mikeg.weiden.de>
Message-ID: <Pine.Linu.4.10.10012140525140.1022-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2000, Mike Galbraith wrote:

> Hi,
> 
> Stumbled over a small leak.. and some funny looking numbers.

Numbers aren't funny looking.. bad eyeballs.

> while true; do swapoff -a; swapon -a; done

<snip vmstat of leak>

Leak is because the page allocated in swapon has buffers.  Since
it's not on any list, they never get scrubbed off and the page is
leaked.  (I killed it here with try_to_free_buffers().. works)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
