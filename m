Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAYBdn>; Wed, 24 Jan 2001 20:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135354AbRAYBdc>; Wed, 24 Jan 2001 20:33:32 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:44228 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129444AbRAYBdR>; Wed, 24 Jan 2001 20:33:17 -0500
Message-ID: <3A6F8415.8EC5DB23@uow.edu.au>
Date: Thu, 25 Jan 2001 12:40:37 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
In-Reply-To: <200101242123.NAA00986@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> I'm back from OZ, and to help deal with my sudden lack of Victoria
> Bitter,

aww.. Poor Dave.  I'll have an extra one for you.

> ...
> There is one critical failure I saw reported with zerocopy, where all
> transmits basically failed using a 3c59x card.  This indicates that
> our driver checks thought the 3c59x you had supported TX checksumming
> in hardware, when in fact it does not.

I've tested the latest zc patch on:

3c905   (10b7/9050)
3c905B  (10b7/9055)
3c905C  (10b7/9200)
3c590   (10b7/5900)

no problems.  I simply mounted an NFS server with rsize=wsize=8192
and read a few files - I assume this is sufficient?

I can test a 3c575 later today.

What I suggest we do here is to add a new flag to the per-device
table `HAS_HWCKSM' and use that to set the device capabilities,
rather than using the IS_CYCLONE stuff.  Then we can add cards
individually as confirmation comes in.

I do have a 200-line 3c59x patch banked up - it does the following:

- fixes some interface selection problems with 3c590/3c900's
- fixes a PAGE_SIZE memory leak which occurs each time the
  driver is unloaded (pci_free_consistent needed).
- fixes the 3c556B's PM-resume behaviour

So...  How to coordinate these diffs?  I'd propose that I implement
the HAS_HWCKSM thing, test zerocopy with it on the five NICs which
I have.  Then what?  Ask Linus to merge the non-zc parts?

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
