Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276352AbRJDFiT>; Thu, 4 Oct 2001 01:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276973AbRJDFiJ>; Thu, 4 Oct 2001 01:38:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47879 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276352AbRJDFiC>; Thu, 4 Oct 2001 01:38:02 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Date: Thu, 4 Oct 2001 05:38:12 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9pgsk4$7ep$1@penguin.transmeta.com>
In-Reply-To: <200110031249.HAA50103@tomcat.admin.navo.hpc.mil> <m1r8sk1tuq.fsf@frodo.biederman.org> <01100319203903.00728@localhost.localdomain>
X-Trace: palladium.transmeta.com 1002173905 5106 127.0.0.1 (4 Oct 2001 05:38:25 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 4 Oct 2001 05:38:25 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <01100319203903.00728@localhost.localdomain>,
Rob Landley  <landley@trommello.org> wrote:
>
>I.E. it seems like they go out of their way to ALLOW writing to the libaries. 
> (I assume they KNOW the difference between MAP_DENYWRITE, MAP_COPY, and 
>MAP_PRIVATE...?)

Note that the kernel will refuse to honour MAP_DENYWRITE from user
space, so I'm afraid that changing ld.so won't do a thing.

The reason the kernel refuses to honour it, is that MAP_DENYWRITE is an
excellent DoS-vehicle - you just mmap("/etc/passwd") with MAP_DENYWRITE,
and even root cannot write to it.. Vary nasty.

Which is why the kernel only allows it when the binary loader itself
sets the flag, because security-conscious application writers are
already aware of the "oh, a running binary may not be writable" issues.

So sorry..

		Linus

