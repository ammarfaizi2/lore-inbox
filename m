Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQLYDAw>; Sun, 24 Dec 2000 22:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130376AbQLYDAm>; Sun, 24 Dec 2000 22:00:42 -0500
Received: from [213.8.184.108] ([213.8.184.108]:55048 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S129595AbQLYDA0>;
	Sun, 24 Dec 2000 22:00:26 -0500
Date: Mon, 25 Dec 2000 04:26:31 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Zlatko Calusic <zlatko@iskon.hr>
cc: Linus Torvalds <torvalds@transmeta.com>, "Marco d'Itri" <md@Linux.IT>,
        Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <87puihl7y2.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.21.0012250416530.29006-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Dec 2000, Zlatko Calusic wrote:

> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > On Sun, 24 Dec 2000, Linus Torvalds wrote:
> > > 
> > > Marco, would you mind changing the test in reclaim_page(), somewheer
> > > around line mm/vmscan.c:487 that says:
> > 
> 
> Speaking of page_launder() I just stumbled upon two oopsen today on
> the UP build. Maybe it could give a hint to someone, I'm not that good
> at Oops decoding.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000c
>  printing eip:
> c012872e
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[page_launder+510/2156]

I suspected I'm not the only one who is getting these exact same Oopses
(and the lockups that follow them) so earlier today, I've decoded the Oops
I got, and found that the problem is in vmscan.c:line-605, where 
page->mapping is NULL and a_ops gets resolved and dereferenced at
0x0000000c. 

I leave the fix for the mm experts, I've notified Linus, I guess he's
looking into it. 

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
