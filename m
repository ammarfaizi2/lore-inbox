Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319211AbSHNEoP>; Wed, 14 Aug 2002 00:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319212AbSHNEoP>; Wed, 14 Aug 2002 00:44:15 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:39417 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S319211AbSHNEoO>; Wed, 14 Aug 2002 00:44:14 -0400
Date: Wed, 14 Aug 2002 00:48:06 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@zip.com.au>,
       "H. Peter Anvin" <hpa@zytor.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
Message-ID: <20020814004806.B16322@redhat.com>
References: <20020814003505.A16322@redhat.com> <Pine.LNX.4.44.0208132142310.1208-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208132142310.1208-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Aug 13, 2002 at 09:44:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 09:44:14PM -0700, Linus Torvalds wrote:
> Actually, anybody who uses stdio on syslog messages should be roasted. 
> Over the nice romantic glow of red-hot coal, slowly cooking the stupid git 
> alive.

If you're logging huge messages, sure, that's just plain Stupid.  But for 
messages that are smaller than the size of the stdio buffer an fprintf() 
followed by fflush() gets a single atomic write for most values of libc.

> It's not a bug, it's a feature. A syslog message needs to be atomic, which 
> means that it MUST NOT use the buffering of stdio. 

And that's why we have write(2) on file descriptors.  Having write(2) 
in the form of syslog(2) makes no sense.  It adds to the mass of abi 
that needs to be maintained.  Making the mechanism of writing using the 
existing infrastructure doesn't increase the size of the ABI.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
