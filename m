Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130733AbRCIWue>; Fri, 9 Mar 2001 17:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130738AbRCIWuY>; Fri, 9 Mar 2001 17:50:24 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:34519 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S130733AbRCIWuM>; Fri, 9 Mar 2001 17:50:12 -0500
Date: Fri, 09 Mar 2001 14:42:46 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch [RFC: API]
To: Gérard Roudier <groudier@club-internet.fr>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        "David S. Miller" <davem@redhat.com>,
        Russell King <rmk@arm.linux.org.uk>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <078101c0a8ea$44cd6920$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <Pine.LNX.4.10.10103091943580.1564-100000@linux.local>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gérard --

> Just for information to people that want to complexify the
> pci_alloc_consistent() interface thats looks simple and elegant to me:

I certainly didn't propose that!  Just a layer on top of the
pci_alloc_consistent code -- used as a page allocator, just
like you used it.


>   The object file of the allocator as seen in sym2 is as tiny as 3.4K
>   unstripped and 2.5K stripped.

What I sent along just compiled to 2.3 KB ... stripped, and "-O".
Maybe smaller with normal kernel flags.  The reverse mapping
code hast to be less than 0.1KB.

I looked at your code, but it didn't seem straightforward to reuse.
I think the allocation and deallocation costs can be pretty comparable
in the two implementations.  Your implementation might even fit behind
the API I sent.  They're both layers over pci_*_consistent (and both
have address-to-address mappings, implemented much the same).


> Now, if modern programmers are expecting Java-like interfaces for writing
> kernel software, it is indeed another story. :-)

Only if when you wrote "Java-like" you really meant "reusable"!  :)

- Dave


