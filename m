Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129514AbQKWLhj>; Thu, 23 Nov 2000 06:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131133AbQKWLh3>; Thu, 23 Nov 2000 06:37:29 -0500
Received: from nevald.k-net.dtu.dk ([130.225.71.226]:27793 "EHLO
        nevald.k-net.dk") by vger.kernel.org with ESMTP id <S129514AbQKWLhN>;
        Thu, 23 Nov 2000 06:37:13 -0500
From: "Anders K. Pedersen" <akp@akp.dk>
Subject: Re: ext2 compression: How about using the Netware principle?
Date: Thu, 23 Nov 2000 12:07:06 +0100
Organization: AKP Consult I/S
Message-ID: <3A1CFA5A.71750F53@akp.dk>
In-Reply-To: <3A193A12.9B384B61@karlsbakk.net> <20001122132922.A41@toy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: akp-3.bergsoe.k-net.dk 974977630 24113 192.38.218.231 (23 Nov 2000 11:07:10 GMT)
X-Complaints-To: newsmaster@akp.dk
X-Accept-Language: da,en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > - A file is saved to disk
> > - If the file isn't touched (read or written to) within <n> days
> > (default 14), the file is compressed.
> > - If the file isn't compressed more than <n> percent (default 20), the
> > file is flagged "can't compress".
> > - All file compression is done on low traffic times (default between
> > 00:00 and 06:00 hours)
> > - The first time a file is read or written to within the <n> days
> > interval mentioned above, the file is addressed using realtime
> > compression. The second time, the file is decompressed and commited to
> > disk (uncompressed).

Also, if less than <n> percent of the volume is free, files will not be
decompressed, and compressed files can only be addressed through
realtime decompression.

> Oops, that means that merely reading a file followed by powerfail can
> lead to you loosing the file. Oops.

That is of course not the case. When a file is decompressed (or
compressed) a new file is created, and once the (de)compression is
completed, a delete and rename will be performed, and this is, if I
remember correctly, transaction based, so the file will not be lost in
case a powerfail should occur.

Regards,
Anders K. Pedersen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
