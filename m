Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287303AbSBCPGG>; Sun, 3 Feb 2002 10:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287306AbSBCPF5>; Sun, 3 Feb 2002 10:05:57 -0500
Received: from zok.SGI.COM ([204.94.215.101]:48824 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S287303AbSBCPFn>;
	Sun, 3 Feb 2002 10:05:43 -0500
Message-ID: <3C5D51A0.4050509@sgi.com>
Date: Sun, 03 Feb 2002 09:05:04 -0600
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Jeff Garzik <garzik@havoc.gtf.org>, Chris Mason <mason@suse.com>,
        Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT fails in some kernel and FS
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es> <3C5AFE2D.95A3C02E@zip.com.au> <1012597538.26363.443.camel@jen.americas.sgi.com> <20020202093554.GA7207@tapu.f00f.org> <234710000.1012674008@tiny> <20020202205438.D3807@athlon.random> <242700000.1012680610@tiny> <3C5C4929.5080403@sgi.com> <20020202155028.B26147@havoc.gtf.org> <3C5D3DE9.4080503@sgi.com> <20020203140926.GA14532@tapu.f00f.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

>On Sun, Feb 03, 2002 at 07:40:57AM -0600, Stephen Lord wrote:
>
>    What we had were two flags, one which indicated use direct I/O,
>    and another which indicated return an error to user space rather
>    than go through buffers.  So lie to me and make it work, or don't
>    lie to me options I suppose.
>
>This seems way to complex in the case of reiserfs... you're only going
>to see tails for small files (typically under 16k) and for the tail
>part when less than a block.
>
>Since O_DIRECT much be blocked sized and block aligned, I'm not sure
>if this is a problem at present...
>

I agree is is not a big issue in this case - my interpretation of tails 
was the end
of any file could be packed, but if it is only small files.....

>
>
>    I suspect the reason XFS never did small files in the inode was
>    because of the problems with implementing mmap and O_DIRECT.
>
>How does IRIX deal with O_DIRECT read/writes of a mapped area?
>Invalidate them or just accept things as being incoherent?
>

They are invalidated at the start of the I/O, but page faults are not 
blocked
out for the duration of the I/O, so the coherency is weak. However, if an
application is doing a combination of mmapped and direct I/O to a file
at the same time, then it should generally have some form of user space
synchronization anyway. For an application doing its own synchronization
of different I/Os they are coherent.

>
>
>
>    --cw
>

Steve


