Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267449AbRG2Bxm>; Sat, 28 Jul 2001 21:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267452AbRG2Bxd>; Sat, 28 Jul 2001 21:53:33 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:5138 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S267449AbRG2Bx0>; Sat, 28 Jul 2001 21:53:26 -0400
Message-ID: <3B636E09.40F12A6@zip.com.au>
Date: Sun, 29 Jul 2001 11:59:37 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <s5gsnfh80hw.fsf@egghead.curl.com> from "Patrick J. LoPresti" at Jul 28, 2001 12:46:51 PM <E15QZNB-00082q-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox wrote:
> 
>...
> > If you have metadata journalling, all you need for this algorithm to
> > work is to have rename() write to the journal before returning.  Is
> > this true for any of the current journalling file systems on Linux?
> 
> Ext3 I believe so, Reiserfs I would assume so but Hans can answer
> definitively

For ext3: this is true if something forces a commit.  Apart from data in
`-o data=writeback' mode, a commit syncs the entire filesystem.
Things which force a commit include:

- completing a write() on an O_SYNC file.
- Performing any metadata operation on a `chattr +S' object
- Performing any metadata operation on an object on a `mount -o sync'
  filesystem.

In `data=journal' or `data=ordered' mode, any of these things will
commit everything to non-volatile storage.

-
