Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311834AbSDSIJT>; Fri, 19 Apr 2002 04:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311839AbSDSIJS>; Fri, 19 Apr 2002 04:09:18 -0400
Received: from imailg1.svr.pol.co.uk ([195.92.195.179]:14087 "EHLO
	imailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S311834AbSDSIJR>; Fri, 19 Apr 2002 04:09:17 -0400
Date: Fri, 19 Apr 2002 09:08:14 +0100
To: Stephen Lord <lord@sgi.com>
Cc: Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mark Peloquin <peloquin@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Bio pool & scsi scatter gather pool usage
Message-ID: <20020419080814.GA1181@fib011235813.fsnet.co.uk>
In-Reply-To: <OFCF00F1A4.2665039D-ON85256B9F.006B755C@pok.ibm.com> <E16yLS4-0005vN-00@the-village.bc.nu> <3CBF5B67.E488A8E5@zip.com.au> <3CBFC755.50106@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 02:29:25AM -0500, Stephen Lord wrote:
> But this gets you lowest common denominator sizes for the whole
> volume, which is basically the buffer head approach, chop all I/O up
> into a chunk size we know will always work. Any sort of nasty  boundary
> condition at one spot in a volume means the whole thing is crippled
> down to that level. It then becomes a black magic art to configure a
> volume which is not restricted to a small request size.

This is exactly the problem; I don't think it's going to be unusual to
see volumes that have a variety of mappings.  For example the
'journal' area of the lv with a single fast pv, 'small file' area with
a linear mapping across normal pv's, and finally a 'large file' area
that has a few slower disks striped together.

The last thing I want in this situation is to split up all the io into
the lowest common chunk size, in this case the striped area which will
typically be  < 64k.

LVM and EVMS need to do the splitting and resubmitting of bios
themselves.

- Joe
