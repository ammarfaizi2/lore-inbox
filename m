Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRBAOwZ>; Thu, 1 Feb 2001 09:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129659AbRBAOwO>; Thu, 1 Feb 2001 09:52:14 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:28677 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129443AbRBAOwD>; Thu, 1 Feb 2001 09:52:03 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Message-ID: <CA2569E6.0051970D.00@d73mta03.au.ibm.com>
Date: Thu, 1 Feb 2001 20:14:58 +0530
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait 
	/notify + callback chains
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Hi,
>
>On Thu, Feb 01, 2001 at 10:25:22AM +0530, bsuparna@in.ibm.com wrote:
>>
>> >We _do_ need the ability to stack completion events, but as far as the
>> >kiobuf work goes, my current thoughts are to do that by stacking
>> >lightweight "clone" kiobufs.
>>
>> Would that work with stackable filesystems ?
>
>Only if the filesystems were using VFS interfaces which used kiobufs.
>Right now, the only filesystem using kiobufs is XFS, and it only
>passes them down to the block device layer, not to other filesystems.

That would require the vfs interfaces themselves (address space
readpage/writepage ops) to take kiobufs as arguments, instead of struct
page *  . That's not the case right now, is it ?
A filter filesystem would be layered over XFS to take this example.
So right now a filter filesystem only sees the struct page * and passes
this along. Any completion event stacking has to be applied with reference
to this.


>> Being able to track the children of a kiobuf would help with I/O
>> cancellation (e.g. to pull sub-ios off their request queues if I/O
>> cancellation for the parent kiobuf was issued). Not essential, I guess,
in
>> general, but useful in some situations.
>
>What exactly is the justification for IO cancellation?  It really
>upsets the normal flow of control through the IO stack to have
>voluntary cancellation semantics.

One reason that I saw is that if the results of an i/o are no longer
required due to some condition (e.g. aio cancellation situations, or if the
process that issued the i/o gets killed), then this avoids the unnecessary
disk i/o, if the request hadn't been scheduled as yet.

Too remote a requirement ? If the capability/support doesn't exist at the
driver level I guess its difficult.

--Stephen

_______________________________________________
Kiobuf-io-devel mailing list
Kiobuf-io-devel@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/kiobuf-io-devel



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
