Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131611AbRBAUeh>; Thu, 1 Feb 2001 15:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131709AbRBAUe1>; Thu, 1 Feb 2001 15:34:27 -0500
Received: from ns.caldera.de ([212.34.180.1]:64007 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131611AbRBAUeS>;
	Thu, 1 Feb 2001 15:34:18 -0500
Date: Thu, 1 Feb 2001 21:33:27 +0100
Message-Id: <200102012033.VAA15590@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: sct@redhat.com ("Stephen C. Tweedie")
Cc: Steve Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
        "kiobuf-io-devel@lists.sourceforge.net Alan Cox" 
	<alan@lxorguk.ukuu.org.uk>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010201174946.B11607@redhat.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010201174946.B11607@redhat.com> you wrote:
> Hi,

> On Thu, Feb 01, 2001 at 05:34:49PM +0000, Alan Cox wrote:
> In the disk IO case, you basically don't get that (the only thing
> which comes close is raid5 parity blocks).  The data which the user
> started with is the data sent out on the wire.  You do get some
> interesting cases such as soft raid and LVM, or even in the scsi stack
> if you run out of mailbox space, where you need to send only a
> sub-chunk of the input buffer. 

Though your describption is right, I don't think the case is very common:
Sometimes in LVM on a pv boundary and maybe sometimes in the scsi code.

In raid1 you need some kind of clone iobuf, which should work with both
cases.  In raid0 you need a complete new pagelist anyway, same for raid5.


> In that case, having offset/len as the kiobuf limit markers is ideal:
> you can clone a kiobuf header using the same page vector as the
> parent, narrow down the start/end points, and continue down the stack
> without having to copy any part of the page list.  If you had the
> offset/len data encoded implicitly into each entry in the sglist, you
> would not be able to do that.

Sure you could: you embedd that information in a higher-level structure.
I think you want the whole kio concept only for disk-like IO.  Then many
of the things you do are completly right and I don't see much problems
(besides thinking that some thing may go away - but that's no major point).

With a generic object that is used over subsytem boundaries things are
different.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
