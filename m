Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319086AbSHFOMk>; Tue, 6 Aug 2002 10:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319092AbSHFOMk>; Tue, 6 Aug 2002 10:12:40 -0400
Received: from daimi.au.dk ([130.225.16.1]:39567 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S319086AbSHFOMj>;
	Tue, 6 Aug 2002 10:12:39 -0400
Message-ID: <3D4FDA23.90CAB62F@daimi.au.dk>
Date: Tue, 06 Aug 2002 16:16:03 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: manfred@colorfullife.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Warn users about machines with non-working WP bit
References: <3D4F942D.7020100@colorfullife.com>
		<20020806.022813.27560736.davem@redhat.com>
		<3D4FD736.DA443B4B@daimi.au.dk> <20020806.065652.12285252.davem@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Kasper Dupont <kasperd@daimi.au.dk>
>    Date: Tue, 06 Aug 2002 16:03:34 +0200
> 
>    "David S. Miller" wrote:
>    > verify_area() checks aren't enough, consider a threaded application
>    > calling mprotect() while the copy is in progress.
> 
>    Couldn't we just freeze all other processes with the same mm while
>    a copy_to_user is in progress?
> 
> What if we have to sleep and page in some memory from disk?
> 
> Your idea could lead to deadlock in a multi-threaded app.

Why? The page should eventually get into memory from the disk,
at this point the process doing the copy can continue, and
when it finishes the other processes gets waked up. While the
copy_to_user is in progress all the processes witht this mm
should be in noninterruptible sleep. The sleeping procces
doesn't need to do anything to get the page into memory, so I
cannot see the problem.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
