Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263730AbREYMH4>; Fri, 25 May 2001 08:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263731AbREYMHr>; Fri, 25 May 2001 08:07:47 -0400
Received: from femail19.sdc1.sfba.home.com ([24.0.95.128]:55171 "EHLO
	femail19.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S263730AbREYMHe>; Fri, 25 May 2001 08:07:34 -0400
Message-ID: <3B0E4B0C.C5F3218F@didntduck.org>
Date: Fri, 25 May 2001 08:07:40 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
In-Reply-To: <200105242110.OAA29766@csl.Stanford.EDU> <200105242308.f4ON8fv8015978@webber.adilger.int> <20010525013303.A21810@gruyere.muc.suse.de> <3B0E4762.7A7A3818@didntduck.org> <20010525135317.B29643@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Fri, May 25, 2001 at 07:52:02AM -0400, Brian Gerst wrote:
> > Actually, you will never get a stack fault exception, since with a flat
> > stack segment you can never get a limit violation.  All you will do is
> > corrupt the data in task struct and cause an oops later on when the
> > kernel tries to use the task struct.  There are only two ways to
> > properly trap a kernel stack overflow:
> 
> In my experience the stack pointer eventually gets corrupted and starts
> pointing to some unmapped area, which gives you a stack fault (admittedly
> a backtrace is a bit hard after that)

You mean a double fault.  #SS is only called when there is a limit
violation on the stack segment or the stack segment is not present.  I
guess you could get a limit violation if it tried to wrap around below
0, but you would get a page fault first.  An unmapped page will always
cause a page fault, but since the stack is still invalid, it would then
cause a double fault.

-- 

						Brian Gerst
