Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265212AbSKEVDz>; Tue, 5 Nov 2002 16:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265213AbSKEVDz>; Tue, 5 Nov 2002 16:03:55 -0500
Received: from khms.westfalen.de ([62.153.201.243]:9657 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S265212AbSKEVDy>; Tue, 5 Nov 2002 16:03:54 -0500
Date: 05 Nov 2002 21:57:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8$GqvaL1w-B@khms.westfalen.de>
In-Reply-To: <1118170000.1036458859@flay>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <1118170000.1036458859@flay>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mbligh@aracnet.com (Martin J. Bligh)  wrote on 04.11.02 in <1118170000.1036458859@flay>:

> I had a very brief think about this at the weekend, seeing
> if I could make a big melting pot /proc/psinfo file that did
> seqfile and read everything out in one go, using seq_file
> internally to interate over the tasklist. The most obvious
> problem that sprung to mind seems to be the tasklist locking -
> you obviously can't just hold a lock over the whole thing.

Well, one thing i to make certain you can actually do it with one or two  
system calls. Say, one system call to figure out how big a buffer is  
necessary (essentially, #tasks*size), then one read with a suitably-sized  
buffer. Then have a loop in the kernel that drops the lock as often as  
necessary, and otherwise puts it all in the buffer in one go. (If the  
#tasks grows too fast so it overruns the buffer even with some slack given  
in advance, tough, have a useful return code to indicate that and let ps  
retry.)

I briefly thought about mmap, but I don't think that actually buys  
anything.

MfG Kai
