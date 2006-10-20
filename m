Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWJTRv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWJTRv4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 13:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWJTRv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 13:51:56 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:63398 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030260AbWJTRvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 13:51:54 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45390CAC.7090409@s5r6.in-berlin.de>
Date: Fri, 20 Oct 2006 19:51:40 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Randy Dunlap <rdunlap@xenotime.net>
CC: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
References: <20061017005025.GF29920@ftp.linux.org.uk>	<Pine.LNX.4.64.0610161847210.3962@g5.osdl.org>	<20061017043726.GG29920@ftp.linux.org.uk>	<Pine.LNX.4.64.0610170821580.3962@g5.osdl.org>	<20061018044054.GH29920@ftp.linux.org.uk>	<20061018091944.GA5343@martell.zuzino.mipt.ru>	<20061018093126.GM29920@ftp.linux.org.uk>	<Pine.LNX.4.64.0610180759070.3962@g5.osdl.org>	<20061018160609.GO29920@ftp.linux.org.uk>	<Pine.LNX.4.64.0610180926380.3962@g5.osdl.org>	<20061020005337.GV29920@ftp.linux.org.uk>	<20061019213545.bf5a51c1.rdunlap@xenotime.net>	<45389662.6010604@s5r6.in-berlin.de> <20061020091302.a2a85fb1.rdunlap@xenotime.net>
In-Reply-To: <20061020091302.a2a85fb1.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> On Fri, 20 Oct 2006 11:26:58 +0200 Stefan Richter wrote:
>> I am afraid in many of these cases a proper cleanup would _replace_ the
>> include by the correct one, not just delete it. For example,
>> drivers/ieee1394/raw1394.c should include linux/spinlock.h. AFAICS it
>> does so at the moment only indirectly via another header.
> 
> I don't think that we can fix it all at once.  This is just one step.
> AFAICT for raw1394.c, it's not incorrect as is, but more is needed,
> sure.

Yes, it's probably still correct after your patch. I just referred to
the sensible rule that necessary headers should be directly included
where they are used, not indirectly via other headers.

> Yes, we have lots of header include indirection going on.
> I don't know of a good tool to detect/fix it.

Me neither. I manually cleansed the ieee1394 core's and sbp2's includes
recently; this is a mind-numbing janitorial job.

> What Al is doing is good stuff, but I'd still prefer to see an even
> better tool, like gcc-preprocessor or sparse based (I guess).

On the surface, tools like LXR and cscope "know" where function are
declared or macros and types are defined. But oftentimes, other headers
than these tools turn up are to be included by API users. Cf. the
definition of atomic_t. (IOW the "necessary" header is not always the
one which has the actual definition.)
-- 
Stefan Richter
-=====-=-==- =-=- =-=--
http://arcgraph.de/sr/
