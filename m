Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSE0K7k>; Mon, 27 May 2002 06:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSE0K7j>; Mon, 27 May 2002 06:59:39 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:63739 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316574AbSE0K7i>; Mon, 27 May 2002 06:59:38 -0400
Subject: Re: Memory management in Kernel 2.4.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <acsuv2$30v$1@ID-44327.news.dfncis.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 13:02:08 +0100
Message-Id: <1022500928.11811.259.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 10:40, Andreas Hartmann wrote:
> Unfortunately, the memory management of kernel 2.4.x didn't get better until 
> today. It is very easy to make a machine dead. Take the following script:
> 
> http://groups.google.com/groups?q=malloc+bestie&hl=de&lr=&selm=slrn8aiglm.tqd.pfk@c.zeiss.de&rnum=2
> 
> 
> The result with kernel 2.4.19pre8ac4:
> 
> May 27 11:04:21 athlon kernel: Out of Memory: Killed process 763 (knode).

This appears to be correct behaviour. You allocated astronomical amounts
of memory and had memory overcommit enabled so it broke. Thats
configurable and you can if you wish disable overcommit in the -ac
kernel by setting /proc/sys/vm/overcommit_memory to 2 (thats not
supported by the base 2.4 kernels yet). If you can make it OOM in that
mode then I am interested indeed. 

The rsync one is more interesting, it could be something doing huge
amounts of memory allocations it could also be excessive kernel usage or
wrong OOM semantics somewhere.

