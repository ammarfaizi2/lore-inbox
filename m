Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSEQCSE>; Thu, 16 May 2002 22:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSEQCSD>; Thu, 16 May 2002 22:18:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35591 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315277AbSEQCSC>;
	Thu, 16 May 2002 22:18:02 -0400
Message-ID: <3CE46914.F4547F16@zip.com.au>
Date: Thu, 16 May 2002 19:21:08 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Faure <paul@engsoc.org>
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
In-Reply-To: <20020516215744.GI1025@dualathlon.random> <Pine.LNX.4.33.0205162037500.21864-100000@lager.engsoc.carleton.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Faure wrote:
> 
> It would seem that it only occurs when running the application (that takes
> 100% of the CPU) as root.

That's because without root, the application cannot raise its
scheuling priority and it cannot change to realtime policy.

So the problem would appear to be that your networking *requires*
ksoftirqd services to function.  Either:

1) The driver is bust - its hard_start_xmit() function is failing
   frequently, and relying on ksoftirqd to get things done (I think;
   it's been a while).  Or

2) Something is wrong with the ksoftirqd design.  Or

3) Red Hat fiddled with ksoftirqd and broke it.

I'd be inclined to suspect 1).

> As for testing it with other cards, I only have this one card.
> 

That's a shame.

-
