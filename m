Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318167AbSGQAcu>; Tue, 16 Jul 2002 20:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318169AbSGQAct>; Tue, 16 Jul 2002 20:32:49 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:30964 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318167AbSGQAcr>; Tue, 16 Jul 2002 20:32:47 -0400
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs
	benchmarks)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zack Weinberg <zack@codesourcery.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020717001032.GI358@codesourcery.com>
References: <20020716232225.GH358@codesourcery.com>
	<1026867782.1688.108.camel@irongate.swansea.linux.org.uk> 
	<20020717001032.GI358@codesourcery.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Jul 2002 02:45:40 +0100
Message-Id: <1026870340.2119.122.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 01:10, Zack Weinberg wrote:
> My first point is that a portable application cannot rely on close to
> detect any error.  Only fsync guarantees to detect any errors at all
> (except ENOSPC/EDQUOT, which should come back on write; yes, I know
> about the buggy NFS implementations that report them only on close).

They are not buggy merely inconvenient. The reality of the NFS protocol
makes it the only viable way to do it

> My second point, which you deleted, is that if some hypothetical close
> implementation reports an error under some circumstances, an
> immediately preceding fsync call MUST also report the same error under
> the same circumstances.

I can't think of a case I'd disagree

> Therefore, if you've checked the return value of fsync, there's no
> point in checking the subsequent close; and if you don't care to call
> fsync, the close return value is useless since it isn't guaranteed to
> detect anything.

If you don't check the return code it might not detect anything. If you
do check the return code it might detect something. In fact you
contradict yourself IMHO by giving the NFS example.

> > If it bothers you close it again 8)
> 
> And watch it come back with an error again, repeat ad infinitum?

The use of intelligence doesn't help. Come on I know you aren't a cobol
programmer. Check for -EBADF ...

> You missed the point.  The manpage asserts that I/O errors are
> guaranteed to be detected by close; there is no such guarantee.

Disagree. It says

It is quite possible that errors on a  previous  write(2)  operation 
are first  reported  at  the  final  close

Not checking the return value when closing the file may lead to silent
loss of  data.

       A successful close does not guarantee that  the  data  has
       been  successfully  saved  to  disk,  as the kernel defers
       writes. It is not common for a  filesystem  to  flush  the
       buffers  when the stream is closed. If you need to be sure
       that the data is physically stored use fsync(2).  (It will
       depend on the disk hardware at this point.)

None of which guarantee what you say, and which agree about the use of
fsync being appropriate now and then

