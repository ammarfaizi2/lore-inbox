Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312335AbSCUBYr>; Wed, 20 Mar 2002 20:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312336AbSCUBYi>; Wed, 20 Mar 2002 20:24:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38413 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312335AbSCUBYX>;
	Wed, 20 Mar 2002 20:24:23 -0500
Message-ID: <3C9935CA.38E6F56F@zip.com.au>
Date: Wed, 20 Mar 2002 17:22:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Putrid Elevator Behavior 2.4.18/19
In-Reply-To: <20020320120455.A19074@vger.timpanogas.org> <20020320220241.GC29857@matchmail.com> <20020320152008.A19978@vger.timpanogas.org> <20020320152504.B19978@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> 
> ...
> > I will comply.  I tested with pre-3 patches and still saw this problem??
> > Let me go and check the patches I applied to verify, I may not have
> > applied the correct patch.
> >
> > Jeff
> 
> I verified we were using a stock 2.4.18 kernel on the specific system
> without the pre-3 patches installed.  We have been testing with the
> latest patches but not on this system.  We will apply and retest and
> I will verify.
> 

The elevator starvation change went into 2.4.19-pre1 I think.
It shouldn't affect the problem which you've described - that
change improved the situation where tasks were sleeping for
long periods when they want to insert new requests.  But the
problem which you're observing appears to affect already-inserted
requests.

"Several minutes" is downright odd.  From your description
it seems that all the requests are writes, but some of the
writes (at a remote end of the disk) are being bypassed far
too many times.

The bypass count _is_ tunable.  Although it sounds like the logic
has come unstuck in some manner, it would be interesting if
changing the elevator latency parameters for that queue affected
the situation.

Have you experimented with `elvtune -r NNN /dev/foo' and
`elvtune -w NNN /dev/foo'?

-
