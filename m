Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSFCUJl>; Mon, 3 Jun 2002 16:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSFCUJk>; Mon, 3 Jun 2002 16:09:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41487 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315472AbSFCUJj>;
	Mon, 3 Jun 2002 16:09:39 -0400
Message-ID: <3CFBCCB1.A8F7D16B@zip.com.au>
Date: Mon, 03 Jun 2002 13:08:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Kravetz <kravetz@us.ibm.com>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
        icollinson@imerge.co.uk, andrea@suse.de
Subject: Re: realtime scheduling problems with 2.4 linux kernel >= 2.4.10
In-Reply-To: <C0D45ABB3F45D5118BBC00508BC292DB09C992@imgserv04> <20020531112847.B1529@w-mikek2.des.beaverton.ibm.com> <m37kljkjys.fsf@averell.firstfloor.org> <20020603090328.A1581@w-mikek2.des.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz wrote:
> 
> ...
> Seems that this tells people to leave a high priority real-
> time shell running on the console.  However, if one can not
> get to the console, then there is no point in leaving a high
> priority shell running there.  Part of the problem may be
> in the definition of 'console'.  Different console implementations
> behave differently.
> 
> Is this something we should 'fix'?  I would envision a 'solution'
> for each console implementation.  OR we could remove the above
> from the man page. :)
> 

keventd is a "process context bottom half handler".  It's designed
for use by interrupt handlers for handing off awkward, occasional
things which need process context.  For example, device hotplugging,
which was the original reason for its introduction.

So it makes sense to give keventd SCHED_RR policy and maximum
priority.  Which should fix this problem as well, yes?

keventd is also being (ab)used for performing disk I/O.
You know who you are ;)  But even given that, I don't expect
that elevating its policy&priority will cause any problems.

-
