Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131629AbQLPLU2>; Sat, 16 Dec 2000 06:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131380AbQLPLUU>; Sat, 16 Dec 2000 06:20:20 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:13062 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S131629AbQLPLUI>;
	Sat, 16 Dec 2000 06:20:08 -0500
Date: Sat, 16 Dec 2000 02:49:40 -0800 (PST)
From: Chris Mason <mason@suse.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrea Arcangeli <andrea@suse.de>, J Sloan <jjs@toyota.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [lkml]Re: VM problems still in 2.2.18
In-Reply-To: <E146zsJ-0001fT-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10012160244200.30931-100000@home.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Dec 2000, Alan Cox wrote:

> > Yes, the same `current' context must run the down/up pair of calls and as you
> > said it is legal to rely on it on all the places it's used.
> 
> I assume thats not an issue to reiserfs ?
> 
I don't think so.  There are two places reiserfs calls down/up.  In our
file->release() callback, and in the ioctl we added for lilo so it can
upack files with tails.

Neither calls copy_from/to_user or does an allocation other than
GFP_BUFFER.  As far as I know that should be safe, but the change is
trivial if we need to make it.

-chris


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
