Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbRE1XPt>; Mon, 28 May 2001 19:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261692AbRE1XPj>; Mon, 28 May 2001 19:15:39 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:13066 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S261666AbRE1XP2>; Mon, 28 May 2001 19:15:28 -0400
Date: Tue, 29 May 2001 01:15:22 +0200
From: Kurt Roeckx <Q@ping.be>
To: Vadim Lebedev <vlebedev@aplio.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Potenitial security hole in the kernel
Message-ID: <20010529011522.A3293@ping.be>
In-Reply-To: <003601c0e7bf$41953080$0101a8c0@LAP> <20010529002900.A3190@ping.be> <009601c0e7c5$bd7021f0$0101a8c0@LAP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <009601c0e7c5$bd7021f0$0101a8c0@LAP>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 12:30:03AM +0200, Vadim Lebedev wrote:
> Kurt,
> 
> Maybe i'm missing something but it seems that during execution of the signal
> handler, user mode stack contains kernel mode context...
> Hence the security hole

It's rather complicated how things work.

Both the user and kernel stack are changed.

On the user stack we add a frame from the calling function.  This
just looks a function call.

On the kernel stack we change the last frame so we "return" to
the signal handler from the kernel.

The signal handler then "returns" to the place where the process
did the system call.  You do not return to the kernel.

I hope this helps you understand things better.


Kurt

