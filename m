Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136078AbREIKaw>; Wed, 9 May 2001 06:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136108AbREIKam>; Wed, 9 May 2001 06:30:42 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:26639 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S136078AbREIKa0>; Wed, 9 May 2001 06:30:26 -0400
Message-ID: <3AF91C2B.C8230F53@idb.hist.no>
Date: Wed, 09 May 2001 12:30:03 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre7 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: volodya@mindspring.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.LNX.4.20.0105080941010.1137-100000@node2.localnet.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

volodya@mindspring.com wrote:
> 
> I have tried this approach too a couple of years ago. I came to the idea
> that I want some kind of "event reporting" mechanism to know when
> application faults and when other events (like I/O) occurs. Booting is
> just the tip of the iceberg. MOST big apps are seeking on startup because
>    a) their code is spread out all over executable
Page tuning can fix that.  (Have the compiler & linker increase locality
by stuffing related code in the same page.  You want fast paths
stuffed into as few pages as possible, regardless of which functions
the instructions belong to.)  This also cut down on swapping and TLB
misses.
Os/2 gained some nice speedups by doing this.

>    b) don't forget shared libraries..
They can be page tuned too, and they're often partially in
memory aready when starting apps.

>    c) the practice of keeping configuration files in ~/.filename
>       implies - read a little, seek a little.
>    d) GUI apps tend to have a ton of icons.
Putting several in a single file, or even the executable will
help here.

Helge Hafting
