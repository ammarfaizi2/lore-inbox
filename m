Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262433AbSJESEy>; Sat, 5 Oct 2002 14:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262434AbSJESEy>; Sat, 5 Oct 2002 14:04:54 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:41743
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262433AbSJESEx> convert rfc822-to-8bit; Sat, 5 Oct 2002 14:04:53 -0400
Subject: Re: Unable to kill processes in D-state
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20021005090705.GA18475@stud.ntnu.no>
References: <20021005090705.GA18475@stud.ntnu.no>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 14:11:02 -0400
Message-Id: <1033841462.1247.3716.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 05:07, Thomas Langås wrote:

> We have a fairly large installation on-campus, and we have some problems
> with the current linux-kernel (and older ones) - namely that processes
> entering D-state will stay there forever (given that the right event got
> them there in the first place).  This right event is killing the 
> autofs-daemon.  Doing this will result in heavy load because of lots
> of D-state processes, and you can't kill any of the D-state processes.
> Why shouldn't one be able to kill processes that has entered D-state?
> We have to reboot our servers to get rid of this problem, and it's
> rather annoying.

Because they are in uninterruptible sleep.  They are doing something
important, presumably in a critical section, and have no wake-up path
for signals or errors.

Finally, they probably hold a semaphore.  In short, you cannot kill
them, nor would you want to.

I would simplify the question and ask why are you killing the autofs
daemon?  Clearly this is a recipe for disaster.

	Robert Love


