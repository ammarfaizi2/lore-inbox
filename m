Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132955AbRDEQTv>; Thu, 5 Apr 2001 12:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132956AbRDEQTm>; Thu, 5 Apr 2001 12:19:42 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:53338 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S132955AbRDEQTk>; Thu, 5 Apr 2001 12:19:40 -0400
Date: Thu, 5 Apr 2001 17:02:42 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Jani Monoses <jani@virtualro.ic.ro>
cc: linux-kernel@vger.kernel.org
Subject: Re: ERESTARTSYS question.
In-Reply-To: <Pine.LNX.4.10.10104051908540.29169-100000@virtualro.ic.ro>
Message-ID: <Pine.LNX.3.96.1010405165939.30281E-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001, Jani Monoses wrote:
> On Thu, 5 Apr 2001, Bjorn Wesen wrote:
> > ERESTARTSYS is a part of the api between the driver and the
> > signal-handling code in the kernel. It does not reach user-space (provided
> > of course that it's used appropriately in the drivers :) 
> 
> As an example sound/via82cxxx_audio.c returns ERESTARTSYS from
> via_dsp_open() .I suppose this _does_ reach userland right? 

No; system calls do not exit directly to userland, they exit through the
magic in entry.S (confusingly so :). If a signal is pending (which it is,
if down_interruptible fails) the return is made through do_signal, which
rewrites the return value and does the proper restarting.

(down_interruptible means it can be interrupted by a signal, btw - bad
drivers do sleep and semaphoring without _interruptible so if your HW is
bad the process can get stuck irrecoverably in the kernel)

/Bjorn

