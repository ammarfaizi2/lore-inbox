Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268243AbRG3AeB>; Sun, 29 Jul 2001 20:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268247AbRG3Adw>; Sun, 29 Jul 2001 20:33:52 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:40459
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S268243AbRG3Adi>; Sun, 29 Jul 2001 20:33:38 -0400
Date: Sun, 29 Jul 2001 20:32:37 -0400
From: Chris Mason <mason@suse.com>
To: Chris Wedgwood <cw@f00f.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <151150000.996453157@tiny>
In-Reply-To: <20010729135348.A3282@weta.f00f.org>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Sunday, July 29, 2001 01:53:48 PM +1200 Chris Wedgwood <cw@f00f.org>
wrote:

> On Sat, Jul 28, 2001 at 08:03:37PM +0100, Alan Cox wrote:
> 
>     Ext3 I believe so, Reiserfs I would assume so but Hans can answer
>     definitively
> 
> Reiserfs does not, nor are creates or unlink operations synchronous.
> 
> For MTAs it just happens to work: if you fsync the way transactions
> are written means the metadata for the dirtectories is written as part
> of the transaction --- but I think this is a quirk and not by design?
> 
> Chris?

Correct, in the current 2.4.x code, its a quirk.  fsync(any object) ==
fsync(all pending metadata, including renames).

There is a transcation tracking patch floating around out there that makes
reiserfs fsync/O_SYNC much faster by only committing the last transaction a
given file/dir was involved in.  I had sent this to alan just after 2.4.7
came out, but it looks like I need to resend.

Anyway, during a rename, this patch updates the inode transaction tracking
stuff so an fsync on the file should also commit the directory changes.
But, that isn't something I really intend to advertise much, since the
accepted linux way is fsync(dir).

-chris

