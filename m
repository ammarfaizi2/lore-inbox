Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbTBTULh>; Thu, 20 Feb 2003 15:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbTBTULh>; Thu, 20 Feb 2003 15:11:37 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9349
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264910AbTBTULg>; Thu, 20 Feb 2003 15:11:36 -0500
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
	reboots)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       Dave Hansen <haveblue@us.ibm.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <Pine.LNX.4.44.0302200847060.2493-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302200847060.2493-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045776104.3790.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 20 Feb 2003 21:21:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-20 at 16:54, Linus Torvalds wrote:
> Ok, the 4kB stack definitely won't work in real life, but that's because 
> we have some hopelessly bad stack users in the kernel. But the debugging 
> part would be good to try (in fact, it might be a good idea to keep the 
> 8kB stack, but with rather anal debugging. Just the "mcount" part should 
> do that).

You also need IRQ stacks to get down to 4K. The wrong pattern of ten
different IRQ handlers using a mere 200 bytes each will eventually
happen and eventually kill you otherwise.

> That ide_unregister() thing uses up >2kB in just one call! And there are 
> several in the 1.5kB range too, with a long list of ~500 byte offenders.

ide_unregister is a really stupid one. Its copying a struct mostly to
restore fields it shouldnt be restoring but should be setting in the 
allocator. I hadn't realised quite how bad it was. Added to the ide
shitlist


