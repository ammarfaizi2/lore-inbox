Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130792AbRAVNAi>; Mon, 22 Jan 2001 08:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131998AbRAVNA3>; Mon, 22 Jan 2001 08:00:29 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:13250 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130792AbRAVNAQ>; Mon, 22 Jan 2001 08:00:16 -0500
Date: Mon, 22 Jan 2001 13:00:08 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <3A6C02C4.E34E3A6@idb.hist.no>
Message-ID: <Pine.SOL.4.21.0101221252340.23841-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2001, Helge Hafting wrote:

> And when the next user wants the same webpage/file you read it from
> the RAID again? Seems to me you loose the benefit of caching stuff in
> memory with this scheme. Sure - the RAID controller might have some
> cache, but it is usually smaller than main memory anyway. 

Hrm... good point. Using "main memory" (whose memory, on a NUMA box??) as
a cache could be a performance boost in some circumstances. On the other
hand, you're eating up a chunk of memory bandwidth which could be used for
other things - even when you only cache in "spare" RAM, how do you decide
who uses that RAM - and whether or not they should?

There certainly comes a point at which not caching in RAM would be a net
win, but ATM the kernel doesn't know enough to determine this.

On a shared bus, probably the best solution would be to have the data sent
to both devices (NIC and RAM) at once?

> And then there are things like retransmissions...

Hopefully handled by an intelligent NIC in most cases; if you're caching
the file in RAM as well (by "CCing" the data there the first time) this is
OK anyway.

Something to think about, but probably more on-topic for linux-futures I
suspect...


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
