Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRAWJQI>; Tue, 23 Jan 2001 04:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129641AbRAWJP6>; Tue, 23 Jan 2001 04:15:58 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:15376 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S129733AbRAWJCZ>; Tue, 23 Jan 2001 04:02:25 -0500
Message-ID: <3A6D4872.3CCA957B@idb.hist.no>
Date: Tue, 23 Jan 2001 10:01:38 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: James Sutherland <jas88@cam.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.SOL.4.21.0101221252340.23841-100000@yellow.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland wrote:
> 
> On Mon, 22 Jan 2001, Helge Hafting wrote:
> 
> > And when the next user wants the same webpage/file you read it from
> > the RAID again? Seems to me you loose the benefit of caching stuff in
> > memory with this scheme. Sure - the RAID controller might have some
> > cache, but it is usually smaller than main memory anyway.
> 
> Hrm... good point. Using "main memory" (whose memory, on a NUMA box??) as
> a cache could be a performance boost in some circumstances. On the other
> hand, you're eating up a chunk of memory bandwidth which could be used for
> other things - even when you only cache in "spare" RAM, how do you decide
> who uses that RAM - and whether or not they should?

If we will need it again soon - cache it.  If not, consider 
your device->device scheme.  What we will need is often impossible to
know,
so approximations like LRU is used.  You could have a object table
(probably a file table or disk block table) counting how often various
files/objects are referenced.  You can then decide to use RAID->NIC
transfers for something that haven't been read before, and memory
cache when something is re-read for the nth time in a given time
interval.
"n" and the time interval depends on how much cache you have, and
the size of your working set.  

This might be a win, maybe even a big win under some circumstances.  
But considering how it works only for a few devices only, and how
complicated it is, the conclusion becomes don't do it for 
standard linux.  
You may of course try to make super-performance
servers that work for a special hw combination, with a single
very optimized linux driver taking care of the RAID adapter, the NIC(s),
the fs, parts of the network stack and possibly the web server too.

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
